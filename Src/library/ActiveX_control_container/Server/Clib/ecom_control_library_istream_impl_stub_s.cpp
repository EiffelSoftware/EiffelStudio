/*-----------------------------------------------------------
Implemented `IStream' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IStream_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IStream_ = {0x0000000c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_ISequentialStream_ = {0x0c733a30,0x2a1c,0x11ce,{0xad,0xe5,0x00,0xaa,0x00,0x44,0x77,0x3d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IStream_impl_stub::IStream_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStream_impl_stub::~IStream_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::RemoteRead(  /* [out] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_read )

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

STDMETHODIMP ecom_control_library::IStream_impl_stub::RemoteWrite(  /* [in] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_written )

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

STDMETHODIMP ecom_control_library::IStream_impl_stub::RemoteSeek(  /* [in] */ ecom_control_library::_LARGE_INTEGER dlib_move, /* [in] */ ULONG dw_origin, /* [out] */ ecom_control_library::_ULARGE_INTEGER * plib_new_position )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_dlib_move = NULL;
	tmp_dlib_move = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_large_integer_record74 (dlib_move));
	EIF_INTEGER tmp_dw_origin = (EIF_INTEGER)dw_origin;
	EIF_OBJECT tmp_plib_new_position = NULL;
	if (plib_new_position != NULL)
	{
		tmp_plib_new_position = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_73 (plib_new_position));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_seek", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_dlib_move != NULL) ? eif_access (tmp_dlib_move) : NULL), (EIF_INTEGER)tmp_dw_origin, ((tmp_plib_new_position != NULL) ? eif_access (tmp_plib_new_position) : NULL));
	
	if (tmp_dlib_move != NULL)
		eif_wean (tmp_dlib_move);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::SetSize(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_new_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lib_new_size = NULL;
	tmp_lib_new_size = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_ularge_integer_record72 (lib_new_size));
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_size", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lib_new_size != NULL) ? eif_access (tmp_lib_new_size) : NULL));
	if (tmp_lib_new_size != NULL)
		eif_wean (tmp_lib_new_size);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::RemoteCopyTo(  /* [in] */ ecom_control_library::IStream * pstm, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_read, /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_written )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstm = NULL;
	if (pstm != NULL)
	{
		tmp_pstm = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_71 (pstm));
		pstm->AddRef ();
	}
	EIF_OBJECT tmp_cb = NULL;
	tmp_cb = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_ularge_integer_record72 (cb));
	EIF_OBJECT tmp_pcb_read = NULL;
	if (pcb_read != NULL)
	{
		tmp_pcb_read = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_73 (pcb_read));
	}
	EIF_OBJECT tmp_pcb_written = NULL;
	if (pcb_written != NULL)
	{
		tmp_pcb_written = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_73 (pcb_written));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_copy_to", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstm != NULL) ? eif_access (tmp_pstm) : NULL), ((tmp_cb != NULL) ? eif_access (tmp_cb) : NULL), ((tmp_pcb_read != NULL) ? eif_access (tmp_pcb_read) : NULL), ((tmp_pcb_written != NULL) ? eif_access (tmp_pcb_written) : NULL));
	
	
	if (tmp_pstm != NULL)
		eif_wean (tmp_pstm);
	if (tmp_cb != NULL)
		eif_wean (tmp_cb);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::Commit(  /* [in] */ ULONG grf_commit_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_commit_flags = (EIF_INTEGER)grf_commit_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("commit", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_commit_flags);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::Revert( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("revert", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::LockRegion(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_offset, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [in] */ ULONG dw_lock_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lib_offset = NULL;
	tmp_lib_offset = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_ularge_integer_record72 (lib_offset));
	EIF_OBJECT tmp_cb = NULL;
	tmp_cb = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_ularge_integer_record72 (cb));
	EIF_INTEGER tmp_dw_lock_type = (EIF_INTEGER)dw_lock_type;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("lock_region", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lib_offset != NULL) ? eif_access (tmp_lib_offset) : NULL), ((tmp_cb != NULL) ? eif_access (tmp_cb) : NULL), (EIF_INTEGER)tmp_dw_lock_type);
	if (tmp_lib_offset != NULL)
		eif_wean (tmp_lib_offset);
	if (tmp_cb != NULL)
		eif_wean (tmp_cb);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::UnlockRegion(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_offset, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [in] */ ULONG dw_lock_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lib_offset = NULL;
	tmp_lib_offset = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_ularge_integer_record72 (lib_offset));
	EIF_OBJECT tmp_cb = NULL;
	tmp_cb = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_x_ularge_integer_record72 (cb));
	EIF_INTEGER tmp_dw_lock_type = (EIF_INTEGER)dw_lock_type;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("unlock_region", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lib_offset != NULL) ? eif_access (tmp_lib_offset) : NULL), ((tmp_cb != NULL) ? eif_access (tmp_cb) : NULL), (EIF_INTEGER)tmp_dw_lock_type);
	if (tmp_lib_offset != NULL)
		eif_wean (tmp_lib_offset);
	if (tmp_cb != NULL)
		eif_wean (tmp_cb);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::Stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg, /* [in] */ ULONG grf_stat_flag )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstatstg = NULL;
	if (pstatstg != NULL)
	{
		tmp_pstatstg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_76 (pstatstg));
	}
	EIF_INTEGER tmp_grf_stat_flag = (EIF_INTEGER)grf_stat_flag;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("stat", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstatstg != NULL) ? eif_access (tmp_pstatstg) : NULL), (EIF_INTEGER)tmp_grf_stat_flag);
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::Clone(  /* [out] */ ecom_control_library::IStream * * ppstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppstm = NULL;
	if (ppstm != NULL)
	{
		tmp_ppstm = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_77 (ppstm, NULL));
		if (*ppstm != NULL)
			(*ppstm)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("clone1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppstm != NULL) ? eif_access (tmp_ppstm) : NULL));
	
	if (*ppstm != NULL)
		(*ppstm)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_77 (((tmp_ppstm != NULL) ? eif_wean (tmp_ppstm) : NULL), ppstm);
	if (*ppstm != NULL)
		(*ppstm)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IStream_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IStream_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStream_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IStream*>(this);
	else if (riid == IID_IStream_)
		*ppv = static_cast<ecom_control_library::IStream*>(this);
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