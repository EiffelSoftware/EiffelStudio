/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_gec_control_interfaces2.h"
ecom_gec_control_interfaces2 grt_ec_control_interfaces2;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gec_control_interfaces2::ecom_gec_control_interfaces2(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagFORMATETC ecom_gec_control_interfaces2::ccom_ec_record_tag_formatetc_record1( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_FORMATETC_RECORD to ecom_control_library::tagFORMATETC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagFORMATETC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagFORMATETC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_2( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_FORMATETC_RECORD to ecom_control_library::tagFORMATETC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_FORMATETC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagFORMATETC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userSTGMEDIUM ecom_gec_control_interfaces2::ccom_ec_record_x_user_stgmedium_record4( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_STGMEDIUM_RECORD to ecom_control_library::_userSTGMEDIUM.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userSTGMEDIUM *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userSTGMEDIUM * ecom_gec_control_interfaces2::ccom_ec_pointed_record_5( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_STGMEDIUM_RECORD to ecom_control_library::_userSTGMEDIUM *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_STGMEDIUM_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userSTGMEDIUM * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireASYNC_STGMEDIUM ecom_gec_control_interfaces2::ccom_ec_alias_wire_async_stgmedium_alias3( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_ASYNC_STGMEDIUM_ALIAS to ecom_control_library::wireASYNC_STGMEDIUM.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_STGMEDIUM_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userSTGMEDIUM * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireASYNC_STGMEDIUM * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_6( EIF_REFERENCE eif_ref, ecom_control_library::wireASYNC_STGMEDIUM * old )

/*-----------------------------------------------------------
	Convert CELL [WIRE_ASYNC_STGMEDIUM_ALIAS] to ecom_control_library::wireASYNC_STGMEDIUM *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::wireASYNC_STGMEDIUM * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::wireASYNC_STGMEDIUM *) CoTaskMemAlloc (sizeof (ecom_control_library::wireASYNC_STGMEDIUM));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_alias_wire_async_stgmedium_alias3 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IMoniker * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_8( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IMONIKER_INTERFACE to ecom_control_library::IMoniker *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IMoniker *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IMoniker * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userCLIPFORMAT ecom_gec_control_interfaces2::ccom_ec_record_x_user_clipformat_record10( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_CLIPFORMAT_RECORD to ecom_control_library::_userCLIPFORMAT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userCLIPFORMAT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userCLIPFORMAT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_11( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_CLIPFORMAT_RECORD to ecom_control_library::_userCLIPFORMAT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_CLIPFORMAT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userCLIPFORMAT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireCLIPFORMAT ecom_gec_control_interfaces2::ccom_ec_alias_wire_clipformat_alias9( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_CLIPFORMAT_ALIAS to ecom_control_library::wireCLIPFORMAT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_CLIPFORMAT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userCLIPFORMAT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagDVTARGETDEVICE ecom_gec_control_interfaces2::ccom_ec_record_tag_dvtargetdevice_record12( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_DVTARGETDEVICE_RECORD to ecom_control_library::tagDVTARGETDEVICE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagDVTARGETDEVICE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagDVTARGETDEVICE * ecom_gec_control_interfaces2::ccom_ec_pointed_record_13( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_DVTARGETDEVICE_RECORD to ecom_control_library::tagDVTARGETDEVICE *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_DVTARGETDEVICE_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagDVTARGETDEVICE * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0001 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0001_union14( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0001_UNION to ecom_control_library::__MIDL_IWinTypes_0001.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0001 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_STGMEDIUM_UNION ecom_gec_control_interfaces2::ccom_ec_record_x_stgmedium_union_record16( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_STGMEDIUM_UNION_RECORD to ecom_control_library::_STGMEDIUM_UNION.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_STGMEDIUM_UNION *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IAdviseSink_0003 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iadvise_sink_0003_union17( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IADVISE_SINK_0003_UNION to ecom_control_library::__MIDL_IAdviseSink_0003.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IAdviseSink_0003 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_BYTE_BLOB ecom_gec_control_interfaces2::ccom_ec_record_x_byte_blob_record18( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_BYTE_BLOB_RECORD to ecom_control_library::_BYTE_BLOB.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_BYTE_BLOB *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_BYTE_BLOB * ecom_gec_control_interfaces2::ccom_ec_pointed_record_19( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_BYTE_BLOB_RECORD to ecom_control_library::_BYTE_BLOB *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_BYTE_BLOB_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_BYTE_BLOB * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHGLOBAL ecom_gec_control_interfaces2::ccom_ec_record_x_user_hglobal_record20( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HGLOBAL_RECORD to ecom_control_library::_userHGLOBAL.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userHGLOBAL *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHGLOBAL * ecom_gec_control_interfaces2::ccom_ec_pointed_record_21( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HGLOBAL_RECORD to ecom_control_library::_userHGLOBAL *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HGLOBAL_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHGLOBAL * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_GDI_OBJECT ecom_gec_control_interfaces2::ccom_ec_record_x_gdi_object_record22( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_GDI_OBJECT_RECORD to ecom_control_library::_GDI_OBJECT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_GDI_OBJECT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_GDI_OBJECT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_23( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_GDI_OBJECT_RECORD to ecom_control_library::_GDI_OBJECT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_GDI_OBJECT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_GDI_OBJECT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHENHMETAFILE ecom_gec_control_interfaces2::ccom_ec_record_x_user_henhmetafile_record24( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HENHMETAFILE_RECORD to ecom_control_library::_userHENHMETAFILE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userHENHMETAFILE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHENHMETAFILE * ecom_gec_control_interfaces2::ccom_ec_pointed_record_25( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HENHMETAFILE_RECORD to ecom_control_library::_userHENHMETAFILE *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HENHMETAFILE_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHENHMETAFILE * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHMETAFILEPICT ecom_gec_control_interfaces2::ccom_ec_record_x_user_hmetafilepict_record26( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HMETAFILEPICT_RECORD to ecom_control_library::_userHMETAFILEPICT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userHMETAFILEPICT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHMETAFILEPICT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_27( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HMETAFILEPICT_RECORD to ecom_control_library::_userHMETAFILEPICT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HMETAFILEPICT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHMETAFILEPICT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0005 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0005_union28( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0005_UNION to ecom_control_library::__MIDL_IWinTypes_0005.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0005 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_remoteMETAFILEPICT ecom_gec_control_interfaces2::ccom_ec_record_x_remote_metafilepict_record29( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_REMOTE_METAFILEPICT_RECORD to ecom_control_library::_remoteMETAFILEPICT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_remoteMETAFILEPICT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_remoteMETAFILEPICT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_30( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_REMOTE_METAFILEPICT_RECORD to ecom_control_library::_remoteMETAFILEPICT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_REMOTE_METAFILEPICT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_remoteMETAFILEPICT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHMETAFILE ecom_gec_control_interfaces2::ccom_ec_record_x_user_hmetafile_record31( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HMETAFILE_RECORD to ecom_control_library::_userHMETAFILE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userHMETAFILE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHMETAFILE * ecom_gec_control_interfaces2::ccom_ec_pointed_record_32( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HMETAFILE_RECORD to ecom_control_library::_userHMETAFILE *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HMETAFILE_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHMETAFILE * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0004 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0004_union33( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0004_UNION to ecom_control_library::__MIDL_IWinTypes_0004.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0004 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0006 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0006_union35( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0006_UNION to ecom_control_library::__MIDL_IWinTypes_0006.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0006 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IAdviseSink_0002 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iadvise_sink_0002_union36( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IADVISE_SINK_0002_UNION to ecom_control_library::__MIDL_IAdviseSink_0002.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IAdviseSink_0002 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHPALETTE ecom_gec_control_interfaces2::ccom_ec_record_x_user_hpalette_record37( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HPALETTE_RECORD to ecom_control_library::_userHPALETTE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userHPALETTE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHPALETTE * ecom_gec_control_interfaces2::ccom_ec_pointed_record_38( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HPALETTE_RECORD to ecom_control_library::_userHPALETTE *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HPALETTE_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHPALETTE * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHBITMAP ecom_gec_control_interfaces2::ccom_ec_record_x_user_hbitmap_record39( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HBITMAP_RECORD to ecom_control_library::_userHBITMAP.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userHBITMAP *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userHBITMAP * ecom_gec_control_interfaces2::ccom_ec_pointed_record_40( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_HBITMAP_RECORD to ecom_control_library::_userHBITMAP *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HBITMAP_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHBITMAP * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0007 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0007_union41( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0007_UNION to ecom_control_library::__MIDL_IWinTypes_0007.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0007 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userBITMAP ecom_gec_control_interfaces2::ccom_ec_record_x_user_bitmap_record42( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_BITMAP_RECORD to ecom_control_library::_userBITMAP.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userBITMAP *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userBITMAP * ecom_gec_control_interfaces2::ccom_ec_pointed_record_43( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_BITMAP_RECORD to ecom_control_library::_userBITMAP *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_BITMAP_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userBITMAP * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0008 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0008_union45( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0008_UNION to ecom_control_library::__MIDL_IWinTypes_0008.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0008 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagLOGPALETTE ecom_gec_control_interfaces2::ccom_ec_record_tag_logpalette_record46( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_LOGPALETTE_RECORD to ecom_control_library::tagLOGPALETTE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagLOGPALETTE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagLOGPALETTE * ecom_gec_control_interfaces2::ccom_ec_pointed_record_47( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_LOGPALETTE_RECORD to ecom_control_library::tagLOGPALETTE *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_LOGPALETTE_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagLOGPALETTE * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPALETTEENTRY ecom_gec_control_interfaces2::ccom_ec_record_tag_paletteentry_record48( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PALETTEENTRY_RECORD to ecom_control_library::tagPALETTEENTRY.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPALETTEENTRY *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPALETTEENTRY * ecom_gec_control_interfaces2::ccom_ec_pointed_record_49( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PALETTEENTRY_RECORD to ecom_control_library::tagPALETTEENTRY *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_PALETTEENTRY_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagPALETTEENTRY * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IWinTypes_0003 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iwin_types_0003_union50( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0003_UNION to ecom_control_library::__MIDL_IWinTypes_0003.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IWinTypes_0003 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_FLAGGED_BYTE_BLOB ecom_gec_control_interfaces2::ccom_ec_record_x_flagged_byte_blob_record51( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_FLAGGED_BYTE_BLOB_RECORD to ecom_control_library::_FLAGGED_BYTE_BLOB.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_FLAGGED_BYTE_BLOB *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_FLAGGED_BYTE_BLOB * ecom_gec_control_interfaces2::ccom_ec_pointed_record_52( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_FLAGGED_BYTE_BLOB_RECORD to ecom_control_library::_FLAGGED_BYTE_BLOB *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_FLAGGED_BYTE_BLOB_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_FLAGGED_BYTE_BLOB * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindCtx * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_55( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IBIND_CTX_INTERFACE to ecom_control_library::IBindCtx *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IBindCtx *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IBindCtx * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

GUID ecom_gec_control_interfaces2::ccom_ec_record_ecom_guid56( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_GUID to GUID.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (GUID *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

GUID * ecom_gec_control_interfaces2::ccom_ec_pointed_record_57( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_GUID to GUID *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_GUID");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (GUID * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_58( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_59( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IMoniker * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_60( EIF_REFERENCE eif_ref, ecom_control_library::IMoniker * * old )

/*-----------------------------------------------------------
	Convert CELL [IMONIKER_INTERFACE] to ecom_control_library::IMoniker * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IMoniker * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IMoniker * *) CoTaskMemAlloc (sizeof (ecom_control_library::IMoniker *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_8 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumMoniker * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_62( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_MONIKER_INTERFACE to ecom_control_library::IEnumMoniker *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumMoniker *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumMoniker * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumMoniker * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, ecom_control_library::IEnumMoniker * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_MONIKER_INTERFACE] to ecom_control_library::IEnumMoniker * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumMoniker * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumMoniker * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumMoniker *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_62 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_FILETIME ecom_gec_control_interfaces2::ccom_ec_record_x_filetime_record65( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_FILETIME_RECORD to ecom_control_library::_FILETIME.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_FILETIME *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_FILETIME * ecom_gec_control_interfaces2::ccom_ec_pointed_record_66( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_FILETIME_RECORD to ecom_control_library::_FILETIME *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_FILETIME_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_FILETIME * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_67( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStream * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_71( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ISTREAM_INTERFACE to ecom_control_library::IStream *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IStream *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IStream * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_ULARGE_INTEGER ecom_gec_control_interfaces2::ccom_ec_record_x_ularge_integer_record72( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_ULARGE_INTEGER_RECORD to ecom_control_library::_ULARGE_INTEGER.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_ULARGE_INTEGER *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_ULARGE_INTEGER * ecom_gec_control_interfaces2::ccom_ec_pointed_record_73( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_ULARGE_INTEGER_RECORD to ecom_control_library::_ULARGE_INTEGER *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_ULARGE_INTEGER_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_ULARGE_INTEGER * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_LARGE_INTEGER ecom_gec_control_interfaces2::ccom_ec_record_x_large_integer_record74( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_LARGE_INTEGER_RECORD to ecom_control_library::_LARGE_INTEGER.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_LARGE_INTEGER *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSTATSTG ecom_gec_control_interfaces2::ccom_ec_record_tag_statstg_record75( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_STATSTG_RECORD to ecom_control_library::tagSTATSTG.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagSTATSTG *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSTATSTG * ecom_gec_control_interfaces2::ccom_ec_pointed_record_76( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_STATSTG_RECORD to ecom_control_library::tagSTATSTG *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_STATSTG_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagSTATSTG * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStream * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_77( EIF_REFERENCE eif_ref, ecom_control_library::IStream * * old )

/*-----------------------------------------------------------
	Convert CELL [ISTREAM_INTERFACE] to ecom_control_library::IStream * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IStream * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IStream * *) CoTaskMemAlloc (sizeof (ecom_control_library::IStream *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_71 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagBIND_OPTS2 ecom_gec_control_interfaces2::ccom_ec_record_tag_bind_opts2_record82( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_BIND_OPTS2_RECORD to ecom_control_library::tagBIND_OPTS2.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagBIND_OPTS2 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagBIND_OPTS2 * ecom_gec_control_interfaces2::ccom_ec_pointed_record_83( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_BIND_OPTS2_RECORD to ecom_control_library::tagBIND_OPTS2 *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_BIND_OPTS2_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagBIND_OPTS2 * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IRunningObjectTable * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_85( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IRUNNING_OBJECT_TABLE_INTERFACE to ecom_control_library::IRunningObjectTable *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IRunningObjectTable *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IRunningObjectTable * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IRunningObjectTable * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_86( EIF_REFERENCE eif_ref, ecom_control_library::IRunningObjectTable * * old )

/*-----------------------------------------------------------
	Convert CELL [IRUNNING_OBJECT_TABLE_INTERFACE] to ecom_control_library::IRunningObjectTable * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IRunningObjectTable * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IRunningObjectTable * *) CoTaskMemAlloc (sizeof (ecom_control_library::IRunningObjectTable *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_85 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_87( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumString * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_89( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_STRING_INTERFACE to ecom_control_library::IEnumString *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumString *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumString * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumString * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_90( EIF_REFERENCE eif_ref, ecom_control_library::IEnumString * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_STRING_INTERFACE] to ecom_control_library::IEnumString * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumString * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumString * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumString *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_89 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_COSERVERINFO ecom_gec_control_interfaces2::ccom_ec_record_x_coserverinfo_record91( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_COSERVERINFO_RECORD to ecom_control_library::_COSERVERINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_COSERVERINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_COSERVERINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_92( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_COSERVERINFO_RECORD to ecom_control_library::_COSERVERINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_COSERVERINFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_COSERVERINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_COAUTHINFO ecom_gec_control_interfaces2::ccom_ec_record_x_coauthinfo_record93( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_COAUTHINFO_RECORD to ecom_control_library::_COAUTHINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_COAUTHINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_COAUTHINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_94( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_COAUTHINFO_RECORD to ecom_control_library::_COAUTHINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_COAUTHINFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_COAUTHINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_COAUTHIDENTITY ecom_gec_control_interfaces2::ccom_ec_record_x_coauthidentity_record95( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_COAUTHIDENTITY_RECORD to ecom_control_library::_COAUTHIDENTITY.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_COAUTHIDENTITY *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_COAUTHIDENTITY * ecom_gec_control_interfaces2::ccom_ec_pointed_record_96( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_COAUTHIDENTITY_RECORD to ecom_control_library::_COAUTHIDENTITY *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_COAUTHIDENTITY_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_COAUTHIDENTITY * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_101( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_103( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDataObject * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_106( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IDATA_OBJECT_INTERFACE to ecom_control_library::IDataObject *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IDataObject *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IDataObject * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAdviseSink * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_108( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IADVISE_SINK_INTERFACE to ecom_control_library::IAdviseSink *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IAdviseSink *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IAdviseSink * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumSTATDATA * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_111( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_STATDATA_INTERFACE to ecom_control_library::IEnumSTATDATA *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumSTATDATA *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumSTATDATA * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumSTATDATA * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_112( EIF_REFERENCE eif_ref, ecom_control_library::IEnumSTATDATA * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_STATDATA_INTERFACE] to ecom_control_library::IEnumSTATDATA * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumSTATDATA * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumSTATDATA * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumSTATDATA *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_111 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireSTGMEDIUM ecom_gec_control_interfaces2::ccom_ec_alias_wire_stgmedium_alias113( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_STGMEDIUM_ALIAS to ecom_control_library::wireSTGMEDIUM.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_STGMEDIUM_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userSTGMEDIUM * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireSTGMEDIUM * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_114( EIF_REFERENCE eif_ref, ecom_control_library::wireSTGMEDIUM * old )

/*-----------------------------------------------------------
	Convert CELL [WIRE_STGMEDIUM_ALIAS] to ecom_control_library::wireSTGMEDIUM *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::wireSTGMEDIUM * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::wireSTGMEDIUM *) CoTaskMemAlloc (sizeof (ecom_control_library::wireSTGMEDIUM));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_alias_wire_stgmedium_alias113 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userFLAG_STGMEDIUM ecom_gec_control_interfaces2::ccom_ec_record_x_user_flag_stgmedium_record116( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_FLAG_STGMEDIUM_RECORD to ecom_control_library::_userFLAG_STGMEDIUM.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_userFLAG_STGMEDIUM *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_userFLAG_STGMEDIUM * ecom_gec_control_interfaces2::ccom_ec_pointed_record_117( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_USER_FLAG_STGMEDIUM_RECORD to ecom_control_library::_userFLAG_STGMEDIUM *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_FLAG_STGMEDIUM_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userFLAG_STGMEDIUM * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireFLAG_STGMEDIUM ecom_gec_control_interfaces2::ccom_ec_alias_wire_flag_stgmedium_alias115( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_FLAG_STGMEDIUM_ALIAS to ecom_control_library::wireFLAG_STGMEDIUM.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_FLAG_STGMEDIUM_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userFLAG_STGMEDIUM * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireFLAG_STGMEDIUM * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_118( EIF_REFERENCE eif_ref, ecom_control_library::wireFLAG_STGMEDIUM * old )

/*-----------------------------------------------------------
	Convert CELL [WIRE_FLAG_STGMEDIUM_ALIAS] to ecom_control_library::wireFLAG_STGMEDIUM *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::wireFLAG_STGMEDIUM * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::wireFLAG_STGMEDIUM *) CoTaskMemAlloc (sizeof (ecom_control_library::wireFLAG_STGMEDIUM));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_alias_wire_flag_stgmedium_alias115 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumFORMATETC * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_120( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_FORMATETC_INTERFACE to ecom_control_library::IEnumFORMATETC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumFORMATETC *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumFORMATETC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumFORMATETC * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_121( EIF_REFERENCE eif_ref, ecom_control_library::IEnumFORMATETC * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_FORMATETC_INTERFACE] to ecom_control_library::IEnumFORMATETC * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumFORMATETC * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumFORMATETC * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumFORMATETC *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_120 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSTATDATA ecom_gec_control_interfaces2::ccom_ec_record_tag_statdata_record124( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_STATDATA_RECORD to ecom_control_library::tagSTATDATA.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagSTATDATA *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSTATDATA * ecom_gec_control_interfaces2::ccom_ec_pointed_record_125( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_STATDATA_RECORD to ecom_control_library::tagSTATDATA *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_STATDATA_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagSTATDATA * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_132( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_133( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_134( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_136( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_POINTL ecom_gec_control_interfaces2::ccom_ec_record_x_pointl_record137( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_POINTL_RECORD to ecom_control_library::_POINTL.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_POINTL *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCONNECTDATA ecom_gec_control_interfaces2::ccom_ec_record_tag_connectdata_record141( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CONNECTDATA_RECORD to ecom_control_library::tagCONNECTDATA.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagCONNECTDATA *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCONNECTDATA * ecom_gec_control_interfaces2::ccom_ec_pointed_record_142( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CONNECTDATA_RECORD to ecom_control_library::tagCONNECTDATA *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_CONNECTDATA_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagCONNECTDATA * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumConnections * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_145( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CONNECTIONS_INTERFACE to ecom_control_library::IEnumConnections *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumConnections *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumConnections * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumConnections * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_146( EIF_REFERENCE eif_ref, ecom_control_library::IEnumConnections * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CONNECTIONS_INTERFACE] to ecom_control_library::IEnumConnections * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumConnections * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumConnections * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumConnections *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_145 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPoint * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_148( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ICONNECTION_POINT_INTERFACE to ecom_control_library::IConnectionPoint *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IConnectionPoint *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IConnectionPoint * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPoint * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_149( EIF_REFERENCE eif_ref, ecom_control_library::IConnectionPoint * * old )

/*-----------------------------------------------------------
	Convert CELL [ICONNECTION_POINT_INTERFACE] to ecom_control_library::IConnectionPoint * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IConnectionPoint * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IConnectionPoint * *) CoTaskMemAlloc (sizeof (ecom_control_library::IConnectionPoint *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_148 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumConnectionPoints * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_152( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CONNECTION_POINTS_INTERFACE to ecom_control_library::IEnumConnectionPoints *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumConnectionPoints *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumConnectionPoints * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumConnectionPoints * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_153( EIF_REFERENCE eif_ref, ecom_control_library::IEnumConnectionPoints * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CONNECTION_POINTS_INTERFACE] to ecom_control_library::IEnumConnectionPoints * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumConnectionPoints * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumConnectionPoints * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumConnectionPoints *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_152 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPointContainer * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_155( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ICONNECTION_POINT_CONTAINER_INTERFACE to ecom_control_library::IConnectionPointContainer *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IConnectionPointContainer *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IConnectionPointContainer * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPointContainer * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_156( EIF_REFERENCE eif_ref, ecom_control_library::IConnectionPointContainer * * old )

/*-----------------------------------------------------------
	Convert CELL [ICONNECTION_POINT_CONTAINER_INTERFACE] to ecom_control_library::IConnectionPointContainer * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IConnectionPointContainer * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IConnectionPointContainer * *) CoTaskMemAlloc (sizeof (ecom_control_library::IConnectionPointContainer *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_155 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleUndoUnit * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_159( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_UNDO_UNIT_INTERFACE to ecom_control_library::IOleUndoUnit *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleUndoUnit *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleUndoUnit * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleUndoUnit * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_160( EIF_REFERENCE eif_ref, ecom_control_library::IOleUndoUnit * * old )

/*-----------------------------------------------------------
	Convert CELL [IOLE_UNDO_UNIT_INTERFACE] to ecom_control_library::IOleUndoUnit * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IOleUndoUnit * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IOleUndoUnit * *) CoTaskMemAlloc (sizeof (ecom_control_library::IOleUndoUnit *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_159 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumOleUndoUnits * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_163( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_OLE_UNDO_UNITS_INTERFACE to ecom_control_library::IEnumOleUndoUnits *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumOleUndoUnits *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumOleUndoUnits * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumOleUndoUnits * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_164( EIF_REFERENCE eif_ref, ecom_control_library::IEnumOleUndoUnits * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_OLE_UNDO_UNITS_INTERFACE] to ecom_control_library::IEnumOleUndoUnits * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumOleUndoUnits * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumOleUndoUnits * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumOleUndoUnits *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_163 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleUndoManager * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_166( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_UNDO_MANAGER_INTERFACE to ecom_control_library::IOleUndoManager *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleUndoManager *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleUndoManager * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_167( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleParentUndoUnit * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_170( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_PARENT_UNDO_UNIT_INTERFACE to ecom_control_library::IOleParentUndoUnit *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleParentUndoUnit *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleParentUndoUnit * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_172( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_173( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagOLEVERB ecom_gec_control_interfaces2::ccom_ec_record_tag_oleverb_record175( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_OLEVERB_RECORD to ecom_control_library::tagOLEVERB.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagOLEVERB *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagOLEVERB * ecom_gec_control_interfaces2::ccom_ec_pointed_record_176( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_OLEVERB_RECORD to ecom_control_library::tagOLEVERB *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_OLEVERB_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagOLEVERB * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumOLEVERB * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_179( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_OLEVERB_INTERFACE to ecom_control_library::IEnumOLEVERB *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumOLEVERB *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumOLEVERB * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumOLEVERB * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_180( EIF_REFERENCE eif_ref, ecom_control_library::IEnumOLEVERB * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_OLEVERB_INTERFACE] to ecom_control_library::IEnumOLEVERB * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumOLEVERB * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumOLEVERB * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumOLEVERB *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_179 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EXCEPINFO ecom_gec_control_interfaces2::ccom_ec_record_ecom_excep_info181( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_EXCEP_INFO to EXCEPINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (EXCEPINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EXCEPINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_182( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_EXCEP_INFO to EXCEPINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_EXCEP_INFO");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (EXCEPINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleContainer * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_187( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_CONTAINER_INTERFACE to ecom_control_library::IOleContainer *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleContainer *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleContainer * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleContainer * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, ecom_control_library::IOleContainer * * old )

/*-----------------------------------------------------------
	Convert CELL [IOLE_CONTAINER_INTERFACE] to ecom_control_library::IOleContainer * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IOleContainer * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IOleContainer * *) CoTaskMemAlloc (sizeof (ecom_control_library::IOleContainer *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_187 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumUnknown * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_190( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_UNKNOWN_INTERFACE to ecom_control_library::IEnumUnknown *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumUnknown *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumUnknown * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_191( EIF_REFERENCE eif_ref, ecom_control_library::IEnumUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_UNKNOWN_INTERFACE] to ecom_control_library::IEnumUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumUnknown * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_190 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_193( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCONTROLINFO ecom_gec_control_interfaces2::ccom_ec_record_tag_controlinfo_record195( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CONTROLINFO_RECORD to ecom_control_library::tagCONTROLINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagCONTROLINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCONTROLINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_196( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CONTROLINFO_RECORD to ecom_control_library::tagCONTROLINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_CONTROLINFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagCONTROLINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagMSG ecom_gec_control_interfaces2::ccom_ec_record_tag_msg_record197( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_MSG_RECORD to ecom_control_library::tagMSG.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagMSG *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagMSG * ecom_gec_control_interfaces2::ccom_ec_pointed_record_198( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_MSG_RECORD to ecom_control_library::tagMSG *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_MSG_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagMSG * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPOINT ecom_gec_control_interfaces2::ccom_ec_record_tag_point_record203( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_POINT_RECORD to ecom_control_library::tagPOINT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPOINT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_204( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_POINTL * ecom_gec_control_interfaces2::ccom_ec_pointed_record_205( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_POINTL_RECORD to ecom_control_library::_POINTL *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_POINTL_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_POINTL * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPOINTF ecom_gec_control_interfaces2::ccom_ec_record_tag_pointf_record206( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_POINTF_RECORD to ecom_control_library::tagPOINTF.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPOINTF *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPOINTF * ecom_gec_control_interfaces2::ccom_ec_pointed_record_207( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_POINTF_RECORD to ecom_control_library::tagPOINTF *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_POINTF_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagPOINTF * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRECT ecom_gec_control_interfaces2::ccom_ec_record_tag_rect_record209( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_RECT_RECORD to ecom_control_library::tagRECT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagRECT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRECT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_210( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_RECT_RECORD to ecom_control_library::tagRECT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_RECT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagRECT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceUIWindow * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_212( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_IN_PLACE_UIWINDOW_INTERFACE to ecom_control_library::IOleInPlaceUIWindow *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleInPlaceUIWindow *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleInPlaceUIWindow * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceActiveObject * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_214( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE to ecom_control_library::IOleInPlaceActiveObject *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleInPlaceActiveObject *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleInPlaceActiveObject * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagOleMenuGroupWidths ecom_gec_control_interfaces2::ccom_ec_record_tag_ole_menu_group_widths_record216( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_OLE_MENU_GROUP_WIDTHS_RECORD to ecom_control_library::tagOleMenuGroupWidths.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagOleMenuGroupWidths *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagOleMenuGroupWidths * ecom_gec_control_interfaces2::ccom_ec_pointed_record_217( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_OLE_MENU_GROUP_WIDTHS_RECORD to ecom_control_library::tagOleMenuGroupWidths *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_OLE_MENU_GROUP_WIDTHS_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagOleMenuGroupWidths * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireHGLOBAL ecom_gec_control_interfaces2::ccom_ec_alias_wire_hglobal_alias218( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_HGLOBAL_ALIAS to ecom_control_library::wireHGLOBAL.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HGLOBAL_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHGLOBAL * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LONG* ecom_gec_control_interfaces2::ccom_ec_array_automation219( EIF_REFERENCE a_ref, LONG* old )

/*-----------------------------------------------------------
	Convert ARRAY [INTEGER] to LONG[6].
-----------------------------------------------------------*/
{
	return rt_ec.ccom_ec_array_long (a_ref, 1, old);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDropTarget * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_222( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IDROP_TARGET_INTERFACE to ecom_control_library::IDropTarget *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IDropTarget *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IDropTarget * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDropTarget * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, ecom_control_library::IDropTarget * * old )

/*-----------------------------------------------------------
	Convert CELL [IDROP_TARGET_INTERFACE] to ecom_control_library::IDropTarget * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IDropTarget * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IDropTarget * *) CoTaskMemAlloc (sizeof (ecom_control_library::IDropTarget *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_222 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceFrame * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_225( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_IN_PLACE_FRAME_INTERFACE to ecom_control_library::IOleInPlaceFrame *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleInPlaceFrame *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleInPlaceFrame * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceFrame * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_226( EIF_REFERENCE eif_ref, ecom_control_library::IOleInPlaceFrame * * old )

/*-----------------------------------------------------------
	Convert CELL [IOLE_IN_PLACE_FRAME_INTERFACE] to ecom_control_library::IOleInPlaceFrame * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IOleInPlaceFrame * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IOleInPlaceFrame * *) CoTaskMemAlloc (sizeof (ecom_control_library::IOleInPlaceFrame *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_225 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceUIWindow * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_227( EIF_REFERENCE eif_ref, ecom_control_library::IOleInPlaceUIWindow * * old )

/*-----------------------------------------------------------
	Convert CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE] to ecom_control_library::IOleInPlaceUIWindow * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IOleInPlaceUIWindow * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IOleInPlaceUIWindow * *) CoTaskMemAlloc (sizeof (ecom_control_library::IOleInPlaceUIWindow *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_212 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagOIFI ecom_gec_control_interfaces2::ccom_ec_record_tag_oifi_record228( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_OIFI_RECORD to ecom_control_library::tagOIFI.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagOIFI *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagOIFI * ecom_gec_control_interfaces2::ccom_ec_pointed_record_229( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_OIFI_RECORD to ecom_control_library::tagOIFI *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_OIFI_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagOIFI * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSIZE ecom_gec_control_interfaces2::ccom_ec_record_tag_size_record230( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_SIZE_RECORD to ecom_control_library::tagSIZE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagSIZE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_241( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_242( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleClientSite * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_244( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_CLIENT_SITE_INTERFACE to ecom_control_library::IOleClientSite *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleClientSite *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleClientSite * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleClientSite * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_245( EIF_REFERENCE eif_ref, ecom_control_library::IOleClientSite * * old )

/*-----------------------------------------------------------
	Convert CELL [IOLE_CLIENT_SITE_INTERFACE] to ecom_control_library::IOleClientSite * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IOleClientSite * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IOleClientSite * *) CoTaskMemAlloc (sizeof (ecom_control_library::IOleClientSite *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_244 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDataObject * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_246( EIF_REFERENCE eif_ref, ecom_control_library::IDataObject * * old )

/*-----------------------------------------------------------
	Convert CELL [IDATA_OBJECT_INTERFACE] to ecom_control_library::IDataObject * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IDataObject * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IDataObject * *) CoTaskMemAlloc (sizeof (ecom_control_library::IDataObject *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_106 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_247( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSIZEL ecom_gec_control_interfaces2::ccom_ec_record_tag_sizel_record248( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_SIZEL_RECORD to ecom_control_library::tagSIZEL.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagSIZEL *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSIZEL * ecom_gec_control_interfaces2::ccom_ec_pointed_record_249( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_SIZEL_RECORD to ecom_control_library::tagSIZEL *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_SIZEL_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagSIZEL * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_252( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCALPOLESTR ecom_gec_control_interfaces2::ccom_ec_record_tag_calpolestr_record253( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CALPOLESTR_RECORD to ecom_control_library::tagCALPOLESTR.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagCALPOLESTR *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCALPOLESTR * ecom_gec_control_interfaces2::ccom_ec_pointed_record_254( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CALPOLESTR_RECORD to ecom_control_library::tagCALPOLESTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_CALPOLESTR_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagCALPOLESTR * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCADWORD ecom_gec_control_interfaces2::ccom_ec_record_tag_cadword_record255( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CADWORD_RECORD to ecom_control_library::tagCADWORD.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagCADWORD *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCADWORD * ecom_gec_control_interfaces2::ccom_ec_pointed_record_256( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CADWORD_RECORD to ecom_control_library::tagCADWORD *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_CADWORD_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagCADWORD * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_257( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_258( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_260( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyBag * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_265( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IPROPERTY_BAG_INTERFACE to ecom_control_library::IPropertyBag *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IPropertyBag *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IPropertyBag * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IErrorLog * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_267( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IERROR_LOG_INTERFACE to ecom_control_library::IErrorLog *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IErrorLog *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IErrorLog * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_268( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_269( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyBag2 * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_271( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IPROPERTY_BAG2_INTERFACE to ecom_control_library::IPropertyBag2 *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IPropertyBag2 *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IPropertyBag2 * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPROPBAG2 ecom_gec_control_interfaces2::ccom_ec_record_tag_propbag2_record272( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PROPBAG2_RECORD to ecom_control_library::tagPROPBAG2.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPROPBAG2 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPROPBAG2 * ecom_gec_control_interfaces2::ccom_ec_pointed_record_273( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PROPBAG2_RECORD to ecom_control_library::tagPROPBAG2 *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_PROPBAG2_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagPROPBAG2 * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_274( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_276( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStorage * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_280( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ISTORAGE_INTERFACE to ecom_control_library::IStorage *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IStorage *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IStorage * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStorage * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_282( EIF_REFERENCE eif_ref, ecom_control_library::IStorage * * old )

/*-----------------------------------------------------------
	Convert CELL [ISTORAGE_INTERFACE] to ecom_control_library::IStorage * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IStorage * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IStorage * *) CoTaskMemAlloc (sizeof (ecom_control_library::IStorage *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_280 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRemSNB ecom_gec_control_interfaces2::ccom_ec_record_tag_rem_snb_record284( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_REM_SNB_RECORD to ecom_control_library::tagRemSNB.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagRemSNB *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRemSNB * ecom_gec_control_interfaces2::ccom_ec_pointed_record_285( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_REM_SNB_RECORD to ecom_control_library::tagRemSNB *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_REM_SNB_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagRemSNB * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireSNB ecom_gec_control_interfaces2::ccom_ec_alias_wire_snb_alias283( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_SNB_ALIAS to ecom_control_library::wireSNB.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_REM_SNB_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagRemSNB * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumSTATSTG * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_288( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_STATSTG_INTERFACE to ecom_control_library::IEnumSTATSTG *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IEnumSTATSTG *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IEnumSTATSTG * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumSTATSTG * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_289( EIF_REFERENCE eif_ref, ecom_control_library::IEnumSTATSTG * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_STATSTG_INTERFACE] to ecom_control_library::IEnumSTATSTG * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IEnumSTATSTG * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IEnumSTATSTG * *) CoTaskMemAlloc (sizeof (ecom_control_library::IEnumSTATSTG *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_288 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyPageSite * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_294( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IPROPERTY_PAGE_SITE_INTERFACE to ecom_control_library::IPropertyPageSite *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IPropertyPageSite *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IPropertyPageSite * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPROPPAGEINFO ecom_gec_control_interfaces2::ccom_ec_record_tag_proppageinfo_record295( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PROPPAGEINFO_RECORD to ecom_control_library::tagPROPPAGEINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPROPPAGEINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPROPPAGEINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_296( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PROPPAGEINFO_RECORD to ecom_control_library::tagPROPPAGEINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_PROPPAGEINFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagPROPPAGEINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_297( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_299( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeInfo_2 * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_301( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ITYPE_INFO_2_INTERFACE to ecom_control_library::ITypeInfo_2 *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::ITypeInfo_2 *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::ITypeInfo_2 * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeInfo_2 * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_302( EIF_REFERENCE eif_ref, ecom_control_library::ITypeInfo_2 * * old )

/*-----------------------------------------------------------
	Convert CELL [ITYPE_INFO_2_INTERFACE] to ecom_control_library::ITypeInfo_2 * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::ITypeInfo_2 * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::ITypeInfo_2 * *) CoTaskMemAlloc (sizeof (ecom_control_library::ITypeInfo_2 *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_301 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTYPEATTR ecom_gec_control_interfaces2::ccom_ec_record_tag_typeattr_record303( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_TYPEATTR_RECORD to ecom_control_library::tagTYPEATTR.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagTYPEATTR *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTYPEATTR * ecom_gec_control_interfaces2::ccom_ec_pointed_record_304( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_TYPEATTR_RECORD to ecom_control_library::tagTYPEATTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_TYPEATTR_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagTYPEATTR * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTYPEATTR * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_305( EIF_REFERENCE eif_ref, ecom_control_library::tagTYPEATTR * * old )

/*-----------------------------------------------------------
	Convert CELL [TAG_TYPEATTR_RECORD] to ecom_control_library::tagTYPEATTR * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::tagTYPEATTR * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::tagTYPEATTR * *) CoTaskMemAlloc (sizeof (ecom_control_library::tagTYPEATTR *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_record_304 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeComp * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_309( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ITYPE_COMP_INTERFACE to ecom_control_library::ITypeComp *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::ITypeComp *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::ITypeComp * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeComp * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_310( EIF_REFERENCE eif_ref, ecom_control_library::ITypeComp * * old )

/*-----------------------------------------------------------
	Convert CELL [ITYPE_COMP_INTERFACE] to ecom_control_library::ITypeComp * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::ITypeComp * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::ITypeComp * *) CoTaskMemAlloc (sizeof (ecom_control_library::ITypeComp *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_309 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagFUNCDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_funcdesc_record311( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_FUNCDESC_RECORD to ecom_control_library::tagFUNCDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagFUNCDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagFUNCDESC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_312( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_FUNCDESC_RECORD to ecom_control_library::tagFUNCDESC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_FUNCDESC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagFUNCDESC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagFUNCDESC * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_313( EIF_REFERENCE eif_ref, ecom_control_library::tagFUNCDESC * * old )

/*-----------------------------------------------------------
	Convert CELL [TAG_FUNCDESC_RECORD] to ecom_control_library::tagFUNCDESC * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::tagFUNCDESC * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::tagFUNCDESC * *) CoTaskMemAlloc (sizeof (ecom_control_library::tagFUNCDESC *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_record_312 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagVARDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_vardesc_record314( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_VARDESC_RECORD to ecom_control_library::tagVARDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagVARDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagVARDESC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_315( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_VARDESC_RECORD to ecom_control_library::tagVARDESC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_VARDESC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagVARDESC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagVARDESC * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_316( EIF_REFERENCE eif_ref, ecom_control_library::tagVARDESC * * old )

/*-----------------------------------------------------------
	Convert CELL [TAG_VARDESC_RECORD] to ecom_control_library::tagVARDESC * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::tagVARDESC * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::tagVARDESC * *) CoTaskMemAlloc (sizeof (ecom_control_library::tagVARDESC *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_record_315 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_317( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_321( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_322( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_324( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_326( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_327( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_329( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_330( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeLib_2 * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_332( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ITYPE_LIB_2_INTERFACE to ecom_control_library::ITypeLib_2 *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::ITypeLib_2 *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::ITypeLib_2 * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeLib_2 * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_333( EIF_REFERENCE eif_ref, ecom_control_library::ITypeLib_2 * * old )

/*-----------------------------------------------------------
	Convert CELL [ITYPE_LIB_2_INTERFACE] to ecom_control_library::ITypeLib_2 * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::ITypeLib_2 * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::ITypeLib_2 * *) CoTaskMemAlloc (sizeof (ecom_control_library::ITypeLib_2 *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_332 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTYPEDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_typedesc_record336( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_TYPEDESC_RECORD to ecom_control_library::tagTYPEDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagTYPEDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagIDLDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_idldesc_record337( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_IDLDESC_RECORD to ecom_control_library::tagIDLDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagIDLDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IOleAutomationTypes_0005 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iole_automation_types_0005_union338( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IOLE_AUTOMATION_TYPES_0005_UNION to ecom_control_library::__MIDL_IOleAutomationTypes_0005.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IOleAutomationTypes_0005 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagARRAYDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_arraydesc_record339( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_ARRAYDESC_RECORD to ecom_control_library::tagARRAYDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagARRAYDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagARRAYDESC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_340( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_ARRAYDESC_RECORD to ecom_control_library::tagARRAYDESC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_ARRAYDESC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagARRAYDESC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTYPEDESC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_341( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_TYPEDESC_RECORD to ecom_control_library::tagTYPEDESC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_TYPEDESC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagTYPEDESC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSAFEARRAYBOUND ecom_gec_control_interfaces2::ccom_ec_record_tag_safearraybound_record342( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_SAFEARRAYBOUND_RECORD to ecom_control_library::tagSAFEARRAYBOUND.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagSAFEARRAYBOUND *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagSAFEARRAYBOUND * ecom_gec_control_interfaces2::ccom_ec_pointed_record_343( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_SAFEARRAYBOUND_RECORD to ecom_control_library::tagSAFEARRAYBOUND *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_SAFEARRAYBOUND_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagSAFEARRAYBOUND * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagELEMDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_elemdesc_record347( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_ELEMDESC_RECORD to ecom_control_library::tagELEMDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagELEMDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagELEMDESC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_348( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_ELEMDESC_RECORD to ecom_control_library::tagELEMDESC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_ELEMDESC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagELEMDESC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPARAMDESC ecom_gec_control_interfaces2::ccom_ec_record_tag_paramdesc_record351( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PARAMDESC_RECORD to ecom_control_library::tagPARAMDESC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPARAMDESC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPARAMDESCEX ecom_gec_control_interfaces2::ccom_ec_record_tag_paramdescex_record352( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PARAMDESCEX_RECORD to ecom_control_library::tagPARAMDESCEX.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagPARAMDESCEX *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPARAMDESCEX * ecom_gec_control_interfaces2::ccom_ec_pointed_record_353( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_PARAMDESCEX_RECORD to ecom_control_library::tagPARAMDESCEX *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_PARAMDESCEX_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagPARAMDESCEX * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::__MIDL_IOleAutomationTypes_0006 ecom_gec_control_interfaces2::ccom_ec_record_x__midl_iole_automation_types_0006_union354( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IOLE_AUTOMATION_TYPES_0006_UNION to ecom_control_library::__MIDL_IOleAutomationTypes_0006.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::__MIDL_IOleAutomationTypes_0006 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_356( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTLIBATTR ecom_gec_control_interfaces2::ccom_ec_record_tag_tlibattr_record359( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_TLIBATTR_RECORD to ecom_control_library::tagTLIBATTR.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagTLIBATTR *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTLIBATTR * ecom_gec_control_interfaces2::ccom_ec_pointed_record_360( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_TLIBATTR_RECORD to ecom_control_library::tagTLIBATTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_TLIBATTR_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagTLIBATTR * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagTLIBATTR * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_361( EIF_REFERENCE eif_ref, ecom_control_library::tagTLIBATTR * * old )

/*-----------------------------------------------------------
	Convert CELL [TAG_TLIBATTR_RECORD] to ecom_control_library::tagTLIBATTR * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::tagTLIBATTR * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::tagTLIBATTR * *) CoTaskMemAlloc (sizeof (ecom_control_library::tagTLIBATTR *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_record_360 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_362( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_363( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_365( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_367( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_370( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCAUUID ecom_gec_control_interfaces2::ccom_ec_record_tag_cauuid_record378( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CAUUID_RECORD to ecom_control_library::tagCAUUID.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagCAUUID *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagCAUUID * ecom_gec_control_interfaces2::ccom_ec_pointed_record_379( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_CAUUID_RECORD to ecom_control_library::tagCAUUID *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_CAUUID_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagCAUUID * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_RECTL ecom_gec_control_interfaces2::ccom_ec_record_x_rectl_record380( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_RECTL_RECORD to ecom_control_library::_RECTL.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_RECTL *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_RECTL * ecom_gec_control_interfaces2::ccom_ec_pointed_record_381( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_RECTL_RECORD to ecom_control_library::_RECTL *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_RECTL_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_RECTL * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IContinue * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_383( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ICONTINUE_INTERFACE to ecom_control_library::IContinue *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IContinue *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IContinue * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagLOGPALETTE * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_384( EIF_REFERENCE eif_ref, ecom_control_library::tagLOGPALETTE * * old )

/*-----------------------------------------------------------
	Convert CELL [TAG_LOGPALETTE_RECORD] to ecom_control_library::tagLOGPALETTE * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::tagLOGPALETTE * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::tagLOGPALETTE * *) CoTaskMemAlloc (sizeof (ecom_control_library::tagLOGPALETTE *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_record_47 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAdviseSink * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_388( EIF_REFERENCE eif_ref, ecom_control_library::IAdviseSink * * old )

/*-----------------------------------------------------------
	Convert CELL [IADVISE_SINK_INTERFACE] to ecom_control_library::IAdviseSink * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_control_library::IAdviseSink * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_control_library::IAdviseSink * *) CoTaskMemAlloc (sizeof (ecom_control_library::IAdviseSink *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_108 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagExtentInfo ecom_gec_control_interfaces2::ccom_ec_record_tag_extent_info_record392( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_EXTENT_INFO_RECORD to ecom_control_library::tagExtentInfo.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagExtentInfo *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagExtentInfo * ecom_gec_control_interfaces2::ccom_ec_pointed_record_393( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_EXTENT_INFO_RECORD to ecom_control_library::tagExtentInfo *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_EXTENT_INFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagExtentInfo * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagQACONTAINER ecom_gec_control_interfaces2::ccom_ec_record_tag_qacontainer_record394( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_QACONTAINER_RECORD to ecom_control_library::tagQACONTAINER.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagQACONTAINER *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagQACONTAINER * ecom_gec_control_interfaces2::ccom_ec_pointed_record_395( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_QACONTAINER_RECORD to ecom_control_library::tagQACONTAINER *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_QACONTAINER_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagQACONTAINER * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagQACONTROL ecom_gec_control_interfaces2::ccom_ec_record_tag_qacontrol_record396( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_QACONTROL_RECORD to ecom_control_library::tagQACONTROL.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagQACONTROL *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagQACONTROL * ecom_gec_control_interfaces2::ccom_ec_pointed_record_397( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_QACONTROL_RECORD to ecom_control_library::tagQACONTROL *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_QACONTROL_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagQACONTROL * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAdviseSinkEx * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_399( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IADVISE_SINK_EX_INTERFACE to ecom_control_library::IAdviseSinkEx *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IAdviseSinkEx *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IAdviseSinkEx * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyNotifySink * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_401( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IPROPERTY_NOTIFY_SINK_INTERFACE to ecom_control_library::IPropertyNotifySink *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IPropertyNotifySink *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IPropertyNotifySink * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IFont * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_404( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IFONT_INTERFACE to IFont *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((IFont *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (IFont * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::wireHPALETTE ecom_gec_control_interfaces2::ccom_ec_alias_wire_hpalette_alias405( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert WIRE_HPALETTE_ALIAS to ecom_control_library::wireHPALETTE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_USER_HPALETTE_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_userHPALETTE * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindHost * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_407( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IBIND_HOST_INTERFACE to ecom_control_library::IBindHost *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IBindHost *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IBindHost * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleControlSite * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_409( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_CONTROL_SITE_INTERFACE to ecom_control_library::IOleControlSite *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleControlSite *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleControlSite * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IServiceProvider * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_411( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ISERVICE_PROVIDER_INTERFACE to ecom_control_library::IServiceProvider *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IServiceProvider *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IServiceProvider * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindStatusCallback * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_413( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IBIND_STATUS_CALLBACK_INTERFACE to ecom_control_library::IBindStatusCallback *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IBindStatusCallback *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IBindStatusCallback * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_414( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_415( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBinding * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_417( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IBINDING_INTERFACE to ecom_control_library::IBinding *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IBinding *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IBinding * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_tagRemBINDINFO ecom_gec_control_interfaces2::ccom_ec_record_x_tag_rem_bindinfo_record420( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TAG_REM_BINDINFO_RECORD to ecom_control_library::_tagRemBINDINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_tagRemBINDINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_tagRemBINDINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_421( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TAG_REM_BINDINFO_RECORD to ecom_control_library::_tagRemBINDINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_TAG_REM_BINDINFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_tagRemBINDINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRemSTGMEDIUM ecom_gec_control_interfaces2::ccom_ec_record_tag_rem_stgmedium_record422( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_REM_STGMEDIUM_RECORD to ecom_control_library::tagRemSTGMEDIUM.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagRemSTGMEDIUM *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRemSTGMEDIUM * ecom_gec_control_interfaces2::ccom_ec_pointed_record_423( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_REM_STGMEDIUM_RECORD to ecom_control_library::tagRemSTGMEDIUM *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_REM_STGMEDIUM_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagRemSTGMEDIUM * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRemFORMATETC ecom_gec_control_interfaces2::ccom_ec_record_tag_rem_formatetc_record424( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_REM_FORMATETC_RECORD to ecom_control_library::tagRemFORMATETC.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::tagRemFORMATETC *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagRemFORMATETC * ecom_gec_control_interfaces2::ccom_ec_pointed_record_425( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_REM_FORMATETC_RECORD to ecom_control_library::tagRemFORMATETC *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_REM_FORMATETC_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagRemFORMATETC * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_428( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_REMSECURITY_ATTRIBUTES ecom_gec_control_interfaces2::ccom_ec_record_x_remsecurity_attributes_record429( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_REMSECURITY_ATTRIBUTES_RECORD to ecom_control_library::_REMSECURITY_ATTRIBUTES.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_REMSECURITY_ATTRIBUTES *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_431( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_432( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDocHostUIHandlerDispatch * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_436( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE to ecom_control_library::IDocHostUIHandlerDispatch *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IDocHostUIHandlerDispatch *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IDocHostUIHandlerDispatch * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

Font * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_443( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert FONT_INTERFACE to Font *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((Font *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (Font * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

Font * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_444( EIF_REFERENCE eif_ref, Font * * old )

/*-----------------------------------------------------------
	Convert CELL [FONT_INTERFACE] to Font * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	Font * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (Font * *) CoTaskMemAlloc (sizeof (Font *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_443 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_452( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::tagPOINT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_453( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert TAG_POINT_RECORD to ecom_control_library::tagPOINT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("TAG_POINT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::tagPOINT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_DOCHOSTUIINFO ecom_gec_control_interfaces2::ccom_ec_record_x_dochostuiinfo_record454( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_DOCHOSTUIINFO_RECORD to ecom_control_library::_DOCHOSTUIINFO.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_DOCHOSTUIINFO *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_DOCHOSTUIINFO * ecom_gec_control_interfaces2::ccom_ec_pointed_record_455( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_DOCHOSTUIINFO_RECORD to ecom_control_library::_DOCHOSTUIINFO *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_DOCHOSTUIINFO_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_DOCHOSTUIINFO * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleCommandTarget * ecom_gec_control_interfaces2::ccom_ec_pointed_interface_457( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IOLE_COMMAND_TARGET_INTERFACE to ecom_control_library::IOleCommandTarget *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_control_library::IOleCommandTarget *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_control_library::IOleCommandTarget * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_458( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_459( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SHORT * * ecom_gec_control_interfaces2::ccom_ec_pointed_cell_462( EIF_REFERENCE eif_ref, SHORT * * old )

/*-----------------------------------------------------------
	Convert CELL [INTEGER_REF] to SHORT * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	SHORT * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (SHORT * *) CoTaskMemAlloc (sizeof (SHORT *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		grt_ce_control_interfaces2.ccom_free_memory_pointed_461(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_pointed_short (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_tagOLECMD ecom_gec_control_interfaces2::ccom_ec_record_x_tag_olecmd_record465( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TAG_OLECMD_RECORD to ecom_control_library::_tagOLECMD.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_tagOLECMD *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_tagOLECMD * ecom_gec_control_interfaces2::ccom_ec_pointed_record_466( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TAG_OLECMD_RECORD to ecom_control_library::_tagOLECMD *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_TAG_OLECMD_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_tagOLECMD * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_tagOLECMDTEXT ecom_gec_control_interfaces2::ccom_ec_record_x_tag_olecmdtext_record467( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TAG_OLECMDTEXT_RECORD to ecom_control_library::_tagOLECMDTEXT.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);eif_wean (eif_object);
	return * (ecom_control_library::_tagOLECMDTEXT *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::_tagOLECMDTEXT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_468( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TAG_OLECMDTEXT_RECORD to ecom_control_library::_tagOLECMDTEXT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_TAG_OLECMDTEXT_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (ecom_control_library::_tagOLECMDTEXT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_469( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_control_interfaces2::ccom_ec_pointed_record_470( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif