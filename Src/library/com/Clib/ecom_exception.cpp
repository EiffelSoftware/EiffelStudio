//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		ecom_exception.cpp
//
//  Contents:	Error message generation.
//
//
//--------------------------------------------------------------------------

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
}

Formatter::~Formatter()
{
}

EIF_OBJ Formatter::ccom_format_message( EIF_INTEGER Code )
{
	LPVOID szErrorMessage;
	char hresult [12];
	sprintf (hresult, "0x%.8x", Code);
	
	if( FormatMessage(
					FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
					NULL,
					( DWORD )Code,
					MAKELANGID( LANG_NEUTRAL, SUBLANG_DEFAULT ), // Default language
					( LPTSTR )&szErrorMessage,
					0,
					NULL ) == 0)
		strcpy (string_buffer, "No help available" );
	else
	{
		strncpy (string_buffer, ( char* )szErrorMessage, 469);
		string_buffer [469] = '\0';
		LocalFree(szErrorMessage);
	}
	
	strcat (string_buffer, " HRESULT = ");
	strcat (string_buffer, hresult);
	
	return makestr( ( char* )string_buffer, strlen( (char *)szErrorMessage ));
}

char* Formatter::c_format_message( long Code )
{
	LPVOID szErrorMessage;
	char hresult [12];
	sprintf (hresult, "0x%.8x", Code);
	
	if( FormatMessage(
					FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
					NULL,
					( DWORD )Code,
					MAKELANGID( LANG_NEUTRAL, SUBLANG_DEFAULT ), // Default language
					( LPTSTR )&szErrorMessage,
					0,
					NULL ) == 0)
		strcpy (string_buffer, "No help available" );
	else
	{
		strncpy (string_buffer, ( char* )szErrorMessage, 469);
		string_buffer [469] = '\0';
		LocalFree(szErrorMessage);
	}
	
	strcat (string_buffer, " HRESULT = ");
	strcat (string_buffer, hresult);
	
	return ( char* )string_buffer;
}
	
