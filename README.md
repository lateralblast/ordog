ssdg
====

Solaris Service Dependency Graph

Ruby script to graph service dependencies for online/enabled services

Usage
=====

	ssdg.rb -[h|V] -i INPUT -o OUPUT

	-h: Print usage information
	-V: Print version information
	-i: INPUT (input file)
	-o: OUPUT (ouput file - png)

Examples
========

Process piped input:

	$ svcs -l | ssdg

Process input from file:

	$ ssdg -i svcs-l.out

Process from input file and redirect to a named file:

	$ ssdg -i svcs-l.out -o example.png

