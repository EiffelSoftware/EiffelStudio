/*-----------------------------------------------------------
Implemented `IEnumEiffelClass' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IENUMEIFFELCLASS_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IENUMEIFFELCLASS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEnumEiffelClass_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEnumEiffelClass_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEnumEiffelClass_impl_stub : public ecom_eiffel_compiler::IEnumEiffelClass
{
public:
	IEnumEiffelClass_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEnumEiffelClass_impl_stub ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Next(  /* [out] */ ecom_eiffel_compiler::IEiffelClassDescriptor * * rgelt, /* [out] */ ULONG * pcelt_fetched );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Skip(  /* [in] */ ULONG celt );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Reset( void );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Clone(  /* [out] */ ecom_eiffel_compiler::IEnumEiffelClass * * ppenum );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ ecom_eiffel_compiler::IEiffelClassDescriptor * * rgelt );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP count(  /* [out, retval] */ ULONG * return_value );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif