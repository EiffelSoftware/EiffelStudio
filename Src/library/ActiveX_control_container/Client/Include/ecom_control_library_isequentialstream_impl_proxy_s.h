/*-----------------------------------------------------------
Implemented `ISequentialStream' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISEQUENTIALSTREAM_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ISEQUENTIALSTREAM_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ISequentialStream_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_ISequentialStream_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ISequentialStream_impl_proxy
{
public:
	ISequentialStream_impl_proxy (IUnknown * a_pointer);
	virtual ~ISequentialStream_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_read(  /* [out] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_read );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_write(  /* [in] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_written );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::ISequentialStream * p_ISequentialStream;


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