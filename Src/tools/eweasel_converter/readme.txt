Eiffel Eweasel Converter - Read Me
--------------------------------------

1.0 About:
----------
The Eiffel Eweasel Converter is a tool that can be used to generate eweasel test case class files
that can be executed in Eiffel Studio 6.3 (or greater).


2.0 Command-Line Options
------------------------

There are two command-line options, please use

  eweasel_converter /?

for more information.

3.0 Example
------------------------

Typically the command line is:

eweasel_converter --source c:\your_eweasel_dir\tests --dest c:\where_files_will_be_generated

Note the value of --source and --dest option must be FULL path of directory

4.0 FAQ
--------------------------

If you get following texts when executing the command:

Error: tcf file not exists in dir: E:\es\trunk\eweasel\tests\.
Error: tcf file not exists in dir: E:\es\trunk\eweasel\tests\..
Error: tcf file not exists in dir: E:\es\trunk\eweasel\tests\.svn
Error: tcf file not exists in dir: E:\es\trunk\eweasel\tests\DONT_DELETE

This is normal, don't worry. 


