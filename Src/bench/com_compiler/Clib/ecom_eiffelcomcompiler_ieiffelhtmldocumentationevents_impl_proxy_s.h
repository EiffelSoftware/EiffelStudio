/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONEVENTS_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCUMENTATIONEVENTS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationEvents_impl_proxy
{
public:
	IEiffelHtmlDocumentationEvents_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelHtmlDocumentationEvents_impl_proxy ();

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
	Notify that documentation generating is initializing
	-----------------------------------------------------------*/
	void ccom_notify_initalizing_documentation();


	/*-----------------------------------------------------------
	Notify that the percentage completed has changed
	-----------------------------------------------------------*/
	void ccom_notify_percentage_complete(  /* [in] */ EIF_INTEGER ul_percent );


	/*-----------------------------------------------------------
	Put a header message to the output
	-----------------------------------------------------------*/
	void ccom_output_header(  /* [in] */ EIF_OBJECT bstr_msg );


	/*-----------------------------------------------------------
	Put a string to the output
	-----------------------------------------------------------*/
	void ccom_output_string(  /* [in] */ EIF_OBJECT bstr_msg );


	/*-----------------------------------------------------------
	Put a class name to the output
	-----------------------------------------------------------*/
	void ccom_output_class_document_message(  /* [in] */ EIF_OBJECT bstr_msg );


	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	void ccom_should_continue(  /* [in, out] */ EIF_OBJECT pvb_continue );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_IEiffelHtmlDocumentationEvents;


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