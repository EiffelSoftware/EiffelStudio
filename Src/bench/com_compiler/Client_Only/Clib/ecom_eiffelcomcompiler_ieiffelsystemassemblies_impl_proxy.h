/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_PROXY_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelSystemAssemblies.h"

#include "ecom_EiffelComCompiler_IEiffelException.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies_impl_proxy
{
public:
	IEiffelSystemAssemblies_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelSystemAssemblies_impl_proxy ();

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
	Wipe out current list of assemblies
	-----------------------------------------------------------*/
	void ccom_flush_assemblies();


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	void ccom_add_assembly(  /* [in] */ EIF_OBJECT bstr_prefix,  /* [in] */ EIF_OBJECT bstr_cluster_name,  /* [in] */ EIF_OBJECT bstr_file_name,  /* [in] */ EIF_BOOLEAN vb_copy_locally );


	/*-----------------------------------------------------------
	Last execption to occur
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_exception(  );


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	void ccom_store();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemAssemblies * p_IEiffelSystemAssemblies;


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
#include "ecom_grt_globals_ISE_c.h"


#endif