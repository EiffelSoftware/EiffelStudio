/*-----------------------------------------------------------
Implemented `IEnumVARIANT' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_IENUMVARIANT_IMPL_H__
#define __ECOM_IENUMVARIANT_IMPL_H__
#ifdef __cplusplus
extern "C" {
#endif

class IEnumVARIANT_impl;

#include "eif_com.h"

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

class IEnumVARIANT_impl
{
public:
	IEnumVARIANT_impl (IUnknown * a_pointer);
	virtual ~IEnumVARIANT_impl ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_next(  /* [in] */ EIF_INTEGER celt,  /* [in] */ VARIANT * rgvar,  /* [out] */ EIF_OBJECT pcelt_fetched );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_skip(  /* [in] */ EIF_INTEGER celt );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_reset();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_POINTER ccom_clone1();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	IEnumVARIANT * p_IEnumVARIANT;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};


#ifdef __cplusplus
}
#endif

#endif