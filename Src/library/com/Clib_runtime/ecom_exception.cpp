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

Formatter::Formatter()
{
}

Formatter::~Formatter()
{
}

EIF_OBJ Formatter::ccom_format_message( EIF_INTEGER Code )
{
	LPVOID *szErrorMessage;
	
	if( FormatMessage(
					FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
					NULL,
					( DWORD )Code,
					MAKELANGID( LANG_NEUTRAL, SUBLANG_DEFAULT ), // Default language
					( LPTSTR )&szErrorMessage,
					0,
					NULL ) == 0)
		*szErrorMessage =( LPVOID )( "No help available" );
	return makestr( ( char* )szErrorMessage, sizeof( szErrorMessage ));
}
