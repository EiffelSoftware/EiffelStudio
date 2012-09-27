README.txt - Intro to the AEL_PRINTF cluster

The Amalasoft Eiffel Printf Cluster is a collection of classes that implements
a printf facility for the Eiffel language.  It depends on the Eiffel base 
libraries (available in open source or commercial form from Eiffel 
Software www.eiffel.com) and is, like other Eiffel code, portable across 
platforms.

The printf cluster does not include an equivalent to scanf at this time.

The printf cluster does not support STRING_32 at this time, nor does it
support international character sets.

     ------------------------------------------------------------

The cluster includes the following classes:

  AEL_PRINTF
    The "face" of the cluster; the class to be inherited by classes
    needing the facility (it can also be instantiated as a supplier).
    AEL_PRINTF offers the key client features including printf, sprintf,
    fprintf and aprintf ("append" printf, that returns a formatted string),
    as well as the key error handling routines.
    There is typically no need for clients to access directly any other
    class from the cluster.

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

 Check the HISTORY.txt file for latest changes

     ------------------------------------------------------------

 Refer to AEL_Printf.pdf for a detailed description of the options, syntax
 and examples.

     ------------------------------------------------------------
