/*-----------------------------------------------------------
Implemented `ITypeComp' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPECOMP_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPECOMP_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ITypeComp_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_ITypeComp_s.h"

#include "ecom_control_library_ITypeInfo_2_s.h"

#include "ecom_control_library_tagFUNCDESC_s.h"

#include "ecom_control_library_tagVARDESC_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ITypeComp_impl_proxy
{
public:
	ITypeComp_impl_proxy (IUnknown * a_pointer);
	virtual ~ITypeComp_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_bind(  /* [in] */ EIF_OBJECT sz_name,  /* [in] */ EIF_INTEGER l_hash_val,  /* [in] */ EIF_INTEGER w_flags,  /* [out] */ EIF_OBJECT pp_tinfo,  /* [out] */ EIF_OBJECT p_desc_kind,  /* [out] */ EIF_OBJECT pp_func_desc,  /* [out] */ EIF_OBJECT pp_var_desc,  /* [out] */ EIF_OBJECT pp_type_comp,  /* [out] */ EIF_OBJECT p_dummy );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_bind_type(  /* [in] */ EIF_OBJECT sz_name,  /* [in] */ EIF_INTEGER l_hash_val,  /* [out] */ EIF_OBJECT pp_tinfo );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::ITypeComp * p_ITypeComp;


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