/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationGenerator' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONGENERATOR_IMPL_PROXY_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONGENERATOR_IMPL_PROXY_H__
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

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator.h"

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents.h"

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




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif