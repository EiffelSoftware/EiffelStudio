/*-----------------------------------------------------------
Implemented `IEiffelAssemblyProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelAssemblyProperties_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelAssemblyProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelAssemblyProperties_impl_proxy
{
public:
	IEiffelAssemblyProperties_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelAssemblyProperties_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	Assembly name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Assembly version.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_version(  );


	/*-----------------------------------------------------------
	Assembly culture.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_culture(  );


	/*-----------------------------------------------------------
	Assembly public key token
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_public_key_token(  );


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_local(  );


	/*-----------------------------------------------------------
	Assembly cluster name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_name(  );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_prefix1(  );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	void ccom_set_prefix(  /* [in] */ EIF_OBJECT pbstr_prefix );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * p_IEiffelAssemblyProperties;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif