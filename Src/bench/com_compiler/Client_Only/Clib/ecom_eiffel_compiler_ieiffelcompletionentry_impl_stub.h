/*-----------------------------------------------------------
Implemented `IEiffelCompletionEntry' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONENTRY_IMPL_STUB_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONENTRY_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompletionEntry_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelCompletionEntry.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompletionEntry_impl_stub : public ecom_eiffel_compiler::IEiffelCompletionEntry
{
public:
	IEiffelCompletionEntry_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelCompletionEntry_impl_stub ();

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	STDMETHODIMP signature(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Is entry a feature?
	-----------------------------------------------------------*/
	STDMETHODIMP is_feature(  /* [out] */ VARIANT_BOOL * return_value );


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