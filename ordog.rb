#!/usr/bin/env ruby

# Name:         ordog (Oracle solaris Dependency for Online services Grapher)
# Version:      0.0.1
# Release:      1
# License:      CC-BA (Creative Commons By Attrbution)
#               http://creativecommons.org/licenses/by/4.0/legalcode
# Group:        System
# Source:       N/A
# URL:          http://lateralblast.com.au/
# Distribution: UNIX
# Vendor:       Lateral Blast
# Packager:     Richard Spindler <richard@lateralblast.com.au>
# Description:  Ruby script that uses Graphvix to graph service dependencies

require 'graphviz'
require 'getopt/std'

def graph_svc(svcs_info,output_file)
  g = GraphViz.new(:G)
  g.node[:shape] = "circle"
  svcs_info.each do |svc|
    if svc.match(/state\s+online/) and svc.match(/enabled\s+true/)
      svc = svc.gsub(/^\s+/,'')
      if svc.match(/^svc/)
        svc_name = svc.split(/\n/)[0]
        svc_name = svc_name.split(/:/)[1]
        color    = "black"
        case svc_name
        when /application/
          color = "orange"
        when /log/
          color = "red"
        when /net/
          color = "blue"
        when /system/
          color = "brown"
        when /milestone/
          color = "green"
        when /platform/
          color = "purple"
        when /localhost/
          color = "cyan"
        end
        svc_name = svc_name.gsub(/^\//,'')
        svc_name = svc_name.gsub(/^\//,'')
        svc_name = svc_name.gsub(/\//,'\/\n')
        g.add_nodes(svc_name)[:color => color]
        dependencies = svc.split(/dependency/)
        for counter in 1..(dependencies.length)
          dependency_list = []
          dependency = dependencies[counter]
          if dependency
            if dependency.match(/online/)
              dependency_1 = dependency.split(/\s+/)[2]
              dependency_list.push(dependency_1)
              dependency_2 = dependency.split(/\s+/)[4]
              dependency_3 = dependency.split(/\s+/)[6]
              if dependency_2
                dependency_list.push(dependency_2)
              end
              if dependency_3
                dependency_list.push(dependency_3)
              end
              dependency_list.each do |dependency_name|
                dependency_name = dependency_name.split(/:/)[1]
                dependency_name = dependency_name.gsub(/^\//,'')
                dependency_name = dependency_name.gsub(/^\//,'')
                dependency_name = dependency_name.gsub(/\//,'\/\n')
                g.add_edges(svc_name,dependency_name)
              end
            end
          end
        end
      end
    end
  end
  g.output(:png => output_file)
  return
end

def print_version()
  file_array=IO.readlines $0
  version  = file_array.grep(/^# Version/)[0].split(":")[1].gsub(/^\s+/,'').chomp
  packager = file_array.grep(/^# Packager/)[0].split(":")[1].gsub(/^\s+/,'').chomp
  name     = file_array.grep(/^# Name/)[0].split(":")[1].gsub(/^\s+/,'').chomp
  puts name+" v. "+version+" "+packager
end

def print_usage()
  puts
  puts "Usage: "+$0+" -[h|V] -i INPUT -o OUPUT"
  puts
  puts "-h: Print usage information"
  puts "-V: Print version information"
  puts "-i: INPUT (input file)"
  puts "-o: OUPUT (ouput file - png)"
  puts
  return
end

opt = Getopt::Std.getopts("hi:o:")

if !ARGF or !opt["i"]
  print_version()
  print_usage()
  exit
end

if opt["i"]
  input_file = opt["i"]
  svcs_info  = IO.readlines(input_file)
  svcs_info  = svcs_info.join.split(/fmri/)
else
  svcs_info = ARGF.read
  svcs_info = svcs_info.split(/fmri/)
end

if opt["o"]
  output_file = opt["o"]
else
  output_file = $0+".png"
end

if output_file
  graph_svc(svcs_info,output_file)
end
