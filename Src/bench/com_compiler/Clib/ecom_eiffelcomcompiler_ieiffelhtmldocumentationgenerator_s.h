/*-----------------------------------------------------------
Eiffel Project HTML Documentation Generator. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONGENERATOR_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONGENERATOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationGenerator;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationGenerator : public IDispatch
{
public:
	IEiffelHtmlDocumentationGenerator () {};
	~IEiffelHtmlDocumentationGenerator () {};

	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddExcludedCluster(  /* [in] */ BSTR bstr_full_cluster_name ) = 0;


	/*-----------------------------------------------------------
	Include a cluster to be generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveExcludedCluster(  /* [in] */ BSTR bstr_full_cluster_name ) = 0;


	/*-----------------------------------------------------------
	Generate the HTML documents into path.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartGeneration(  /* [in] */ BSTR bstr_generation_path ) = 0;


	/*-----------------------------------------------------------
	Add a callback interface.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AdviseStatusCallback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events ) = 0;


	/*-----------------------------------------------------------
	Remove a callback interface.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UnadviseStatusCallback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events ) = 0;



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