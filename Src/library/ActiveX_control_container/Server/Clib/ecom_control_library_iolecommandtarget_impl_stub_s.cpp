/*-----------------------------------------------------------
Implemented `IOleCommandTarget' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleCommandTarget_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleCommandTarget_ = {0xb722bccb,0x4e68,0x101b,{0xa2,0xbc,0x00,0xaa,0x00,0x40,0x47,0x70}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleCommandTarget_impl_stub::IOleCommandTarget_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleCommandTarget_impl_stub::~IOleCommandTarget_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCommandTarget_impl_stub::QueryStatus(  /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG c_cmds, /* [in, out] */ ecom_control_library::_tagOLECMD * prg_cmds, /* [in, out] */ ecom_control_library::_tagOLECMDTEXT * p_cmd_text )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pguid_cmd_group = NULL;
	if (pguid_cmd_group != NULL)
	{
		tmp_pguid_cmd_group = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (pguid_cmd_group));
	}
	EIF_INTEGER tmp_c_cmds = (EIF_INTEGER)c_cmds;
	EIF_OBJECT tmp_prg_cmds = NULL;
	if (prg_cmds != NULL)
	{
		tmp_prg_cmds = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_466 (prg_cmds));
	}
	EIF_OBJECT tmp_p_cmd_text = NULL;
	if (p_cmd_text != NULL)
	{
		tmp_p_cmd_text = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_468 (p_cmd_text));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("query_status", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pguid_cmd_group != NULL) ? eif_access (tmp_pguid_cmd_group) : NULL), (EIF_INTEGER)tmp_c_cmds, ((tmp_prg_cmds != NULL) ? eif_access (tmp_prg_cmds) : NULL), ((tmp_p_cmd_text != NULL) ? eif_access (tmp_p_cmd_text) : NULL));
	
	
	if (tmp_pguid_cmd_group != NULL)
		eif_wean (tmp_pguid_cmd_group);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCommandTarget_impl_stub::Exec(  /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG n_cmd_id, /* [in] */ ULONG n_cmdexecopt, /* [in] */ VARIANT * pva_in, /* [in, out] */ VARIANT * pva_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pguid_cmd_group = NULL;
	if (pguid_cmd_group != NULL)
	{
		tmp_pguid_cmd_group = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (pguid_cmd_group));
	}
	EIF_INTEGER tmp_n_cmd_id = (EIF_INTEGER)n_cmd_id;
	EIF_INTEGER tmp_n_cmdexecopt = (EIF_INTEGER)n_cmdexecopt;
	EIF_OBJECT tmp_pva_in = NULL;
	if (pva_in != NULL)
	{
		tmp_pva_in = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_469 (pva_in));
	}
	EIF_OBJECT tmp_pva_out = NULL;
	if (pva_out != NULL)
	{
		tmp_pva_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_470 (pva_out));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("exec", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pguid_cmd_group != NULL) ? eif_access (tmp_pguid_cmd_group) : NULL), (EIF_INTEGER)tmp_n_cmd_id, (EIF_INTEGER)tmp_n_cmdexecopt, ((tmp_pva_in != NULL) ? eif_access (tmp_pva_in) : NULL), ((tmp_pva_out != NULL) ? eif_access (tmp_pva_out) : NULL));
	
	if (tmp_pguid_cmd_group != NULL)
		eif_wean (tmp_pguid_cmd_group);
	if (tmp_pva_in != NULL)
		eif_wean (tmp_pva_in);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleCommandTarget_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleCommandTarget_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCommandTarget_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleCommandTarget*>(this);
	else if (riid == IID_IOleCommandTarget_)
		*ppv = static_cast<ecom_control_library::IOleCommandTarget*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif