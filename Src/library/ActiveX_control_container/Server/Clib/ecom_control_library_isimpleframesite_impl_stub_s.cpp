/*-----------------------------------------------------------
Implemented `ISimpleFrameSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ISimpleFrameSite_impl_stub_s.h"
static int return_hr_value;

static const IID IID_ISimpleFrameSite_ = {0x742b0e01,0x14e6,0x101b,{0x91,0x4e,0x00,0xaa,0x00,0x30,0x0c,0xab}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ISimpleFrameSite_impl_stub::ISimpleFrameSite_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ISimpleFrameSite_impl_stub::~ISimpleFrameSite_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISimpleFrameSite_impl_stub::PreMessageFilter(  /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ UINT msg, /* [in] */ UINT wp, /* [in] */ LONG lp, /* [out] */ LONG * pl_result, /* [out] */ ULONG * pdw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_POINTER tmp_h_wnd = (EIF_POINTER)h_wnd;
	EIF_INTEGER tmp_msg = (EIF_INTEGER)msg;
	EIF_INTEGER tmp_wp = (EIF_INTEGER)wp;
	EIF_INTEGER tmp_lp = (EIF_INTEGER)lp;
	EIF_OBJECT tmp_pl_result = NULL;
	if (pl_result != NULL)
	{
		tmp_pl_result = eif_protect (rt_ce.ccom_ce_pointed_long (pl_result, NULL));
	}
	EIF_OBJECT tmp_pdw_cookie = NULL;
	if (pdw_cookie != NULL)
	{
		tmp_pdw_cookie = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_cookie, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("pre_message_filter", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_h_wnd, (EIF_INTEGER)tmp_msg, (EIF_INTEGER)tmp_wp, (EIF_INTEGER)tmp_lp, ((tmp_pl_result != NULL) ? eif_access (tmp_pl_result) : NULL), ((tmp_pdw_cookie != NULL) ? eif_access (tmp_pdw_cookie) : NULL));
	rt_ec.ccom_ec_pointed_long (((tmp_pl_result != NULL) ? eif_wean (tmp_pl_result) : NULL), pl_result);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_cookie != NULL) ? eif_wean (tmp_pdw_cookie) : NULL), pdw_cookie);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISimpleFrameSite_impl_stub::PostMessageFilter(  /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ UINT msg, /* [in] */ UINT wp, /* [in] */ LONG lp, /* [out] */ LONG * pl_result, /* [in] */ ULONG dw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_POINTER tmp_h_wnd = (EIF_POINTER)h_wnd;
	EIF_INTEGER tmp_msg = (EIF_INTEGER)msg;
	EIF_INTEGER tmp_wp = (EIF_INTEGER)wp;
	EIF_INTEGER tmp_lp = (EIF_INTEGER)lp;
	EIF_OBJECT tmp_pl_result = NULL;
	if (pl_result != NULL)
	{
		tmp_pl_result = eif_protect (rt_ce.ccom_ce_pointed_long (pl_result, NULL));
	}
	EIF_INTEGER tmp_dw_cookie = (EIF_INTEGER)dw_cookie;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("post_message_filter", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_h_wnd, (EIF_INTEGER)tmp_msg, (EIF_INTEGER)tmp_wp, (EIF_INTEGER)tmp_lp, ((tmp_pl_result != NULL) ? eif_access (tmp_pl_result) : NULL), (EIF_INTEGER)tmp_dw_cookie);
	rt_ec.ccom_ec_pointed_long (((tmp_pl_result != NULL) ? eif_wean (tmp_pl_result) : NULL), pl_result);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ISimpleFrameSite_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::ISimpleFrameSite_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISimpleFrameSite_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::ISimpleFrameSite*>(this);
	else if (riid == IID_ISimpleFrameSite_)
		*ppv = static_cast<ecom_control_library::ISimpleFrameSite*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif