README.txt - Intro to the AEL_PRINTF cluster

The Amalasoft Eiffel Printf Cluster is a collection of classes that implements
a printf facility for the Eiffel language.  It depends on the Eiffel base 
libraries (available in open source or commercial form from Eiffel 
Software www.eiffel.com) and is, like other Eiffel code, portable across 
platforms.

The printf cluster does not include an equivalent to scanf at this time.

The printf cluster does not support internationalization at this time.

     ------------------------------------------------------------

The cluster includes the following classes:

  AEL_PRINTF
    The "face" of the cluster; the class to be inherited or instantiated
    by classes needing the facility.
    AEL_PRINTF offers the key client features including printf, sprintf,
    fprintf and aprintf ("append" printf, that returns a formatted string),
    and features for generating hexadecimal dumps, as well as the key error
    handling routines.
    There is typically no need for clients to access directly any other
    class from the cluster.

    printf-like features presented by AEL_PRINTF include:

      aprintf - "append printf"
        Accepts a format specifier and arg list, and returns
        the formatted string result

      fprintf - "file printf"
        Accepts an opened file, a format specifier and arg list,
        and writes the formatted string to the file

      printf  - "printf"
        Accepts a format specifier and arg list, and writes the
        formatted string result to default output

      sprintf - "string printf"
        Accepts a destination STRING, a format specifier and arg list,
        and writes the formatted string into the destination string.

      axdump  - "hex dump"
        Accepts a source buffer, an options string and range/sequencing
        arguments, and returns as result a hexadecimal dump of the source
        buffer as a formatted string

      amemdump - "memory dump"
        Accepts  POINTER to a memory location, the size of memory
        to be processed, an options string, an effective starting address
        (for presentation) and a line spacing specifier, and returns
        a hexadecimal dump of the memory provided address given as
        a formatted string

      lxdump   - "list dump"
        Accepts a source buffer, options string, start/end sequence numbers
        and effective start address (for presentation) and returns a
        hexadecimal dump of the source buffer as a list of (rows of) strings

      amemdump - "memory dump"
        Accepts  POINTER to a memory location, the size of memory
        to be processed, an options string, an effective starting address
        (for presentation) and a line spacing specifier, and returns
        a hexadecimal dump of the memory provided address given as
        a list of (rows of) strings

      print_line, printline
        Accepts a detachable ANY as argument and writes it to default
        output (using) print, appending a newline character

    Additional features usable by clients/descendents include those by
    which to set global printf paramers.  These include:

      set_default_printf_fill_char
        Sets the character to be used for filling space in formatted strings
        to the given value (blank by default)

      reset_default_printf_fill_char
        Sets the character to be used for filling space in formatted strings
        to default value (blank)

      set_default_printf_decimal_separator
        Sets the character used by printf to denote the decimal (radix)
        point to the given value ('.' by default)

      reset_default_printf_decimal_separator
        Resets the character used by printf to denote the decimal (radix)
        point to the default value ('.')

      set_default_printf_list_delimiter
        Sets the string used by printf to denote the delimit items
        in a formatted list to the given value (", " by default)

      reset_default_printf_list_delimiter
        Resets the string used by printf to denote the delimit items
        in a formatted list to the default value (", ")

      set_default_printf_thousands_delimiter
        Sets the string used by printf to denote the delimit digit groups
        of thousands (3 decimal digits) in a formatted decimal to the given
        value ("," by default)

      reset_default_printf_thousands_delimiter
        Resets the string used by printf to denote the delimit digit groups
        of thousands (3 decimal digits) in a formatted decimal to the default
        value (",")

      set_printf_client_error_agent
        Sets the procedure to call when printf encounters a format error.
        Errors encountered are always recorded in last_printf_errors, whether
        the value for this agent is defined or not.

  AEL_PF_FORMATTING_CONSTANTS
    Provides constant values used by the other members of the cluster
    It holds the shared error list (last_printf_errors) and provides a
    shared (onced) instance of AEL_PF_FORMATTING_ROUTINES.

  AEL_PF_FORMATTING_ROUTINES
    Provides the core formatting routines used by the front-end routines
    in AEL_PRINTF.

  AEL_PF_FORMAT_ERROR
    Encapsulation of a single error instance (for when a run-time error
    occurs, due to mismatched parameters and such)

  AEL_PF_FORMAT_ERROR_SUPPORT
    Provides routines to interface with the shared error list

  AEL_PF_FORMAT_PARAM
    The heart of the cluster.  Provides format string parsing and
    interpretation, argument coordination and output routines

  AEL_PF_FORMAT_TOKEN
    A simple class representing a token within the format string
    argument.

     ------------------------------------------------------------

 The printf.ecf and printf-safe.ecf files define the library form of
 the cluster.

 Check the HISTORY.txt file for latest changes

     ------------------------------------------------------------

 Refer to AEL_Printf.pdf for a detailed description of the options, syntax
 and examples.

     ------------------------------------------------------------
