/*-----------------------------------------------------------
Implemented `IEiffelAssemblyProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_STUB_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties_impl_stub : public ecom_eiffel_compiler::IEiffelAssemblyProperties
{
public:
	IEiffelAssemblyProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelAssemblyProperties_impl_stub ();

	/*-----------------------------------------------------------
	Assembly name.
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Assembly version.
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_version(  /* [out, retval] */ BSTR * path );


	/*-----------------------------------------------------------
	Assembly culture.
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_culture(  /* [out, retval] */ BSTR * path );


	/*-----------------------------------------------------------
	Assembly public key token
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_public_key_token(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	STDMETHODIMP is_local(  /* [out, retval] */ VARIANT_BOOL * a_bool );


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	STDMETHODIMP is_signed(  /* [out, retval] */ VARIANT_BOOL * a_bool );


	/*-----------------------------------------------------------
	Assembly cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_cluster_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_prefix(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	STDMETHODIMP set_assembly_prefix(  /* [in] */ BSTR return_value );


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