/*-----------------------------------------------------------
Callback interface for HTML Documentation Generator. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCEVENTS_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCEVENTS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocEvents_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocEvents_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocEvents;
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
#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocEvents_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocEvents_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocEvents : public IUnknown
{
public:
	IEiffelHTMLDocEvents () {};
	~IEiffelHTMLDocEvents () {};

	/*-----------------------------------------------------------
	Put a header message to the output
	-----------------------------------------------------------*/
	virtual STDMETHODIMP put_header(  /* [in] */ BSTR new_value ) = 0;


	/*-----------------------------------------------------------
	Put a string to the output
	-----------------------------------------------------------*/
	virtual STDMETHODIMP put_string(  /* [in] */ BSTR new_value ) = 0;


	/*-----------------------------------------------------------
	Put a class name to the output
	-----------------------------------------------------------*/
	virtual STDMETHODIMP put_class_document_message(  /* [in] */ BSTR new_value ) = 0;


	/*-----------------------------------------------------------
	Notify that documentation generating is initializing
	-----------------------------------------------------------*/
	virtual STDMETHODIMP put_initializing_documentation( void ) = 0;


	/*-----------------------------------------------------------
	Notify that the percentage completed has changed
	-----------------------------------------------------------*/
	virtual STDMETHODIMP put_percentage_completed(  /* [in] */ ULONG new_value ) = 0;



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