/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONEVENTS_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONEVENTS_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents_impl_stub : public ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents
{
public:
	IEiffelHtmlDocumentationEvents_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelHtmlDocumentationEvents_impl_stub ();

	/*-----------------------------------------------------------
	Notify that documentation generating is initializing
	-----------------------------------------------------------*/
	STDMETHODIMP NotifyInitalizingDocumentation( void );


	/*-----------------------------------------------------------
	Notify that the percentage completed has changed
	-----------------------------------------------------------*/
	STDMETHODIMP NotifyPercentageComplete(  /* [in] */ ULONG ul_percent );


	/*-----------------------------------------------------------
	Put a header message to the output
	-----------------------------------------------------------*/
	STDMETHODIMP OutputHeader(  /* [in] */ BSTR bstr_msg );


	/*-----------------------------------------------------------
	Put a string to the output
	-----------------------------------------------------------*/
	STDMETHODIMP OutputString(  /* [in] */ BSTR bstr_msg );


	/*-----------------------------------------------------------
	Put a class name to the output
	-----------------------------------------------------------*/
	STDMETHODIMP OutputClassDocumentMessage(  /* [in] */ BSTR bstr_msg );


	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	STDMETHODIMP ShouldContinue(  /* [in, out] */ VARIANT_BOOL * pvb_continue );


	/*-----------------------------------------------------------
	Get type info
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


	/*-----------------------------------------------------------
	Get type info count
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


	/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
	-----------------------------------------------------------*/
	STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


	/*-----------------------------------------------------------
	Invoke function.
	-----------------------------------------------------------*/
	STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;


	/*-----------------------------------------------------------
	Type information
	-----------------------------------------------------------*/
	ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif