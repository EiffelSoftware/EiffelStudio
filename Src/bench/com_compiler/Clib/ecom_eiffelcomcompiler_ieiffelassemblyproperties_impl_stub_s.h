/*-----------------------------------------------------------
Implemented `IEiffelAssemblyProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELASSEMBLYPROPERTIES_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelAssemblyProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelAssemblyProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelAssemblyProperties_impl_stub : public ecom_EiffelComCompiler::IEiffelAssemblyProperties
{
public:
	IEiffelAssemblyProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelAssemblyProperties_impl_stub ();

	/*-----------------------------------------------------------
	Assembly name.
	-----------------------------------------------------------*/
	STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name );


	/*-----------------------------------------------------------
	Assembly version.
	-----------------------------------------------------------*/
	STDMETHODIMP Version(  /* [out, retval] */ BSTR * pbstr_version );


	/*-----------------------------------------------------------
	Assembly culture.
	-----------------------------------------------------------*/
	STDMETHODIMP Culture(  /* [out, retval] */ BSTR * pbstr_version );


	/*-----------------------------------------------------------
	Assembly public key token
	-----------------------------------------------------------*/
	STDMETHODIMP PublicKeyToken(  /* [out, retval] */ BSTR * pvb_public_key_token );


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	STDMETHODIMP IsLocal(  /* [out, retval] */ VARIANT_BOOL * pvb_is_local );


	/*-----------------------------------------------------------
	Assembly cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterName(  /* [out, retval] */ BSTR * pbstr_cluster_name );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	STDMETHODIMP Prefix(  /* [out, retval] */ BSTR * pbstr_prefix );


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Prefix(  /* [in] */ BSTR pbstr_prefix );


	/*-----------------------------------------------------------
	Is assembly prefix read only.
	-----------------------------------------------------------*/
	STDMETHODIMP IsPrefixReadOnly(  /* [out, retval] */ VARIANT_BOOL * pvb_read_only );


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