/*-----------------------------------------------------------
Implemented `IEnumVARIANT1' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_IENUMVARIANT1_IMPL_PROXY_H__
#define __ECOM_IENUMVARIANT1_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {
#endif

class IEnumVARIANT1_impl_proxy;

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class IEnumVARIANT1_impl_proxy
{
public:
	IEnumVARIANT1_impl_proxy (IUnknown * a_pointer);
	virtual ~IEnumVARIANT1_impl_proxy ();

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
	void ccom_clone1(  /* [out] */ EIF_OBJECT ppenum );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	IEnumVARIANT * p_IEnumVARIANT1;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};


#ifdef __cplusplus
}
#endif
#endif