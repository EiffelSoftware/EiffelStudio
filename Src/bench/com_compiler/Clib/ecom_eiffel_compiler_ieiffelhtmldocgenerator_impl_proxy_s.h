/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator_impl_proxy
{
public:
	IEiffelHTMLDocGenerator_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelHTMLDocGenerator_impl_proxy ();

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
	Add excluded cluster
	-----------------------------------------------------------*/
	void ccom_add_excluded_cluster(  /* [in] */ EIF_OBJECT cluster_to_exclude );


	/*-----------------------------------------------------------
	Remove excluded cluster
	-----------------------------------------------------------*/
	void ccom_remove_excluded_cluster(  /* [in] */ EIF_OBJECT excluded_cluster );


	/*-----------------------------------------------------------
	is the project incompatible?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_incompatible(  );


	/*-----------------------------------------------------------
	is the project corrupted?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_corrupted(  );


	/*-----------------------------------------------------------
	the last error
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error(  );


	/*-----------------------------------------------------------
	Load a compiled project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_load_project(  /* [in] */ EIF_OBJECT project_dir );


	/*-----------------------------------------------------------
	Generate the documentation.
	-----------------------------------------------------------*/
	void ccom_generate(  /* [in] */ EIF_OBJECT generation_dir );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * p_IEiffelHTMLDocGenerator;


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