svcg
===-

Solaris ServiCe dependeny Graph

Ruby script to graph service dependencies for online/enabled services

Usage
=====

	svcg.rb -[h|V] -i INPUT -o OUPUT

	-h: Print usage information
	-V: Print version information
	-i: INPUT (input file)
	-o: OUPUT (ouput file - png)

Examples
========

Process piped input:

	$ svcs -l | svcg

Process input from file:

	$ svcg -i svcs-l.out

Process from input file and redirect to a named file:

	$ svcg -i svcs-l.out -o example.png

