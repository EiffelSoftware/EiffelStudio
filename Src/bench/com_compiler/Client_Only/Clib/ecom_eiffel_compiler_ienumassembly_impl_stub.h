/*-----------------------------------------------------------
Implemented `IEnumAssembly' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IENUMASSEMBLY_IMPL_STUB_H__
#define __ECOM_EIFFEL_COMPILER_IENUMASSEMBLY_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEnumAssembly_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_eiffel_compiler_IEnumAssembly.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEnumAssembly_impl_stub : public ecom_eiffel_compiler::IEnumAssembly
{
public:
	IEnumAssembly_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEnumAssembly_impl_stub ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Next(  /* [out] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * rgelt, /* [out] */ ULONG * pcelt_fetched );


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
	STDMETHODIMP Clone(  /* [out] */ ecom_eiffel_compiler::IEnumAssembly * * ppenum );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * rgelt );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP count(  /* [out, retval] */ ULONG * return_value );


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