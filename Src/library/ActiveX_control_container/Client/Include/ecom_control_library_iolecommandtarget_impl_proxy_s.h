/*-----------------------------------------------------------
Implemented `IOleCommandTarget' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECOMMANDTARGET_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECOMMANDTARGET_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleCommandTarget_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleCommandTarget_s.h"

#include "ecom_control_library__tagOLECMD_s.h"

#include "ecom_control_library__tagOLECMDTEXT_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleCommandTarget_impl_proxy
{
public:
	IOleCommandTarget_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleCommandTarget_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_query_status(  /* [in] */ GUID * pguid_cmd_group,  /* [in] */ EIF_INTEGER c_cmds,  /* [in, out] */ ecom_control_library::_tagOLECMD * prg_cmds,  /* [in, out] */ ecom_control_library::_tagOLECMDTEXT * p_cmd_text );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_exec(  /* [in] */ GUID * pguid_cmd_group,  /* [in] */ EIF_INTEGER n_cmd_id,  /* [in] */ EIF_INTEGER n_cmdexecopt,  /* [in] */ VARIANT * pva_in,  /* [in, out] */ VARIANT * pva_out );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleCommandTarget * p_IOleCommandTarget;


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