//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_generic_interface.h
//
//  Contents:	Declaration of generic interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_GENERIC_INTERFACE_H_INC__
#define __ECOM_E_GENERIC_INTERFACE_H_INC__

#include <oaidl.h>
#include <objbase.h>
#include <eif_eiffel.h>
#include "eif_except.h"
#include "ecom_rt_globals.h"

class E_generic_interface
{
	public:
		// Commands
		E_generic_interface () {};
		E_generic_interface (IUnknown * other);
		~E_generic_interface ();
		
		// Queries
		EIF_POINTER ccom_item ();
	private:
		IUnknown * item;
};

#endif // !__ECOM_E_GENERIC_INTERFACE_H_INC__
