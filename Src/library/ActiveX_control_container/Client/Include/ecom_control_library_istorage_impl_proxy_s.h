/*-----------------------------------------------------------
Implemented `IStorage' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISTORAGE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ISTORAGE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IStorage_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IStorage_s.h"

#include "ecom_control_library_IStream_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_IEnumSTATSTG_s.h"

#include "ecom_control_library__FILETIME_s.h"

#include "ecom_control_library_tagSTATSTG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IStorage_impl_proxy
{
public:
	IStorage_impl_proxy (IUnknown * a_pointer);
	virtual ~IStorage_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_stream(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ EIF_INTEGER reserved1,  /* [in] */ EIF_INTEGER reserved2,  /* [out] */ EIF_OBJECT ppstm );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_open_stream(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ EIF_INTEGER cb_reserved1,  /* [in] */ EIF_OBJECT reserved1,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ EIF_INTEGER reserved2,  /* [out] */ EIF_OBJECT ppstm );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_storage(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ EIF_INTEGER reserved1,  /* [in] */ EIF_INTEGER reserved2,  /* [out] */ EIF_OBJECT ppstg );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_open_storage(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ ecom_control_library::IStorage * pstg_priority,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ ecom_control_library::wireSNB snb_exclude,  /* [in] */ EIF_INTEGER reserved,  /* [out] */ EIF_OBJECT ppstg );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_copy_to(  /* [in] */ EIF_INTEGER ciid_exclude,  /* [in] */ GUID * rgiid_exclude,  /* [in] */ ecom_control_library::wireSNB snb_exclude,  /* [in] */ ecom_control_library::IStorage * pstg_dest );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_move_element_to(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ ecom_control_library::IStorage * pstg_dest,  /* [in] */ EIF_OBJECT pwcs_new_name,  /* [in] */ EIF_INTEGER grf_flags );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_commit(  /* [in] */ EIF_INTEGER grf_commit_flags );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_revert();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_enum_elements(  /* [in] */ EIF_INTEGER reserved1,  /* [in] */ EIF_INTEGER cb_reserved2,  /* [in] */ EIF_OBJECT reserved2,  /* [in] */ EIF_INTEGER reserved3,  /* [out] */ EIF_OBJECT ppenum );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_destroy_element(  /* [in] */ EIF_OBJECT pwcs_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_rename_element(  /* [in] */ EIF_OBJECT pwcs_old_name,  /* [in] */ EIF_OBJECT pwcs_new_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_element_times(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ ecom_control_library::_FILETIME * pctime,  /* [in] */ ecom_control_library::_FILETIME * patime,  /* [in] */ ecom_control_library::_FILETIME * pmtime );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_class(  /* [in] */ GUID * clsid );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_state_bits(  /* [in] */ EIF_INTEGER grf_state_bits,  /* [in] */ EIF_INTEGER grf_mask );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg,  /* [in] */ EIF_INTEGER grf_stat_flag );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IStorage * p_IStorage;


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