/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelSystemAssemblies_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies_impl_stub : public ecom_EiffelComCompiler::IEiffelSystemAssemblies
{
public:
	IEiffelSystemAssemblies_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemAssemblies_impl_stub ();

	/*-----------------------------------------------------------
	Wipe out current list of assemblies
	-----------------------------------------------------------*/
	STDMETHODIMP FlushAssemblies( void );


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP AddAssembly(  /* [in] */ BSTR bstr_prefix, /* [in] */ BSTR bstr_cluster_name, /* [in] */ BSTR bstr_file_name, /* [in] */ VARIANT_BOOL vb_copy_locally );


	/*-----------------------------------------------------------
	Last execption to occur
	-----------------------------------------------------------*/
	STDMETHODIMP LastException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * p_exception );


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	STDMETHODIMP Store( void );


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