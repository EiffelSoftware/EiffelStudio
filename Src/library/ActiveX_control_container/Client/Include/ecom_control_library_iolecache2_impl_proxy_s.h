/*-----------------------------------------------------------
Implemented `IOleCache2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECACHE2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECACHE2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleCache2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleCache2_s.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_control_library_IEnumSTATDATA_s.h"

#include "ecom_control_library_IDataObject_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleCache2_impl_proxy
{
public:
	IOleCache2_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleCache2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_cache(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_INTEGER advf,  /* [out] */ EIF_OBJECT pdw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_uncache(  /* [in] */ EIF_INTEGER dw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_cache(  /* [out] */ EIF_OBJECT ppenum_statdata );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_init_cache(  /* [in] */ ecom_control_library::IDataObject * p_data_object );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_data(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_OBJECT pmedium,  /* [in] */ EIF_INTEGER f_release );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_update_cache(  /* [in] */ ecom_control_library::IDataObject * p_data_object,  /* [in] */ EIF_INTEGER grf_updf,  /* [in] */ EIF_INTEGER p_reserved );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_discard_cache(  /* [in] */ EIF_INTEGER dw_discard_options );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleCache2 * p_IOleCache2;


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