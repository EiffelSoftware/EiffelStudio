/*-----------------------------------------------------------
Implemented `IEiffelSystemExternals' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals_impl_stub : public ecom_eiffel_compiler::IEiffelSystemExternals
{
public:
	IEiffelSystemExternals_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemExternals_impl_stub ();

	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	STDMETHODIMP store( void );


	/*-----------------------------------------------------------
	Add a include path to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_include_path(  /* [in] */ BSTR include_path );


	/*-----------------------------------------------------------
	Remove a include path from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_include_path(  /* [in] */ BSTR include_path );


	/*-----------------------------------------------------------
	Include paths.
	-----------------------------------------------------------*/
	STDMETHODIMP include_paths(  /* [out, retval] */ ecom_eiffel_compiler::IEnumIncludePaths * * return_value );


	/*-----------------------------------------------------------
	Add a object file to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_object_file(  /* [in] */ BSTR object_file );


	/*-----------------------------------------------------------
	Remove a object file from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_object_file(  /* [in] */ BSTR object_file );


	/*-----------------------------------------------------------
	Object files.
	-----------------------------------------------------------*/
	STDMETHODIMP object_files(  /* [out, retval] */ ecom_eiffel_compiler::IEnumObjectFiles * * return_value );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif