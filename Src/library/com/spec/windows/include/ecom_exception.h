//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		ecom_exception.h
//
//  Contents:	Externals definition for class ECOM_EXCEPTION
//
//
//--------------------------------------------------------------------------


#ifndef __ECOM_EXCEPTION_H_INC__
#define __ECOM_EXCEPTION_H_INC__

#include "eif_eiffel.h"

class  Formatter
{
public:
	Formatter();
	virtual ~Formatter();
	EIF_OBJ ccom_format_message( EIF_INTEGER Code );
	char* c_format_message( long Code );
};

#endif // !__ECOM_EXCEPTION_H_INC__

