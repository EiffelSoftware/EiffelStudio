/*-----------------------------------------------------------
Implemented `VBA__ErrObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_VBA__ERROBJECT_IMPL_H__
#define __ECOM_VBA__ERROBJECT_IMPL_H__
class VBA__ErrObject_impl;

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_VBA__ErrObject.h"

class VBA__ErrObject_impl
{
public:
	VBA__ErrObject_impl (IUnknown * a_pointer);
	virtual ~VBA__ErrObject_impl ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_number();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_number12(  /* [in] */ EIF_INTEGER arg_1 );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_source();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_source13(  /* [in] */ EIF_OBJECT arg_1 );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_description14(  /* [in] */ EIF_OBJECT arg_1 );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_help_file();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_help_file15(  /* [in] */ EIF_OBJECT arg_1 );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_help_context();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_help_context16(  /* [in] */ EIF_INTEGER arg_1 );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_raise(  /* [in] */ EIF_INTEGER a_number,  /* [in] */ VARIANT * a_source,  /* [in] */ VARIANT * a_description,  /* [in] */ VARIANT * a_help_file,  /* [in] */ VARIANT * a_help_context );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_clear();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_dll_error();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	VBA__ErrObject * p_VBA__ErrObject;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};

#endif