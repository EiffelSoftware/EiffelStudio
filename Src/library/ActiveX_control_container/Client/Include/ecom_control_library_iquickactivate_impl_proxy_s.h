/*-----------------------------------------------------------
Implemented `IQuickActivate' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IQUICKACTIVATE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IQUICKACTIVATE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IQuickActivate_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IQuickActivate_s.h"

#include "ecom_control_library_tagQACONTAINER_s.h"

#include "ecom_control_library_tagQACONTROL_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IQuickActivate_impl_proxy
{
public:
	IQuickActivate_impl_proxy (IUnknown * a_pointer);
	virtual ~IQuickActivate_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_quick_activate(  /* [in] */ ecom_control_library::tagQACONTAINER * p_qa_container,  /* [out] */ ecom_control_library::tagQACONTROL * p_qa_control );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_content_extent(  /* [in] */ ecom_control_library::tagSIZEL * psizel );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_content_extent(  /* [out] */ ecom_control_library::tagSIZEL * psizel );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IQuickActivate * p_IQuickActivate;


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