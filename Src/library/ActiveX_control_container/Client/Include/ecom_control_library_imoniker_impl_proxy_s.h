/*-----------------------------------------------------------
Implemented `IMoniker' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IMONIKER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IMONIKER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IMoniker_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library_IStream_s.h"

#include "ecom_control_library__ULARGE_INTEGER_s.h"

#include "ecom_control_library_IBindCtx_s.h"

#include "ecom_control_library_IEnumMoniker_s.h"

#include "ecom_control_library__FILETIME_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IMoniker_impl_proxy
{
public:
	IMoniker_impl_proxy (IUnknown * a_pointer);
	virtual ~IMoniker_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_dirty();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_load(  /* [in] */ ecom_control_library::IStream * pstm );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_save(  /* [in] */ ecom_control_library::IStream * pstm,  /* [in] */ EIF_INTEGER f_clear_dirty );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_size_max(  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_size );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_bind_to_object(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ GUID * riid_result,  /* [out] */ EIF_OBJECT ppv_result );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_bind_to_storage(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_reduce(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ EIF_INTEGER dw_reduce_how_far,  /* [in, out] */ EIF_OBJECT ppmk_to_left,  /* [out] */ EIF_OBJECT ppmk_reduced );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_compose_with(  /* [in] */ ecom_control_library::IMoniker * pmk_right,  /* [in] */ EIF_INTEGER f_only_if_not_generic,  /* [out] */ EIF_OBJECT ppmk_composite );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum(  /* [in] */ EIF_INTEGER f_forward,  /* [out] */ EIF_OBJECT ppenum_moniker );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_equal1(  /* [in] */ ecom_control_library::IMoniker * pmk_other_moniker );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_hash(  /* [out] */ EIF_OBJECT pdw_hash );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_running(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ ecom_control_library::IMoniker * pmk_newly_running );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_time_of_last_change(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [out] */ ecom_control_library::_FILETIME * pfiletime );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_inverse(  /* [out] */ EIF_OBJECT ppmk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_common_prefix_with(  /* [in] */ ecom_control_library::IMoniker * pmk_other,  /* [out] */ EIF_OBJECT ppmk_prefix );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_relative_path_to(  /* [in] */ ecom_control_library::IMoniker * pmk_other,  /* [out] */ EIF_OBJECT ppmk_rel_path );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_display_name(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [out] */ EIF_OBJECT ppsz_display_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_parse_display_name(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ EIF_OBJECT psz_display_name,  /* [out] */ EIF_OBJECT pch_eaten,  /* [out] */ EIF_OBJECT ppmk_out );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_system_moniker(  /* [out] */ EIF_OBJECT pdw_mksys );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IMoniker * p_IMoniker;


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