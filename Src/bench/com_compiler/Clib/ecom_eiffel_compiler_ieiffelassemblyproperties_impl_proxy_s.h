/*-----------------------------------------------------------
Implemented `IEiffelAssemblyProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties_impl_proxy
{
public:
	IEiffelAssemblyProperties_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelAssemblyProperties_impl_proxy ();

	/*-----------------------------------------------------------
	Assembly name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_name(  );


	/*-----------------------------------------------------------
	Assembly version.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_version(  );


	/*-----------------------------------------------------------
	Assembly culture.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_culture(  );


	/*-----------------------------------------------------------
	Assembly public key token
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_public_key_token(  );


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_local(  );


	/*-----------------------------------------------------------
	Assembly cluster name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_cluster_name(  );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_prefix(  );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	void ccom_set_assembly_prefix(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Is assembly prefix read only.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_prefix_read_only(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * p_IEiffelAssemblyProperties;


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
#include "ecom_grt_globals_ISE.h"


#endif