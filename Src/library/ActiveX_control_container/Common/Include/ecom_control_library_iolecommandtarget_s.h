/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECOMMANDTARGET_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECOMMANDTARGET_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleCommandTarget_FWD_DEFINED__
#define __ecom_control_library_IOleCommandTarget_FWD_DEFINED__
namespace ecom_control_library
{
class IOleCommandTarget;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__tagOLECMD_s.h"

#include "ecom_control_library__tagOLECMDTEXT_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleCommandTarget_INTERFACE_DEFINED__
#define __ecom_control_library_IOleCommandTarget_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleCommandTarget : public IUnknown
{
public:
	IOleCommandTarget () {};
	~IOleCommandTarget () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP QueryStatus(  /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG c_cmds, /* [in, out] */ ecom_control_library::_tagOLECMD * prg_cmds, /* [in, out] */ ecom_control_library::_tagOLECMDTEXT * p_cmd_text ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Exec(  /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG n_cmd_id, /* [in] */ ULONG n_cmdexecopt, /* [in] */ VARIANT * pva_in, /* [in, out] */ VARIANT * pva_out ) = 0;



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