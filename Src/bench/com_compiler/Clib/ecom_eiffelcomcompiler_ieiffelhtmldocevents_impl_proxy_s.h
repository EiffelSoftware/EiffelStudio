/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCEVENTS_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCEVENTS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelHTMLDocEvents_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelHTMLDocEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelHTMLDocEvents_impl_proxy
{
public:
	IEiffelHTMLDocEvents_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelHTMLDocEvents_impl_proxy ();

	/*-----------------------------------------------------------
	Put a header message to the output
	-----------------------------------------------------------*/
	void ccom_put_header(  /* [in] */ EIF_OBJECT new_value );


	/*-----------------------------------------------------------
	Put a string to the output
	-----------------------------------------------------------*/
	void ccom_put_string(  /* [in] */ EIF_OBJECT new_value );


	/*-----------------------------------------------------------
	Put a class name to the output
	-----------------------------------------------------------*/
	void ccom_put_class_document_message(  /* [in] */ EIF_OBJECT new_value );


	/*-----------------------------------------------------------
	Notify that documentation generating is initializing
	-----------------------------------------------------------*/
	void ccom_put_initializing_documentation();


	/*-----------------------------------------------------------
	Notify that the percentage completed has changed
	-----------------------------------------------------------*/
	void ccom_put_percentage_completed(  /* [in] */ EIF_INTEGER new_value );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHTMLDocEvents * p_IEiffelHTMLDocEvents;


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