/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#include "ecom_gce_control_interfaces2.h"
ecom_gce_control_interfaces2 grt_ce_control_interfaces2;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gce_control_interfaces2::ecom_gce_control_interfaces2(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_formatetc_record1( ecom_control_library::tagFORMATETC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagFORMATETC  to TAG_FORMATETC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_FORMATETC_RECORD", sizeof (ecom_control_library::tagFORMATETC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_2( ecom_control_library::tagFORMATETC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagFORMATETC *  to TAG_FORMATETC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_FORMATETC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_stgmedium_record4( ecom_control_library::_userSTGMEDIUM a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userSTGMEDIUM  to X_USER_STGMEDIUM_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_STGMEDIUM_RECORD", sizeof (ecom_control_library::_userSTGMEDIUM));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_5( ecom_control_library::_userSTGMEDIUM * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userSTGMEDIUM *  to X_USER_STGMEDIUM_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_STGMEDIUM_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_async_stgmedium_alias3( ecom_control_library::wireASYNC_STGMEDIUM an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireASYNC_STGMEDIUM  to WIRE_ASYNC_STGMEDIUM_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_ASYNC_STGMEDIUM_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_5 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_6( ecom_control_library::wireASYNC_STGMEDIUM * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireASYNC_STGMEDIUM *  to CELL [WIRE_ASYNC_STGMEDIUM_ALIAS].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [WIRE_ASYNC_STGMEDIUM_ALIAS]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::wireASYNC_STGMEDIUM *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_alias_wire_async_stgmedium_alias3 (*(ecom_control_library::wireASYNC_STGMEDIUM *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_6( ecom_control_library::wireASYNC_STGMEDIUM * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireASYNC_STGMEDIUM *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_8( ecom_control_library::IMoniker * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IMoniker *  to IMONIKER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IMONIKER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_clipformat_record10( ecom_control_library::_userCLIPFORMAT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userCLIPFORMAT  to X_USER_CLIPFORMAT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_CLIPFORMAT_RECORD", sizeof (ecom_control_library::_userCLIPFORMAT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_11( ecom_control_library::_userCLIPFORMAT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userCLIPFORMAT *  to X_USER_CLIPFORMAT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_CLIPFORMAT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_clipformat_alias9( ecom_control_library::wireCLIPFORMAT an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireCLIPFORMAT  to WIRE_CLIPFORMAT_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_CLIPFORMAT_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_11 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_dvtargetdevice_record12( ecom_control_library::tagDVTARGETDEVICE a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagDVTARGETDEVICE  to TAG_DVTARGETDEVICE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_DVTARGETDEVICE_RECORD", sizeof (ecom_control_library::tagDVTARGETDEVICE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_13( ecom_control_library::tagDVTARGETDEVICE * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagDVTARGETDEVICE *  to TAG_DVTARGETDEVICE_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_DVTARGETDEVICE_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0001_union14( ecom_control_library::__MIDL_IWinTypes_0001 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0001  to X__MIDL_IWIN_TYPES_0001_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0001_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0001));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_15( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_stgmedium_union_record16( ecom_control_library::_STGMEDIUM_UNION a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_STGMEDIUM_UNION  to X_STGMEDIUM_UNION_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_STGMEDIUM_UNION_RECORD", sizeof (ecom_control_library::_STGMEDIUM_UNION));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iadvise_sink_0003_union17( ecom_control_library::__MIDL_IAdviseSink_0003 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IAdviseSink_0003  to X__MIDL_IADVISE_SINK_0003_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IADVISE_SINK_0003_UNION", sizeof (ecom_control_library::__MIDL_IAdviseSink_0003));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_byte_blob_record18( ecom_control_library::_BYTE_BLOB a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_BYTE_BLOB  to X_BYTE_BLOB_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_BYTE_BLOB_RECORD", sizeof (ecom_control_library::_BYTE_BLOB));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_19( ecom_control_library::_BYTE_BLOB * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_BYTE_BLOB *  to X_BYTE_BLOB_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_BYTE_BLOB_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_hglobal_record20( ecom_control_library::_userHGLOBAL a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHGLOBAL  to X_USER_HGLOBAL_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_HGLOBAL_RECORD", sizeof (ecom_control_library::_userHGLOBAL));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_21( ecom_control_library::_userHGLOBAL * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHGLOBAL *  to X_USER_HGLOBAL_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_HGLOBAL_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_gdi_object_record22( ecom_control_library::_GDI_OBJECT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_GDI_OBJECT  to X_GDI_OBJECT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_GDI_OBJECT_RECORD", sizeof (ecom_control_library::_GDI_OBJECT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_23( ecom_control_library::_GDI_OBJECT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_GDI_OBJECT *  to X_GDI_OBJECT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_GDI_OBJECT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_henhmetafile_record24( ecom_control_library::_userHENHMETAFILE a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHENHMETAFILE  to X_USER_HENHMETAFILE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_HENHMETAFILE_RECORD", sizeof (ecom_control_library::_userHENHMETAFILE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_25( ecom_control_library::_userHENHMETAFILE * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHENHMETAFILE *  to X_USER_HENHMETAFILE_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_HENHMETAFILE_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_hmetafilepict_record26( ecom_control_library::_userHMETAFILEPICT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHMETAFILEPICT  to X_USER_HMETAFILEPICT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_HMETAFILEPICT_RECORD", sizeof (ecom_control_library::_userHMETAFILEPICT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_27( ecom_control_library::_userHMETAFILEPICT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHMETAFILEPICT *  to X_USER_HMETAFILEPICT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_HMETAFILEPICT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0005_union28( ecom_control_library::__MIDL_IWinTypes_0005 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0005  to X__MIDL_IWIN_TYPES_0005_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0005_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0005));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_remote_metafilepict_record29( ecom_control_library::_remoteMETAFILEPICT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_remoteMETAFILEPICT  to X_REMOTE_METAFILEPICT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_REMOTE_METAFILEPICT_RECORD", sizeof (ecom_control_library::_remoteMETAFILEPICT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_30( ecom_control_library::_remoteMETAFILEPICT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_remoteMETAFILEPICT *  to X_REMOTE_METAFILEPICT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_REMOTE_METAFILEPICT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_hmetafile_record31( ecom_control_library::_userHMETAFILE a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHMETAFILE  to X_USER_HMETAFILE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_HMETAFILE_RECORD", sizeof (ecom_control_library::_userHMETAFILE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_32( ecom_control_library::_userHMETAFILE * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHMETAFILE *  to X_USER_HMETAFILE_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_HMETAFILE_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0004_union33( ecom_control_library::__MIDL_IWinTypes_0004 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0004  to X__MIDL_IWIN_TYPES_0004_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0004_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0004));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_34( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0006_union35( ecom_control_library::__MIDL_IWinTypes_0006 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0006  to X__MIDL_IWIN_TYPES_0006_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0006_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0006));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iadvise_sink_0002_union36( ecom_control_library::__MIDL_IAdviseSink_0002 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IAdviseSink_0002  to X__MIDL_IADVISE_SINK_0002_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IADVISE_SINK_0002_UNION", sizeof (ecom_control_library::__MIDL_IAdviseSink_0002));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_hpalette_record37( ecom_control_library::_userHPALETTE a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHPALETTE  to X_USER_HPALETTE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_HPALETTE_RECORD", sizeof (ecom_control_library::_userHPALETTE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_38( ecom_control_library::_userHPALETTE * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHPALETTE *  to X_USER_HPALETTE_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_HPALETTE_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_hbitmap_record39( ecom_control_library::_userHBITMAP a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHBITMAP  to X_USER_HBITMAP_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_HBITMAP_RECORD", sizeof (ecom_control_library::_userHBITMAP));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_40( ecom_control_library::_userHBITMAP * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userHBITMAP *  to X_USER_HBITMAP_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_HBITMAP_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0007_union41( ecom_control_library::__MIDL_IWinTypes_0007 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0007  to X__MIDL_IWIN_TYPES_0007_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0007_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0007));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_bitmap_record42( ecom_control_library::_userBITMAP a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userBITMAP  to X_USER_BITMAP_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_BITMAP_RECORD", sizeof (ecom_control_library::_userBITMAP));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_43( ecom_control_library::_userBITMAP * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userBITMAP *  to X_USER_BITMAP_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_BITMAP_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_44( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0008_union45( ecom_control_library::__MIDL_IWinTypes_0008 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0008  to X__MIDL_IWIN_TYPES_0008_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0008_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0008));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_logpalette_record46( ecom_control_library::tagLOGPALETTE a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagLOGPALETTE  to TAG_LOGPALETTE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_LOGPALETTE_RECORD", sizeof (ecom_control_library::tagLOGPALETTE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_47( ecom_control_library::tagLOGPALETTE * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagLOGPALETTE *  to TAG_LOGPALETTE_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_LOGPALETTE_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_paletteentry_record48( ecom_control_library::tagPALETTEENTRY a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPALETTEENTRY  to TAG_PALETTEENTRY_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_PALETTEENTRY_RECORD", sizeof (ecom_control_library::tagPALETTEENTRY));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_49( ecom_control_library::tagPALETTEENTRY * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPALETTEENTRY *  to TAG_PALETTEENTRY_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_PALETTEENTRY_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iwin_types_0003_union50( ecom_control_library::__MIDL_IWinTypes_0003 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IWinTypes_0003  to X__MIDL_IWIN_TYPES_0003_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0003_UNION", sizeof (ecom_control_library::__MIDL_IWinTypes_0003));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_flagged_byte_blob_record51( ecom_control_library::_FLAGGED_BYTE_BLOB a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_FLAGGED_BYTE_BLOB  to X_FLAGGED_BYTE_BLOB_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_FLAGGED_BYTE_BLOB_RECORD", sizeof (ecom_control_library::_FLAGGED_BYTE_BLOB));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_52( ecom_control_library::_FLAGGED_BYTE_BLOB * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_FLAGGED_BYTE_BLOB *  to X_FLAGGED_BYTE_BLOB_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_FLAGGED_BYTE_BLOB_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_53( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_55( ecom_control_library::IBindCtx * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IBindCtx *  to IBIND_CTX_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IBIND_CTX_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_ecom_guid56( GUID a_record )

/*-----------------------------------------------------------
	Convert GUID  to ECOM_GUID.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "ECOM_GUID", sizeof (GUID));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_57( GUID * a_record_pointer )

/*-----------------------------------------------------------
	Convert GUID *  to ECOM_GUID.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_GUID");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_58( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_58( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_59( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_59( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_60( ecom_control_library::IMoniker * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IMoniker * *  to CELL [IMONIKER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IMONIKER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IMoniker * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_8 (*(ecom_control_library::IMoniker * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_60( ecom_control_library::IMoniker * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IMoniker * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_62( ecom_control_library::IEnumMoniker * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumMoniker *  to IENUM_MONIKER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_MONIKER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_63( ecom_control_library::IEnumMoniker * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumMoniker * *  to CELL [IENUM_MONIKER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_MONIKER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumMoniker * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_62 (*(ecom_control_library::IEnumMoniker * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_63( ecom_control_library::IEnumMoniker * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumMoniker * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_64( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_filetime_record65( ecom_control_library::_FILETIME a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_FILETIME  to X_FILETIME_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_FILETIME_RECORD", sizeof (ecom_control_library::_FILETIME));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_66( ecom_control_library::_FILETIME * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_FILETIME *  to X_FILETIME_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_FILETIME_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_67( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_67( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_68( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_69( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_71( ecom_control_library::IStream * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IStream *  to ISTREAM_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ISTREAM_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_ularge_integer_record72( ecom_control_library::_ULARGE_INTEGER a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_ULARGE_INTEGER  to X_ULARGE_INTEGER_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_ULARGE_INTEGER_RECORD", sizeof (ecom_control_library::_ULARGE_INTEGER));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_73( ecom_control_library::_ULARGE_INTEGER * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_ULARGE_INTEGER *  to X_ULARGE_INTEGER_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_ULARGE_INTEGER_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_large_integer_record74( ecom_control_library::_LARGE_INTEGER a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_LARGE_INTEGER  to X_LARGE_INTEGER_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_LARGE_INTEGER_RECORD", sizeof (ecom_control_library::_LARGE_INTEGER));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_statstg_record75( ecom_control_library::tagSTATSTG a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSTATSTG  to TAG_STATSTG_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_STATSTG_RECORD", sizeof (ecom_control_library::tagSTATSTG));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_76( ecom_control_library::tagSTATSTG * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSTATSTG *  to TAG_STATSTG_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_STATSTG_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_77( ecom_control_library::IStream * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IStream * *  to CELL [ISTREAM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ISTREAM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IStream * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_71 (*(ecom_control_library::IStream * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_77( ecom_control_library::IStream * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IStream * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_78( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_79( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_80( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_81( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_bind_opts2_record82( ecom_control_library::tagBIND_OPTS2 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagBIND_OPTS2  to TAG_BIND_OPTS2_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_BIND_OPTS2_RECORD", sizeof (ecom_control_library::tagBIND_OPTS2));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_83( ecom_control_library::tagBIND_OPTS2 * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagBIND_OPTS2 *  to TAG_BIND_OPTS2_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_BIND_OPTS2_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_85( ecom_control_library::IRunningObjectTable * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IRunningObjectTable *  to IRUNNING_OBJECT_TABLE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IRUNNING_OBJECT_TABLE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_86( ecom_control_library::IRunningObjectTable * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IRunningObjectTable * *  to CELL [IRUNNING_OBJECT_TABLE_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IRUNNING_OBJECT_TABLE_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IRunningObjectTable * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_85 (*(ecom_control_library::IRunningObjectTable * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_86( ecom_control_library::IRunningObjectTable * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IRunningObjectTable * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_87( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_87( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_89( ecom_control_library::IEnumString * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumString *  to IENUM_STRING_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_STRING_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_90( ecom_control_library::IEnumString * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumString * *  to CELL [IENUM_STRING_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_STRING_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumString * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_89 (*(ecom_control_library::IEnumString * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_90( ecom_control_library::IEnumString * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumString * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_coserverinfo_record91( ecom_control_library::_COSERVERINFO a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_COSERVERINFO  to X_COSERVERINFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_COSERVERINFO_RECORD", sizeof (ecom_control_library::_COSERVERINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_92( ecom_control_library::_COSERVERINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_COSERVERINFO *  to X_COSERVERINFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_COSERVERINFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_coauthinfo_record93( ecom_control_library::_COAUTHINFO a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_COAUTHINFO  to X_COAUTHINFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_COAUTHINFO_RECORD", sizeof (ecom_control_library::_COAUTHINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_94( ecom_control_library::_COAUTHINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_COAUTHINFO *  to X_COAUTHINFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_COAUTHINFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_coauthidentity_record95( ecom_control_library::_COAUTHIDENTITY a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_COAUTHIDENTITY  to X_COAUTHIDENTITY_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_COAUTHIDENTITY_RECORD", sizeof (ecom_control_library::_COAUTHIDENTITY));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_96( ecom_control_library::_COAUTHIDENTITY * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_COAUTHIDENTITY *  to X_COAUTHIDENTITY_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_COAUTHIDENTITY_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_97( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_98( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_99( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_100( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_101( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_101( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_102( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_103( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_103( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_104( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_106( ecom_control_library::IDataObject * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IDataObject *  to IDATA_OBJECT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IDATA_OBJECT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_108( ecom_control_library::IAdviseSink * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IAdviseSink *  to IADVISE_SINK_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IADVISE_SINK_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_109( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_111( ecom_control_library::IEnumSTATDATA * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumSTATDATA *  to IENUM_STATDATA_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_STATDATA_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_112( ecom_control_library::IEnumSTATDATA * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumSTATDATA * *  to CELL [IENUM_STATDATA_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_STATDATA_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumSTATDATA * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_111 (*(ecom_control_library::IEnumSTATDATA * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_112( ecom_control_library::IEnumSTATDATA * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumSTATDATA * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_stgmedium_alias113( ecom_control_library::wireSTGMEDIUM an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireSTGMEDIUM  to WIRE_STGMEDIUM_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_STGMEDIUM_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_5 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_114( ecom_control_library::wireSTGMEDIUM * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireSTGMEDIUM *  to CELL [WIRE_STGMEDIUM_ALIAS].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [WIRE_STGMEDIUM_ALIAS]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::wireSTGMEDIUM *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_alias_wire_stgmedium_alias113 (*(ecom_control_library::wireSTGMEDIUM *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_114( ecom_control_library::wireSTGMEDIUM * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireSTGMEDIUM *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_user_flag_stgmedium_record116( ecom_control_library::_userFLAG_STGMEDIUM a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userFLAG_STGMEDIUM  to X_USER_FLAG_STGMEDIUM_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_USER_FLAG_STGMEDIUM_RECORD", sizeof (ecom_control_library::_userFLAG_STGMEDIUM));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_117( ecom_control_library::_userFLAG_STGMEDIUM * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_userFLAG_STGMEDIUM *  to X_USER_FLAG_STGMEDIUM_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_USER_FLAG_STGMEDIUM_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_flag_stgmedium_alias115( ecom_control_library::wireFLAG_STGMEDIUM an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireFLAG_STGMEDIUM  to WIRE_FLAG_STGMEDIUM_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_FLAG_STGMEDIUM_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_117 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_118( ecom_control_library::wireFLAG_STGMEDIUM * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireFLAG_STGMEDIUM *  to CELL [WIRE_FLAG_STGMEDIUM_ALIAS].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [WIRE_FLAG_STGMEDIUM_ALIAS]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::wireFLAG_STGMEDIUM *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_alias_wire_flag_stgmedium_alias115 (*(ecom_control_library::wireFLAG_STGMEDIUM *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_118( ecom_control_library::wireFLAG_STGMEDIUM * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireFLAG_STGMEDIUM *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_120( ecom_control_library::IEnumFORMATETC * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumFORMATETC *  to IENUM_FORMATETC_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_FORMATETC_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_121( ecom_control_library::IEnumFORMATETC * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumFORMATETC * *  to CELL [IENUM_FORMATETC_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_FORMATETC_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumFORMATETC * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_120 (*(ecom_control_library::IEnumFORMATETC * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_121( ecom_control_library::IEnumFORMATETC * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumFORMATETC * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_122( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_123( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_statdata_record124( ecom_control_library::tagSTATDATA a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSTATDATA  to TAG_STATDATA_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_STATDATA_RECORD", sizeof (ecom_control_library::tagSTATDATA));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_125( ecom_control_library::tagSTATDATA * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSTATDATA *  to TAG_STATDATA_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_STATDATA_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_126( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_127( HRESULT * a_pointer )

/*-----------------------------------------------------------
	Free memory of HRESULT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_128( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_129( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_130( HRESULT * a_pointer )

/*-----------------------------------------------------------
	Free memory of HRESULT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_131( HRESULT * a_pointer )

/*-----------------------------------------------------------
	Free memory of HRESULT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_132( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_132( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_133( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_133( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_134( IDispatch * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IDispatch * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IDispatch * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_dispatch (*(IDispatch * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_134( IDispatch * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IDispatch * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_135( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_135( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_136( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_136( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_pointl_record137( ecom_control_library::_POINTL a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_POINTL  to X_POINTL_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_POINTL_RECORD", sizeof (ecom_control_library::_POINTL));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_138( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_139( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_140( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_connectdata_record141( ecom_control_library::tagCONNECTDATA a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCONNECTDATA  to TAG_CONNECTDATA_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_CONNECTDATA_RECORD", sizeof (ecom_control_library::tagCONNECTDATA));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_142( ecom_control_library::tagCONNECTDATA * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCONNECTDATA *  to TAG_CONNECTDATA_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_CONNECTDATA_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_143( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_145( ecom_control_library::IEnumConnections * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumConnections *  to IENUM_CONNECTIONS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_CONNECTIONS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_146( ecom_control_library::IEnumConnections * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumConnections * *  to CELL [IENUM_CONNECTIONS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_CONNECTIONS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumConnections * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_145 (*(ecom_control_library::IEnumConnections * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_146( ecom_control_library::IEnumConnections * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumConnections * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_148( ecom_control_library::IConnectionPoint * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IConnectionPoint *  to ICONNECTION_POINT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ICONNECTION_POINT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_149( ecom_control_library::IConnectionPoint * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IConnectionPoint * *  to CELL [ICONNECTION_POINT_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ICONNECTION_POINT_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IConnectionPoint * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_148 (*(ecom_control_library::IConnectionPoint * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_149( ecom_control_library::IConnectionPoint * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IConnectionPoint * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_150( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_152( ecom_control_library::IEnumConnectionPoints * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumConnectionPoints *  to IENUM_CONNECTION_POINTS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_CONNECTION_POINTS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_153( ecom_control_library::IEnumConnectionPoints * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumConnectionPoints * *  to CELL [IENUM_CONNECTION_POINTS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_CONNECTION_POINTS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumConnectionPoints * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_152 (*(ecom_control_library::IEnumConnectionPoints * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_153( ecom_control_library::IEnumConnectionPoints * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumConnectionPoints * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_155( ecom_control_library::IConnectionPointContainer * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IConnectionPointContainer *  to ICONNECTION_POINT_CONTAINER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ICONNECTION_POINT_CONTAINER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_156( ecom_control_library::IConnectionPointContainer * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IConnectionPointContainer * *  to CELL [ICONNECTION_POINT_CONTAINER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ICONNECTION_POINT_CONTAINER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IConnectionPointContainer * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_155 (*(ecom_control_library::IConnectionPointContainer * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_156( ecom_control_library::IConnectionPointContainer * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IConnectionPointContainer * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_157( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_159( ecom_control_library::IOleUndoUnit * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleUndoUnit *  to IOLE_UNDO_UNIT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_UNDO_UNIT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_160( ecom_control_library::IOleUndoUnit * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleUndoUnit * *  to CELL [IOLE_UNDO_UNIT_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IOLE_UNDO_UNIT_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IOleUndoUnit * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_159 (*(ecom_control_library::IOleUndoUnit * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_160( ecom_control_library::IOleUndoUnit * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IOleUndoUnit * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_161( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_163( ecom_control_library::IEnumOleUndoUnits * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumOleUndoUnits *  to IENUM_OLE_UNDO_UNITS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_OLE_UNDO_UNITS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_164( ecom_control_library::IEnumOleUndoUnits * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumOleUndoUnits * *  to CELL [IENUM_OLE_UNDO_UNITS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_OLE_UNDO_UNITS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumOleUndoUnits * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_163 (*(ecom_control_library::IEnumOleUndoUnits * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_164( ecom_control_library::IEnumOleUndoUnits * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumOleUndoUnits * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_166( ecom_control_library::IOleUndoManager * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleUndoManager *  to IOLE_UNDO_MANAGER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_UNDO_MANAGER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_167( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_167( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_168( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_170( ecom_control_library::IOleParentUndoUnit * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleParentUndoUnit *  to IOLE_PARENT_UNDO_UNIT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_PARENT_UNDO_UNIT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_171( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_172( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_172( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_173( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_173( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_174( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_oleverb_record175( ecom_control_library::tagOLEVERB a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagOLEVERB  to TAG_OLEVERB_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_OLEVERB_RECORD", sizeof (ecom_control_library::tagOLEVERB));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_176( ecom_control_library::tagOLEVERB * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagOLEVERB *  to TAG_OLEVERB_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_OLEVERB_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_177( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_179( ecom_control_library::IEnumOLEVERB * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumOLEVERB *  to IENUM_OLEVERB_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_OLEVERB_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_180( ecom_control_library::IEnumOLEVERB * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumOLEVERB * *  to CELL [IENUM_OLEVERB_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_OLEVERB_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumOLEVERB * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_179 (*(ecom_control_library::IEnumOLEVERB * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_180( ecom_control_library::IEnumOLEVERB * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumOLEVERB * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_ecom_excep_info181( EXCEPINFO a_record )

/*-----------------------------------------------------------
	Convert EXCEPINFO  to ECOM_EXCEP_INFO.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "ECOM_EXCEP_INFO", sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_182( EXCEPINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert EXCEPINFO *  to ECOM_EXCEP_INFO.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_EXCEP_INFO");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_183( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_184( void * * a_pointer )

/*-----------------------------------------------------------
	Free memory of void * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_185( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_187( ecom_control_library::IOleContainer * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleContainer *  to IOLE_CONTAINER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_CONTAINER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_188( ecom_control_library::IOleContainer * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleContainer * *  to CELL [IOLE_CONTAINER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IOLE_CONTAINER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IOleContainer * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_187 (*(ecom_control_library::IOleContainer * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_188( ecom_control_library::IOleContainer * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IOleContainer * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_190( ecom_control_library::IEnumUnknown * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumUnknown *  to IENUM_UNKNOWN_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_UNKNOWN_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_191( ecom_control_library::IEnumUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumUnknown * *  to CELL [IENUM_UNKNOWN_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_UNKNOWN_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_190 (*(ecom_control_library::IEnumUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_191( ecom_control_library::IEnumUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_192( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_193( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_193( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_194( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_controlinfo_record195( ecom_control_library::tagCONTROLINFO a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCONTROLINFO  to TAG_CONTROLINFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_CONTROLINFO_RECORD", sizeof (ecom_control_library::tagCONTROLINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_196( ecom_control_library::tagCONTROLINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCONTROLINFO *  to TAG_CONTROLINFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_CONTROLINFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_msg_record197( ecom_control_library::tagMSG a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagMSG  to TAG_MSG_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_MSG_RECORD", sizeof (ecom_control_library::tagMSG));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_198( ecom_control_library::tagMSG * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagMSG *  to TAG_MSG_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_MSG_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_201( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::free_memory_199( ecom_control_library::wireHACCEL a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireHACCEL.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::free_memory_202( ecom_control_library::wireHWND a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireHWND.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_point_record203( ecom_control_library::tagPOINT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPOINT  to TAG_POINT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_POINT_RECORD", sizeof (ecom_control_library::tagPOINT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_204( IDispatch * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IDispatch * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IDispatch * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_dispatch (*(IDispatch * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_204( IDispatch * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IDispatch * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_205( ecom_control_library::_POINTL * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_POINTL *  to X_POINTL_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_POINTL_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_pointf_record206( ecom_control_library::tagPOINTF a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPOINTF  to TAG_POINTF_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_POINTF_RECORD", sizeof (ecom_control_library::tagPOINTF));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_207( ecom_control_library::tagPOINTF * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPOINTF *  to TAG_POINTF_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_POINTF_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_208( ecom_control_library::wireHWND * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireHWND *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_rect_record209( ecom_control_library::tagRECT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRECT  to TAG_RECT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_RECT_RECORD", sizeof (ecom_control_library::tagRECT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_210( ecom_control_library::tagRECT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRECT *  to TAG_RECT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_RECT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_212( ecom_control_library::IOleInPlaceUIWindow * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleInPlaceUIWindow *  to IOLE_IN_PLACE_UIWINDOW_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_IN_PLACE_UIWINDOW_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_214( ecom_control_library::IOleInPlaceActiveObject * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleInPlaceActiveObject *  to IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_IN_PLACE_ACTIVE_OBJECT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::free_memory_215( ecom_control_library::wireHMENU a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireHMENU.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_ole_menu_group_widths_record216( ecom_control_library::tagOleMenuGroupWidths a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagOleMenuGroupWidths  to TAG_OLE_MENU_GROUP_WIDTHS_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_OLE_MENU_GROUP_WIDTHS_RECORD", sizeof (ecom_control_library::tagOleMenuGroupWidths));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_217( ecom_control_library::tagOleMenuGroupWidths * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagOleMenuGroupWidths *  to TAG_OLE_MENU_GROUP_WIDTHS_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_OLE_MENU_GROUP_WIDTHS_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_hglobal_alias218( ecom_control_library::wireHGLOBAL an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireHGLOBAL  to WIRE_HGLOBAL_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_HGLOBAL_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_21 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_array_long_219( LONG* an_array, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LONG[6]  to ARRAY [INTEGER].
-----------------------------------------------------------*/
{
	EIF_INTEGER some_element_counts [1];
	
	some_element_counts [0] = 6;
	
	return rt_ce.ccom_ce_array_long (an_array, 1, some_element_counts, an_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_220( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_222( ecom_control_library::IDropTarget * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IDropTarget *  to IDROP_TARGET_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IDROP_TARGET_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_223( ecom_control_library::IDropTarget * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IDropTarget * *  to CELL [IDROP_TARGET_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IDROP_TARGET_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IDropTarget * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_222 (*(ecom_control_library::IDropTarget * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_223( ecom_control_library::IDropTarget * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IDropTarget * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_225( ecom_control_library::IOleInPlaceFrame * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleInPlaceFrame *  to IOLE_IN_PLACE_FRAME_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_IN_PLACE_FRAME_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_226( ecom_control_library::IOleInPlaceFrame * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleInPlaceFrame * *  to CELL [IOLE_IN_PLACE_FRAME_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IOLE_IN_PLACE_FRAME_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IOleInPlaceFrame * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_225 (*(ecom_control_library::IOleInPlaceFrame * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_226( ecom_control_library::IOleInPlaceFrame * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IOleInPlaceFrame * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_227( ecom_control_library::IOleInPlaceUIWindow * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleInPlaceUIWindow * *  to CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IOleInPlaceUIWindow * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_212 (*(ecom_control_library::IOleInPlaceUIWindow * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_227( ecom_control_library::IOleInPlaceUIWindow * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IOleInPlaceUIWindow * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_oifi_record228( ecom_control_library::tagOIFI a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagOIFI  to TAG_OIFI_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_OIFI_RECORD", sizeof (ecom_control_library::tagOIFI));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_229( ecom_control_library::tagOIFI * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagOIFI *  to TAG_OIFI_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_OIFI_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_size_record230( ecom_control_library::tagSIZE a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSIZE  to TAG_SIZE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_SIZE_RECORD", sizeof (ecom_control_library::tagSIZE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_231( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::free_memory_232( ecom_control_library::wireHDC a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireHDC.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_233( ecom_control_library::wireHDC * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::wireHDC *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_234( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_235( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_236( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_237( void * * a_pointer )

/*-----------------------------------------------------------
	Free memory of void * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_238( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_239( void * * a_pointer )

/*-----------------------------------------------------------
	Free memory of void * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_240( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_241( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_241( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_242( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_242( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_244( ecom_control_library::IOleClientSite * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleClientSite *  to IOLE_CLIENT_SITE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_CLIENT_SITE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_245( ecom_control_library::IOleClientSite * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleClientSite * *  to CELL [IOLE_CLIENT_SITE_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IOLE_CLIENT_SITE_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IOleClientSite * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_244 (*(ecom_control_library::IOleClientSite * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_245( ecom_control_library::IOleClientSite * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IOleClientSite * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_246( ecom_control_library::IDataObject * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IDataObject * *  to CELL [IDATA_OBJECT_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IDATA_OBJECT_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IDataObject * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_106 (*(ecom_control_library::IDataObject * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_246( ecom_control_library::IDataObject * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IDataObject * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_247( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_247( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_sizel_record248( ecom_control_library::tagSIZEL a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSIZEL  to TAG_SIZEL_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_SIZEL_RECORD", sizeof (ecom_control_library::tagSIZEL));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_249( ecom_control_library::tagSIZEL * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSIZEL *  to TAG_SIZEL_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_SIZEL_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_250( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_251( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_252( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_252( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_calpolestr_record253( ecom_control_library::tagCALPOLESTR a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCALPOLESTR  to TAG_CALPOLESTR_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_CALPOLESTR_RECORD", sizeof (ecom_control_library::tagCALPOLESTR));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_254( ecom_control_library::tagCALPOLESTR * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCALPOLESTR *  to TAG_CALPOLESTR_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_CALPOLESTR_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_cadword_record255( ecom_control_library::tagCADWORD a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCADWORD  to TAG_CADWORD_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_CADWORD_RECORD", sizeof (ecom_control_library::tagCADWORD));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_256( ecom_control_library::tagCADWORD * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCADWORD *  to TAG_CADWORD_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_CADWORD_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_257( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_258( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_258( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_259( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_260( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_260( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_261( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_262( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_263( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_265( ecom_control_library::IPropertyBag * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IPropertyBag *  to IPROPERTY_BAG_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IPROPERTY_BAG_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_267( ecom_control_library::IErrorLog * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IErrorLog *  to IERROR_LOG_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IERROR_LOG_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_268( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_269( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_271( ecom_control_library::IPropertyBag2 * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IPropertyBag2 *  to IPROPERTY_BAG2_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IPROPERTY_BAG2_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_propbag2_record272( ecom_control_library::tagPROPBAG2 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPROPBAG2  to TAG_PROPBAG2_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_PROPBAG2_RECORD", sizeof (ecom_control_library::tagPROPBAG2));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_273( ecom_control_library::tagPROPBAG2 * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPROPBAG2 *  to TAG_PROPBAG2_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_PROPBAG2_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_274( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_275( HRESULT * a_pointer )

/*-----------------------------------------------------------
	Free memory of HRESULT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_276( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_277( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_278( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_280( ecom_control_library::IStorage * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IStorage *  to ISTORAGE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ISTORAGE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_281( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_282( ecom_control_library::IStorage * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IStorage * *  to CELL [ISTORAGE_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ISTORAGE_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IStorage * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_280 (*(ecom_control_library::IStorage * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_282( ecom_control_library::IStorage * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IStorage * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_rem_snb_record284( ecom_control_library::tagRemSNB a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRemSNB  to TAG_REM_SNB_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_REM_SNB_RECORD", sizeof (ecom_control_library::tagRemSNB));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_285( ecom_control_library::tagRemSNB * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRemSNB *  to TAG_REM_SNB_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_REM_SNB_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_snb_alias283( ecom_control_library::wireSNB an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireSNB  to WIRE_SNB_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_SNB_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_285 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_286( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_288( ecom_control_library::IEnumSTATSTG * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumSTATSTG *  to IENUM_STATSTG_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_STATSTG_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_289( ecom_control_library::IEnumSTATSTG * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IEnumSTATSTG * *  to CELL [IENUM_STATSTG_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_STATSTG_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IEnumSTATSTG * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_288 (*(ecom_control_library::IEnumSTATSTG * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_289( ecom_control_library::IEnumSTATSTG * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IEnumSTATSTG * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_290( SHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_291( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_292( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_294( ecom_control_library::IPropertyPageSite * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IPropertyPageSite *  to IPROPERTY_PAGE_SITE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IPROPERTY_PAGE_SITE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_proppageinfo_record295( ecom_control_library::tagPROPPAGEINFO a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPROPPAGEINFO  to TAG_PROPPAGEINFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_PROPPAGEINFO_RECORD", sizeof (ecom_control_library::tagPROPPAGEINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_296( ecom_control_library::tagPROPPAGEINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPROPPAGEINFO *  to TAG_PROPPAGEINFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_PROPPAGEINFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_297( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_297( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_298( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_299( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_299( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_301( ecom_control_library::ITypeInfo_2 * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::ITypeInfo_2 *  to ITYPE_INFO_2_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ITYPE_INFO_2_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_302( ecom_control_library::ITypeInfo_2 * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::ITypeInfo_2 * *  to CELL [ITYPE_INFO_2_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ITYPE_INFO_2_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::ITypeInfo_2 * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_301 (*(ecom_control_library::ITypeInfo_2 * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_302( ecom_control_library::ITypeInfo_2 * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::ITypeInfo_2 * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_typeattr_record303( ecom_control_library::tagTYPEATTR a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTYPEATTR  to TAG_TYPEATTR_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_TYPEATTR_RECORD", sizeof (ecom_control_library::tagTYPEATTR));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_304( ecom_control_library::tagTYPEATTR * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTYPEATTR *  to TAG_TYPEATTR_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_TYPEATTR_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_305( ecom_control_library::tagTYPEATTR * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTYPEATTR * *  to CELL [TAG_TYPEATTR_RECORD].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [TAG_TYPEATTR_RECORD]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::tagTYPEATTR * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_record_304 (*(ecom_control_library::tagTYPEATTR * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_305( ecom_control_library::tagTYPEATTR * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::tagTYPEATTR * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_307( ecom_control_library::DWORD1 * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::DWORD1 *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_309( ecom_control_library::ITypeComp * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::ITypeComp *  to ITYPE_COMP_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ITYPE_COMP_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_310( ecom_control_library::ITypeComp * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::ITypeComp * *  to CELL [ITYPE_COMP_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ITYPE_COMP_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::ITypeComp * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_309 (*(ecom_control_library::ITypeComp * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_310( ecom_control_library::ITypeComp * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::ITypeComp * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_funcdesc_record311( ecom_control_library::tagFUNCDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagFUNCDESC  to TAG_FUNCDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_FUNCDESC_RECORD", sizeof (ecom_control_library::tagFUNCDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_312( ecom_control_library::tagFUNCDESC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagFUNCDESC *  to TAG_FUNCDESC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_FUNCDESC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_313( ecom_control_library::tagFUNCDESC * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagFUNCDESC * *  to CELL [TAG_FUNCDESC_RECORD].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [TAG_FUNCDESC_RECORD]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::tagFUNCDESC * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_record_312 (*(ecom_control_library::tagFUNCDESC * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_313( ecom_control_library::tagFUNCDESC * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::tagFUNCDESC * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_vardesc_record314( ecom_control_library::tagVARDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagVARDESC  to TAG_VARDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_VARDESC_RECORD", sizeof (ecom_control_library::tagVARDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_315( ecom_control_library::tagVARDESC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagVARDESC *  to TAG_VARDESC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_VARDESC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_316( ecom_control_library::tagVARDESC * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagVARDESC * *  to CELL [TAG_VARDESC_RECORD].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [TAG_VARDESC_RECORD]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::tagVARDESC * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_record_315 (*(ecom_control_library::tagVARDESC * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_316( ecom_control_library::tagVARDESC * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::tagVARDESC * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_317( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_317( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_318( UINT * a_pointer )

/*-----------------------------------------------------------
	Free memory of UINT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_319( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_320( INT * a_pointer )

/*-----------------------------------------------------------
	Free memory of INT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_321( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_321( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_322( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_322( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_323( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_324( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_324( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_326( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_326( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_327( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_327( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_328( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_329( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_329( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_330( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_330( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_332( ecom_control_library::ITypeLib_2 * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::ITypeLib_2 *  to ITYPE_LIB_2_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ITYPE_LIB_2_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_333( ecom_control_library::ITypeLib_2 * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::ITypeLib_2 * *  to CELL [ITYPE_LIB_2_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ITYPE_LIB_2_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::ITypeLib_2 * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_332 (*(ecom_control_library::ITypeLib_2 * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_333( ecom_control_library::ITypeLib_2 * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::ITypeLib_2 * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_334( UINT * a_pointer )

/*-----------------------------------------------------------
	Free memory of UINT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_typedesc_record336( ecom_control_library::tagTYPEDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTYPEDESC  to TAG_TYPEDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_TYPEDESC_RECORD", sizeof (ecom_control_library::tagTYPEDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_idldesc_record337( ecom_control_library::tagIDLDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagIDLDESC  to TAG_IDLDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_IDLDESC_RECORD", sizeof (ecom_control_library::tagIDLDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iole_automation_types_0005_union338( ecom_control_library::__MIDL_IOleAutomationTypes_0005 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IOleAutomationTypes_0005  to X__MIDL_IOLE_AUTOMATION_TYPES_0005_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IOLE_AUTOMATION_TYPES_0005_UNION", sizeof (ecom_control_library::__MIDL_IOleAutomationTypes_0005));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_arraydesc_record339( ecom_control_library::tagARRAYDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagARRAYDESC  to TAG_ARRAYDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_ARRAYDESC_RECORD", sizeof (ecom_control_library::tagARRAYDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_340( ecom_control_library::tagARRAYDESC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagARRAYDESC *  to TAG_ARRAYDESC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_ARRAYDESC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_341( ecom_control_library::tagTYPEDESC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTYPEDESC *  to TAG_TYPEDESC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_TYPEDESC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_safearraybound_record342( ecom_control_library::tagSAFEARRAYBOUND a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSAFEARRAYBOUND  to TAG_SAFEARRAYBOUND_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_SAFEARRAYBOUND_RECORD", sizeof (ecom_control_library::tagSAFEARRAYBOUND));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_343( ecom_control_library::tagSAFEARRAYBOUND * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagSAFEARRAYBOUND *  to TAG_SAFEARRAYBOUND_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_SAFEARRAYBOUND_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_345( long * a_pointer )

/*-----------------------------------------------------------
	Free memory of long *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_346( HRESULT * a_pointer )

/*-----------------------------------------------------------
	Free memory of HRESULT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_elemdesc_record347( ecom_control_library::tagELEMDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagELEMDESC  to TAG_ELEMDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_ELEMDESC_RECORD", sizeof (ecom_control_library::tagELEMDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_348( ecom_control_library::tagELEMDESC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagELEMDESC *  to TAG_ELEMDESC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_ELEMDESC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_paramdesc_record351( ecom_control_library::tagPARAMDESC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPARAMDESC  to TAG_PARAMDESC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_PARAMDESC_RECORD", sizeof (ecom_control_library::tagPARAMDESC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_paramdescex_record352( ecom_control_library::tagPARAMDESCEX a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPARAMDESCEX  to TAG_PARAMDESCEX_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_PARAMDESCEX_RECORD", sizeof (ecom_control_library::tagPARAMDESCEX));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_353( ecom_control_library::tagPARAMDESCEX * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPARAMDESCEX *  to TAG_PARAMDESCEX_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_PARAMDESCEX_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x__midl_iole_automation_types_0006_union354( ecom_control_library::__MIDL_IOleAutomationTypes_0006 a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::__MIDL_IOleAutomationTypes_0006  to X__MIDL_IOLE_AUTOMATION_TYPES_0006_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IOLE_AUTOMATION_TYPES_0006_UNION", sizeof (ecom_control_library::__MIDL_IOleAutomationTypes_0006));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_356( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_357( UINT * a_pointer )

/*-----------------------------------------------------------
	Free memory of UINT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_358( long * a_pointer )

/*-----------------------------------------------------------
	Free memory of long *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_tlibattr_record359( ecom_control_library::tagTLIBATTR a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTLIBATTR  to TAG_TLIBATTR_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_TLIBATTR_RECORD", sizeof (ecom_control_library::tagTLIBATTR));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_360( ecom_control_library::tagTLIBATTR * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTLIBATTR *  to TAG_TLIBATTR_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_TLIBATTR_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_361( ecom_control_library::tagTLIBATTR * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagTLIBATTR * *  to CELL [TAG_TLIBATTR_RECORD].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [TAG_TLIBATTR_RECORD]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::tagTLIBATTR * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_record_360 (*(ecom_control_library::tagTLIBATTR * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_361( ecom_control_library::tagTLIBATTR * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::tagTLIBATTR * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_362( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_362( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_363( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_363( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_364( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_365( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_365( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_366( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_367( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_367( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_368( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_369( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_370( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_370( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_372( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_373( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_374( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_375( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_376( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_377( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_cauuid_record378( ecom_control_library::tagCAUUID a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCAUUID  to TAG_CAUUID_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_CAUUID_RECORD", sizeof (ecom_control_library::tagCAUUID));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_379( ecom_control_library::tagCAUUID * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagCAUUID *  to TAG_CAUUID_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_CAUUID_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_rectl_record380( ecom_control_library::_RECTL a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_RECTL  to X_RECTL_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_RECTL_RECORD", sizeof (ecom_control_library::_RECTL));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_381( ecom_control_library::_RECTL * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_RECTL *  to X_RECTL_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_RECTL_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_383( ecom_control_library::IContinue * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IContinue *  to ICONTINUE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ICONTINUE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_384( ecom_control_library::tagLOGPALETTE * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagLOGPALETTE * *  to CELL [TAG_LOGPALETTE_RECORD].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [TAG_LOGPALETTE_RECORD]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::tagLOGPALETTE * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_record_47 (*(ecom_control_library::tagLOGPALETTE * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_384( ecom_control_library::tagLOGPALETTE * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::tagLOGPALETTE * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_385( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_386( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_387( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_388( ecom_control_library::IAdviseSink * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_control_library::IAdviseSink * *  to CELL [IADVISE_SINK_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IADVISE_SINK_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_control_library::IAdviseSink * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_108 (*(ecom_control_library::IAdviseSink * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_388( ecom_control_library::IAdviseSink * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_control_library::IAdviseSink * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_389( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_390( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_391( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_extent_info_record392( ecom_control_library::tagExtentInfo a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagExtentInfo  to TAG_EXTENT_INFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_EXTENT_INFO_RECORD", sizeof (ecom_control_library::tagExtentInfo));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_393( ecom_control_library::tagExtentInfo * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagExtentInfo *  to TAG_EXTENT_INFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_EXTENT_INFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_qacontainer_record394( ecom_control_library::tagQACONTAINER a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagQACONTAINER  to TAG_QACONTAINER_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_QACONTAINER_RECORD", sizeof (ecom_control_library::tagQACONTAINER));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_395( ecom_control_library::tagQACONTAINER * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagQACONTAINER *  to TAG_QACONTAINER_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_QACONTAINER_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_qacontrol_record396( ecom_control_library::tagQACONTROL a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagQACONTROL  to TAG_QACONTROL_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_QACONTROL_RECORD", sizeof (ecom_control_library::tagQACONTROL));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_397( ecom_control_library::tagQACONTROL * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagQACONTROL *  to TAG_QACONTROL_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_QACONTROL_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_399( ecom_control_library::IAdviseSinkEx * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IAdviseSinkEx *  to IADVISE_SINK_EX_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IADVISE_SINK_EX_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_401( ecom_control_library::IPropertyNotifySink * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IPropertyNotifySink *  to IPROPERTY_NOTIFY_SINK_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IPROPERTY_NOTIFY_SINK_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_404( IFont * a_interface_pointer )

/*-----------------------------------------------------------
	Convert IFont *  to IFONT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IFONT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_alias_wire_hpalette_alias405( ecom_control_library::wireHPALETTE an_alias )

/*-----------------------------------------------------------
	Convert ecom_control_library::wireHPALETTE  to WIRE_HPALETTE_ALIAS.
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("WIRE_HPALETTE_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_control_interfaces2.ccom_ce_pointed_record_38 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_407( ecom_control_library::IBindHost * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IBindHost *  to IBIND_HOST_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IBIND_HOST_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_409( ecom_control_library::IOleControlSite * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleControlSite *  to IOLE_CONTROL_SITE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_CONTROL_SITE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_411( ecom_control_library::IServiceProvider * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IServiceProvider *  to ISERVICE_PROVIDER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ISERVICE_PROVIDER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_413( ecom_control_library::IBindStatusCallback * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IBindStatusCallback *  to IBIND_STATUS_CALLBACK_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IBIND_STATUS_CALLBACK_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_414( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_414( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_415( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_415( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_417( ecom_control_library::IBinding * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IBinding *  to IBINDING_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IBINDING_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_418( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_419( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_tag_rem_bindinfo_record420( ecom_control_library::_tagRemBINDINFO a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_tagRemBINDINFO  to X_TAG_REM_BINDINFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_TAG_REM_BINDINFO_RECORD", sizeof (ecom_control_library::_tagRemBINDINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_421( ecom_control_library::_tagRemBINDINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_tagRemBINDINFO *  to X_TAG_REM_BINDINFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_TAG_REM_BINDINFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_rem_stgmedium_record422( ecom_control_library::tagRemSTGMEDIUM a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRemSTGMEDIUM  to TAG_REM_STGMEDIUM_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_REM_STGMEDIUM_RECORD", sizeof (ecom_control_library::tagRemSTGMEDIUM));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_423( ecom_control_library::tagRemSTGMEDIUM * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRemSTGMEDIUM *  to TAG_REM_STGMEDIUM_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_REM_STGMEDIUM_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_tag_rem_formatetc_record424( ecom_control_library::tagRemFORMATETC a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRemFORMATETC  to TAG_REM_FORMATETC_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "TAG_REM_FORMATETC_RECORD", sizeof (ecom_control_library::tagRemFORMATETC));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_425( ecom_control_library::tagRemFORMATETC * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagRemFORMATETC *  to TAG_REM_FORMATETC_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_REM_FORMATETC_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_426( LONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of LONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_427( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_428( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_428( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_remsecurity_attributes_record429( ecom_control_library::_REMSECURITY_ATTRIBUTES a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_REMSECURITY_ATTRIBUTES  to X_REMSECURITY_ATTRIBUTES_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_REMSECURITY_ATTRIBUTES_RECORD", sizeof (ecom_control_library::_REMSECURITY_ATTRIBUTES));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_430( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_431( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_431( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_432( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_432( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_433( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_434( void * * a_pointer )

/*-----------------------------------------------------------
	Free memory of void * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_436( ecom_control_library::IDocHostUIHandlerDispatch * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IDocHostUIHandlerDispatch *  to IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IDOC_HOST_UIHANDLER_DISPATCH_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_437( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_438( OLE_COLOR * a_pointer )

/*-----------------------------------------------------------
	Free memory of OLE_COLOR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_439( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_440( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_441( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_443( Font * a_interface_pointer )

/*-----------------------------------------------------------
	Convert Font *  to FONT_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "FONT_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_444( Font * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert Font * *  to CELL [FONT_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [FONT_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(Font * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_443 (*(Font * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_444( Font * * a_pointer )

/*-----------------------------------------------------------
	Free memory of Font * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_445( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_446( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_447( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_448( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_449( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_450( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_451( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_452( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_452( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_453( ecom_control_library::tagPOINT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::tagPOINT *  to TAG_POINT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "TAG_POINT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_dochostuiinfo_record454( ecom_control_library::_DOCHOSTUIINFO a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_DOCHOSTUIINFO  to X_DOCHOSTUIINFO_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_DOCHOSTUIINFO_RECORD", sizeof (ecom_control_library::_DOCHOSTUIINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_455( ecom_control_library::_DOCHOSTUIINFO * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_DOCHOSTUIINFO *  to X_DOCHOSTUIINFO_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_DOCHOSTUIINFO_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_interface_457( ecom_control_library::IOleCommandTarget * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::IOleCommandTarget *  to IOLE_COMMAND_TARGET_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IOLE_COMMAND_TARGET_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_458( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_458( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_459( IDispatch * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IDispatch * *  to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IDispatch * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_dispatch (*(IDispatch * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_459( IDispatch * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IDispatch * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_460( SHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_461( SHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_cell_462( SHORT * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert SHORT * *  to CELL [INTEGER_REF].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [INTEGER_REF]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(SHORT * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_short (*(SHORT * *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_462( SHORT * * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		grt_ce_control_interfaces2.ccom_free_memory_pointed_461 (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_463( SHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_464( SHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_tag_olecmd_record465( ecom_control_library::_tagOLECMD a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_tagOLECMD  to X_TAG_OLECMD_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_TAG_OLECMD_RECORD", sizeof (ecom_control_library::_tagOLECMD));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_466( ecom_control_library::_tagOLECMD * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_tagOLECMD *  to X_TAG_OLECMD_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_TAG_OLECMD_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_record_x_tag_olecmdtext_record467( ecom_control_library::_tagOLECMDTEXT a_record )

/*-----------------------------------------------------------
	Convert ecom_control_library::_tagOLECMDTEXT  to X_TAG_OLECMDTEXT_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_TAG_OLECMDTEXT_RECORD", sizeof (ecom_control_library::_tagOLECMDTEXT));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_468( ecom_control_library::_tagOLECMDTEXT * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_control_library::_tagOLECMDTEXT *  to X_TAG_OLECMDTEXT_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_TAG_OLECMDTEXT_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_469( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_control_interfaces2::ccom_ce_pointed_record_470( VARIANT * a_record_pointer )

/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_VARIANT");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_control_interfaces2::ccom_free_memory_pointed_471( SHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of SHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif