/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationGenerator' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONGENERATOR_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONGENERATOR_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationGenerator_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_s.h"

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationGenerator_impl_proxy
{
public:
	IEiffelHtmlDocumentationGenerator_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelHtmlDocumentationGenerator_impl_proxy ();

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
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	void ccom_add_excluded_cluster(  /* [in] */ EIF_OBJECT bstr_full_cluster_name );


	/*-----------------------------------------------------------
	Include a cluster to be generated.
	-----------------------------------------------------------*/
	void ccom_remove_excluded_cluster(  /* [in] */ EIF_OBJECT bstr_full_cluster_name );


	/*-----------------------------------------------------------
	Generate the HTML documents into path.
	-----------------------------------------------------------*/
	void ccom_start_generation(  /* [in] */ EIF_OBJECT bstr_generation_path );


	/*-----------------------------------------------------------
	Add a callback interface.
	-----------------------------------------------------------*/
	void ccom_advise_status_callback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events );


	/*-----------------------------------------------------------
	Remove a callback interface.
	-----------------------------------------------------------*/
	void ccom_unadvise_status_callback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * p_IEiffelHtmlDocumentationGenerator;


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