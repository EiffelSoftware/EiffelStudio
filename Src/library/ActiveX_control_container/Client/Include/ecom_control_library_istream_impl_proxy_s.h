/*-----------------------------------------------------------
Implemented `IStream' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISTREAM_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ISTREAM_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IStream_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IStream_s.h"

#include "ecom_control_library__LARGE_INTEGER_s.h"

#include "ecom_control_library__ULARGE_INTEGER_s.h"

#include "ecom_control_library_tagSTATSTG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IStream_impl_proxy
{
public:
	IStream_impl_proxy (IUnknown * a_pointer);
	virtual ~IStream_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_read(  /* [out] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_read );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_write(  /* [in] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_written );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_seek(  /* [in] */ ecom_control_library::_LARGE_INTEGER * dlib_move,  /* [in] */ EIF_INTEGER dw_origin,  /* [out] */ ecom_control_library::_ULARGE_INTEGER * plib_new_position );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_size(  /* [in] */ ecom_control_library::_ULARGE_INTEGER * lib_new_size );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_copy_to(  /* [in] */ ecom_control_library::IStream * pstm,  /* [in] */ ecom_control_library::_ULARGE_INTEGER * cb,  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_read,  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_written );


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
	void ccom_lock_region(  /* [in] */ ecom_control_library::_ULARGE_INTEGER * lib_offset,  /* [in] */ ecom_control_library::_ULARGE_INTEGER * cb,  /* [in] */ EIF_INTEGER dw_lock_type );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_unlock_region(  /* [in] */ ecom_control_library::_ULARGE_INTEGER * lib_offset,  /* [in] */ ecom_control_library::_ULARGE_INTEGER * cb,  /* [in] */ EIF_INTEGER dw_lock_type );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg,  /* [in] */ EIF_INTEGER grf_stat_flag );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_clone1(  /* [out] */ EIF_OBJECT ppstm );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IStream * p_IStream;


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