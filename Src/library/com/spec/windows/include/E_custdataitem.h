//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_custdataitem.h
//
//  Contents: Accessors of GUID structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_CUST_DATA_ITEM_H_INC__
#define __ECOM_E_CUST_DATA_ITEM_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ccom_custdataitem_guid(_ptr_) ((EIF_POINTER) &(((CUSTDATAITEM *)_ptr_)->guid))
#define ccom_custdataitem_variant(_ptr_) ((EIF_POINTER) &(((CUSTDATAITEM *)_ptr_)->varValue))

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_CUST_DATA_ITEM_H_INC__
