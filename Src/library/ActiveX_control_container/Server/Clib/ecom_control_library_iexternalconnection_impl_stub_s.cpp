/*-----------------------------------------------------------
Implemented `IExternalConnection' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IExternalConnection_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IExternalConnection_ = {0x00000019,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IExternalConnection_impl_stub::IExternalConnection_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IExternalConnection_impl_stub::~IExternalConnection_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IExternalConnection_impl_stub::AddConnection(  /* [in] */ ULONG extconn, /* [in] */ ULONG reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{

	EIF_INTEGER tmp_extconn = (EIF_INTEGER)extconn;
	EIF_INTEGER tmp_reserved = (EIF_INTEGER)reserved;
	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("add_connection", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_function) (eif_access (eiffel_object), (EIF_INTEGER)tmp_extconn, (EIF_INTEGER)tmp_reserved);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "add_connection", EIF_INTEGER);
	
	return (ULONG)tmp_value;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IExternalConnection_impl_stub::ReleaseConnection(  /* [in] */ ULONG extconn, /* [in] */ ULONG reserved, /* [in] */ LONG f_last_release_closes )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{

	EIF_INTEGER tmp_extconn = (EIF_INTEGER)extconn;
	EIF_INTEGER tmp_reserved = (EIF_INTEGER)reserved;
	EIF_INTEGER tmp_f_last_release_closes = (EIF_INTEGER)f_last_release_closes;
	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("release_connection", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER))eiffel_function) (eif_access (eiffel_object), (EIF_INTEGER)tmp_extconn, (EIF_INTEGER)tmp_reserved, (EIF_INTEGER)tmp_f_last_release_closes);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "release_connection", EIF_INTEGER);
	
	return (ULONG)tmp_value;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IExternalConnection_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IExternalConnection_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IExternalConnection_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IExternalConnection*>(this);
	else if (riid == IID_IExternalConnection_)
		*ppv = static_cast<ecom_control_library::IExternalConnection*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif