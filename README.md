![alt tag](https://raw.githubusercontent.com/lateralblast/ordog/master/ordog.jpg)

ORDOG
======

Oracle solaris Dependency for Online services Grapher

Information
-----------

Ruby script to graph service dependencies for online/enabled services

License
-------

This software is licensed as CC-BA (Creative Commons By Attrbution)

http://creativecommons.org/licenses/by/4.0/legalcode

Usage
-----

```
$ ordog.rb -[h|V] -i INPUT -o OUPUT

-h: Print usage information
-V: Print version information
-i: INPUT (input file)
-o: OUPUT (ouput file - png)
```

Examples
========

Process piped input:

```
$ svcs -l | ordog
```

Process input from file:

```
$ ordog -i svcs-l.out
```

Process from input file and redirect to a named file:

```
$ ordog -i svcs-l.out -o example.png
```

Example output:

https://github.com/richardatlateralblast/ssdg/blob/master/example.png

Requirements
------------

Ruby gems:

- graphviz
- getopt/std

