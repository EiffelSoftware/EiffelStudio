/*-----------------------------------------------------------
Implemented `IEnumParameter' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMPARAMETER_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMPARAMETER_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEnumParameter_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEnumParameter.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEnumParameter_impl_stub : public ecom_EiffelComCompiler::IEnumParameter
{
public:
	IEnumParameter_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEnumParameter_impl_stub ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelParameterDescriptor * * pp_ieiffel_parameter_descriptor, /* [out] */ ULONG * pul_fetched );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Skip(  /* [in] */ ULONG ul_count );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Reset( void );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumParameter * * pp_ienum_parameter );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelParameterDescriptor * * pp_ieiffel_parameter_descriptor );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	STDMETHODIMP Count(  /* [out, retval] */ ULONG * ul_count );


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