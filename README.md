SmartLog Parser 
=========

This project includes a namespaced library called `SmartLog` which includes a few de-coupled
classes for Parsing, Counting and Presenting a simple logfile as per instructions given.

### Running the script

`./bin/parser path_to.log`

### Possible improvements

- Add a gemspec and package it as a re-usable gem
- Create "abstract" classes for each of the main Parse, Count, Present to define the surface API needing to be implemented by the actual class
- Move the main classes into a some sort of modularized hierarchy so each lives in its own namespace/directory (parsers/, presenters/, counters/)
- More tests?
