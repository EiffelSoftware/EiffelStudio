/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISTREAM_S_H__
#define __ECOM_CONTROL_LIBRARY_ISTREAM_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IStream_FWD_DEFINED__
#define __ecom_control_library_IStream_FWD_DEFINED__
namespace ecom_control_library
{
class IStream;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_ISequentialStream_s.h"

#include "ecom_control_library__LARGE_INTEGER_s.h"

#include "ecom_control_library__ULARGE_INTEGER_s.h"

#include "ecom_control_library_tagSTATSTG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IStream_FWD_DEFINED__
#define __ecom_control_library_IStream_FWD_DEFINED__
namespace ecom_control_library
{
class IStream;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IStream_INTERFACE_DEFINED__
#define __ecom_control_library_IStream_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IStream : public ecom_control_library::ISequentialStream
{
public:
	IStream () {};
	~IStream () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteSeek(  /* [in] */ ecom_control_library::_LARGE_INTEGER dlib_move, /* [in] */ ULONG dw_origin, /* [out] */ ecom_control_library::_ULARGE_INTEGER * plib_new_position ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetSize(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_new_size ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteCopyTo(  /* [in] */ ecom_control_library::IStream * pstm, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_read, /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_written ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Commit(  /* [in] */ ULONG grf_commit_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Revert( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LockRegion(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_offset, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [in] */ ULONG dw_lock_type ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UnlockRegion(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_offset, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [in] */ ULONG dw_lock_type ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg, /* [in] */ ULONG grf_stat_flag ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IStream * * ppstm ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif