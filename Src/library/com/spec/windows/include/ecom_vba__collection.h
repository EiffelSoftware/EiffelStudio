/*-----------------------------------------------------------
No description available.
-----------------------------------------------------------*/

#ifndef __ECOM_VBA__COLLECTION_H__
#define __ECOM_VBA__COLLECTION_H__
class VBA__Collection;

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

class VBA__Collection : public IDispatch
{
public:
	VBA__Collection () {};
	~VBA__Collection () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Item1( VARIANT * index,VARIANT *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Add( VARIANT * a_item,VARIANT * key,VARIANT * before,VARIANT * after ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Count( long *ret_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Remove( VARIANT * index ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _NewEnum( IUnknown * *ret_value ) = 0;



protected:


private:


};

#endif