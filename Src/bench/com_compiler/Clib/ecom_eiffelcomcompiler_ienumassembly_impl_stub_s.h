/*-----------------------------------------------------------
Implemented `IEnumAssembly' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMASSEMBLY_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMASSEMBLY_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEnumAssembly_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEnumAssembly_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEnumAssembly_impl_stub : public ecom_EiffelComCompiler::IEnumAssembly
{
public:
	IEnumAssembly_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEnumAssembly_impl_stub ();

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelAssemblyProperties * * pp_ieiffel_assembly_properties, /* [out] */ ULONG * pul_fetched );


	/*-----------------------------------------------------------
	Skip `ulCount' items.
	-----------------------------------------------------------*/
	STDMETHODIMP Skip(  /* [in] */ ULONG ul_count );


	/*-----------------------------------------------------------
	Reset enumerator.
	-----------------------------------------------------------*/
	STDMETHODIMP Reset( void );


	/*-----------------------------------------------------------
	Clone enumerator.
	-----------------------------------------------------------*/
	STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumAssembly * * pp_ienum_assembly );


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	STDMETHODIMP IthItem(  /* [in] */ ULONG ul_count, /* [out] */ ecom_EiffelComCompiler::IEiffelAssemblyProperties * * pp_ieiffel_assembly_properties );


	/*-----------------------------------------------------------
	Retrieve enumerator item count.
	-----------------------------------------------------------*/
	STDMETHODIMP Count(  /* [out, retval] */ ULONG * pul_count );


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
#include "ecom_grt_globals_ISE.h"


#endif