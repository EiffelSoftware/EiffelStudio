/*-----------------------------------------------------------
Callback interface for HTML Documentation Generator. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONEVENTS_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONEVENTS_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents : public IDispatch
{
public:
	IEiffelHtmlDocumentationEvents () {};
	~IEiffelHtmlDocumentationEvents () {};

	/*-----------------------------------------------------------
	Notify that documentation generating is initializing
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NotifyInitalizingDocumentation( void ) = 0;


	/*-----------------------------------------------------------
	Notify that the percentage completed has changed
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NotifyPercentageComplete(  /* [in] */ ULONG ul_percent ) = 0;


	/*-----------------------------------------------------------
	Put a header message to the output
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OutputHeader(  /* [in] */ BSTR bstr_msg ) = 0;


	/*-----------------------------------------------------------
	Put a string to the output
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OutputString(  /* [in] */ BSTR bstr_msg ) = 0;


	/*-----------------------------------------------------------
	Put a class name to the output
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OutputClassDocumentMessage(  /* [in] */ BSTR bstr_msg ) = 0;


	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShouldContinue(  /* [in, out] */ VARIANT_BOOL * pvb_continue ) = 0;



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