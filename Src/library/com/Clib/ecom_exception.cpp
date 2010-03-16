/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "ecom_exception.h"
#include "eif_eiffel.h"
#include <wtypes.h>

#ifdef __cplusplus
extern "C" {
#endif

Formatter f;
char string_buffer [500];

#ifdef __cplusplus
}
#endif

Formatter::Formatter()
{
};
//--------------------------------------------------------------------------------

Formatter::~Formatter()
{
};
//--------------------------------------------------------------------------------

EIF_REFERENCE Formatter::ccom_format_message( EIF_INTEGER Code )
{ 
	char* szMessage = c_format_message ((long) Code);
	int i = strlen ((char *)string_buffer);
	return makestr (szMessage, i);
};
//--------------------------------------------------------------------------------

char* Formatter::c_format_message( long Code )
{
  LPVOID szErrorMessage;
  
  sprintf (string_buffer, "0x%.8x  ", Code);
  
  if( FormatMessage(
          FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
          NULL,
          ( DWORD )Code,
          MAKELANGID( LANG_NEUTRAL, SUBLANG_DEFAULT ), // Default language
          ( LPTSTR )&szErrorMessage,
          0,
          NULL ) != 0)
  {
    strcat (string_buffer, (char*)szErrorMessage);
    string_buffer [499] = '\0';
    
    LocalFree(szErrorMessage);
  }
  
  
  return ( char* )string_buffer;
};
//--------------------------------------------------------------------------------
  
EIF_INTEGER Formatter::ccom_hresult (char * exception_code_name) 
{
  char *stopstring = NULL;
  long result = 0, high_bits = 0, low_bits = 0;
  char high_str [7];
  
  if (NULL != exception_code_name)
  {
    strncpy (high_str, exception_code_name, 6);
    high_str [6] = '\0';

    high_bits = strtol (high_str, &stopstring, 16);
    low_bits = strtol (exception_code_name + 6, &stopstring, 16);
    result = (high_bits << 16) + low_bits;
  }
  return (EIF_INTEGER)result;
};
//--------------------------------------------------------------------------------

EIF_REFERENCE Formatter::ccom_hresult_to_string( EIF_INTEGER Code )
{ 
  sprintf (string_buffer, "0x%.8x  ", Code);
  return makestr( ( char* )string_buffer, strlen( (char *)string_buffer ));
};
//--------------------------------------------------------------------------------

HRESULT Formatter::hresult (int code)

// Convert to HRESULT from Eiffel exception code.
{
  HRESULT result = 0;
  if (code != EN_PROG)
  {
    result = MAKE_HRESULT (1, FACILITY_ITF, 1024 + code);
  }
  else
  {
      GTCX
    if ((echval != 0) && (echtg != (char *) 0))
      result = ccom_hresult (echtg); 

    if (0 == result)
      result = CO_E_ERRORINAPP;
  }
  return result;
};
//--------------------------------------------------------------------------------
