/*-----------------------------------------------------------
Implemented `ISequentialStream' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ISequentialStream_impl_stub_s.h"
static int return_hr_value;

static const IID IID_ISequentialStream_ = {0x0c733a30,0x2a1c,0x11ce,{0xad,0xe5,0x00,0xaa,0x00,0x44,0x77,0x3d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ISequentialStream_impl_stub::ISequentialStream_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ISequentialStream_impl_stub::~ISequentialStream_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISequentialStream_impl_stub::RemoteRead(  /* [out] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_read )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pv = NULL;
	if (pv != NULL)
	{
		tmp_pv = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (pv, NULL));
	}
	EIF_INTEGER tmp_cb = (EIF_INTEGER)cb;
	EIF_OBJECT tmp_pcb_read = NULL;
	if (pcb_read != NULL)
	{
		tmp_pcb_read = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcb_read, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_read", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pv != NULL) ? eif_access (tmp_pv) : NULL), (EIF_INTEGER)tmp_cb, ((tmp_pcb_read != NULL) ? eif_access (tmp_pcb_read) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_character (((tmp_pv != NULL) ? eif_wean (tmp_pv) : NULL), pv);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcb_read != NULL) ? eif_wean (tmp_pcb_read) : NULL), pcb_read);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISequentialStream_impl_stub::RemoteWrite(  /* [in] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_written )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pv = NULL;
	if (pv != NULL)
	{
		tmp_pv = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (pv, NULL));
	}
	EIF_INTEGER tmp_cb = (EIF_INTEGER)cb;
	EIF_OBJECT tmp_pcb_written = NULL;
	if (pcb_written != NULL)
	{
		tmp_pcb_written = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcb_written, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_write", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pv != NULL) ? eif_access (tmp_pv) : NULL), (EIF_INTEGER)tmp_cb, ((tmp_pcb_written != NULL) ? eif_access (tmp_pcb_written) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcb_written != NULL) ? eif_wean (tmp_pcb_written) : NULL), pcb_written);
	if (tmp_pv != NULL)
		eif_wean (tmp_pv);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ISequentialStream_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::ISequentialStream_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISequentialStream_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::ISequentialStream*>(this);
	else if (riid == IID_ISequentialStream_)
		*ppv = static_cast<ecom_control_library::ISequentialStream*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif