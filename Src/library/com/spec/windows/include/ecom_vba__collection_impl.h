/*-----------------------------------------------------------
Implemented `VBA__Collection' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_VBA__COLLECTION_IMPL_H__
#define __ECOM_VBA__COLLECTION_IMPL_H__
class VBA__Collection_impl;

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_VBA__Collection.h"

class VBA__Collection_impl
{
public:
	VBA__Collection_impl (IUnknown * a_pointer);
	virtual ~VBA__Collection_impl ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_item1(  /* [in] */ VARIANT * index );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add(  /* [in] */ VARIANT * a_item,  /* [in] */ VARIANT * key,  /* [in] */ VARIANT * before,  /* [in] */ VARIANT * after );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_count();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remove(  /* [in] */ VARIANT * index );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_new_enum();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	VBA__Collection * p_VBA__Collection;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};

#endif