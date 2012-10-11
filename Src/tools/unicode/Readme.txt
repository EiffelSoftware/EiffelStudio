Unicode Helper Generator - Version: 1.0
Copyright Eiffel Software 2012. All Rights Reserved.

USAGE:
   unicode_helper_generator.exe -i <file> [-d <density>] [-p <template>] [-o <dir>] [-s] [-v] [-nologo]

OPTIONS:
   -i --input            : UnicodeData.txt file
                           <file>: Name of UnicodeData.txt file
   -d --density          : Density for tables (Optional)
                           <density>: Density of table as a ratio
   -p --property_template: Template used for generation of character properties (Optional)
                           <template>: Template file
   -o --output_directory : Directory where files will be generated (Optional)
                           <dir>: Directory for outputs
   -s --statistics       : Display statistics (Optional)
   -? --help             : Display usage information. (Optional)
   -v --version          : Displays version information. (Optional)
      --nologo           : Supresses copyright information. (Optional)


The tool read the file UnicodeData.txt from the Unicode standard. You should download that file to your computer prior launching this tool. For example for revision 6.2.0, you can get the file from:

	http://www.unicode.org/Public/6.2.0/ucd/UnicodeData.txt

Then using `character_32_property.template' located in this directory, it will generate the CHARACTER_32_PROPERTY class in the current working directory or a directory of your choosing. This class is used by CHARACTER_32 and the various STRING_32 classes to provide some basic operations on Unicode characters from Eiffel code.
