/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCEVENTS_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCEVENTS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocEvents_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocEvents_impl_stub : public ecom_eiffel_compiler::IEiffelHTMLDocEvents
{
public:
	IEiffelHTMLDocEvents_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelHTMLDocEvents_impl_stub ();

	/*-----------------------------------------------------------
	Put a header message to the output
	-----------------------------------------------------------*/
	STDMETHODIMP put_header(  /* [in] */ BSTR new_value );


	/*-----------------------------------------------------------
	Put a string to the output
	-----------------------------------------------------------*/
	STDMETHODIMP put_string(  /* [in] */ BSTR new_value );


	/*-----------------------------------------------------------
	Put a class name to the output
	-----------------------------------------------------------*/
	STDMETHODIMP put_class_document_message(  /* [in] */ BSTR new_value );


	/*-----------------------------------------------------------
	Notify that documentation generating is initializing
	-----------------------------------------------------------*/
	STDMETHODIMP put_initializing_documentation( void );


	/*-----------------------------------------------------------
	Notify that the percentage completed has changed
	-----------------------------------------------------------*/
	STDMETHODIMP put_percentage_completed(  /* [in] */ ULONG new_value );


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




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif