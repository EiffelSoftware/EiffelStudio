/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_IMPL_STUB_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator_impl_stub : public ecom_eiffel_compiler::IEiffelHTMLDocGenerator
{
public:
	IEiffelHTMLDocGenerator_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelHTMLDocGenerator_impl_stub ();

	/*-----------------------------------------------------------
	Is the project loaded?
	-----------------------------------------------------------*/
	STDMETHODIMP is_loaded(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is the project oorrupted?
	-----------------------------------------------------------*/
	STDMETHODIMP is_corrupted(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is the project incompatible with the current version of the compiled?
	-----------------------------------------------------------*/
	STDMETHODIMP is_incompatible(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Add a callback interface.
	-----------------------------------------------------------*/
	STDMETHODIMP add_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * new_callback );


	/*-----------------------------------------------------------
	Remove a callback interface.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * old_callback );


	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	STDMETHODIMP add_excluded_cluster(  /* [in] */ BSTR cluster_full_name );


	/*-----------------------------------------------------------
	Include a cluster to be generated.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_excluded_cluster(  /* [in] */ BSTR cluster_full_name );


	/*-----------------------------------------------------------
	Generate the HTML documents into path.
	-----------------------------------------------------------*/
	STDMETHODIMP generate(  /* [in] */ BSTR path );


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
#include "ecom_grt_globals_ISE_c.h"


#endif