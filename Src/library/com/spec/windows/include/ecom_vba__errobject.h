/*-----------------------------------------------------------
No description available.
-----------------------------------------------------------*/

#ifndef __ECOM_VBA__ERROBJECT_H__
#define __ECOM_VBA__ERROBJECT_H__
class VBA__ErrObject;

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

class VBA__ErrObject : public IDispatch
{
public:
	VBA__ErrObject () {};
	~VBA__ErrObject () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Number( long *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Number( long arg_1 ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Source( BSTR *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Source( BSTR arg_1 ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Description( BSTR *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Description( BSTR arg_1 ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HelpFile( BSTR *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HelpFile( BSTR arg_1 ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HelpContext( long *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HelpContext( long arg_1 ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Raise( long a_number,VARIANT * a_source,VARIANT * a_description,VARIANT * a_help_file,VARIANT * a_help_context ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clear(  ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LastDllError( long *ret_value ) = 0;



protected:


private:


};

#endif