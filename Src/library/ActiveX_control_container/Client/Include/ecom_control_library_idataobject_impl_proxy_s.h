/*-----------------------------------------------------------
Implemented `IDataObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDATAOBJECT_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IDATAOBJECT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDataObject_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IDataObject_s.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_IEnumFORMATETC_s.h"

#include "ecom_control_library_IAdviseSink_s.h"

#include "ecom_control_library_IEnumSTATDATA_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDataObject_impl_proxy
{
public:
	IDataObject_impl_proxy (IUnknown * a_pointer);
	virtual ~IDataObject_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_data(  /* [in] */ ecom_control_library::tagFORMATETC * pformatetc_in,  /* [out] */ EIF_OBJECT p_remote_medium );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_data_here(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in, out] */ EIF_OBJECT p_remote_medium );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_query_get_data(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_canonical_format_etc(  /* [in] */ ecom_control_library::tagFORMATETC * pformatect_in,  /* [out] */ ecom_control_library::tagFORMATETC * pformatetc_out );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_set_data(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_OBJECT pmedium,  /* [in] */ EIF_INTEGER f_release );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_format_etc(  /* [in] */ EIF_INTEGER dw_direction,  /* [out] */ EIF_OBJECT ppenum_format_etc );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_dadvise(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink,  /* [out] */ EIF_OBJECT pdw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_dunadvise(  /* [in] */ EIF_INTEGER dw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_dadvise(  /* [out] */ EIF_OBJECT ppenum_advise );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IDataObject * p_IDataObject;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif