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
	STDMETHODIMP wipe_out( void );


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_assembly(  /* [in] */ BSTR a_prefix, /* [in] */ BSTR a_cluster_name, /* [in] */ BSTR a_path, /* [in] */ VARIANT_BOOL a_copy );


	/*-----------------------------------------------------------
	Last execption to occur
	-----------------------------------------------------------*/
	STDMETHODIMP last_exception(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * p_exception );


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