//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_automation_interface.h
//
//  Contents: Declaration of automation interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_AUTOMATION_INTERFACE_H_INC__
#define __ECOM_E_AUTOMATION_INTERFACE_H_INC__

#include <oaidl.h>
#include <objbase.h>
#include <eif_eiffel.h>
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_automation_interface
{
  public:
    // Commands
    E_automation_interface () {};
    E_automation_interface (IDispatch * other);
    ~E_automation_interface ();
    
    // Queries
    EIF_POINTER ccom_item ();
  private:
    IDispatch * item;
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_AUTOMATION_INTERFACE_H_INC__
