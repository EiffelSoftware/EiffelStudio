/*-----------------------------------------------------------
Implemented `IEiffelSystemExternals' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemExternals_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelSystemExternals_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemExternals_impl_stub : public ecom_EiffelComCompiler::IEiffelSystemExternals
{
public:
	IEiffelSystemExternals_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemExternals_impl_stub ();

	/*-----------------------------------------------------------
	Add a include path to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP AddIncludePath(  /* [in] */ BSTR bstr_path );


	/*-----------------------------------------------------------
	Remove a include path from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP RemoveIncludePath(  /* [in] */ BSTR bstr_path );


	/*-----------------------------------------------------------
	Replace an include path in the project.
	-----------------------------------------------------------*/
	STDMETHODIMP ReplaceIncludePath(  /* [in] */ BSTR bstr_path, /* [in] */ BSTR bstr_old_path );


	/*-----------------------------------------------------------
	Include paths.
	-----------------------------------------------------------*/
	STDMETHODIMP IncludePaths(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumIncludePaths * * pp_ienum_include_paths );


	/*-----------------------------------------------------------
	Add a object file to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP AddObjectFile(  /* [in] */ BSTR bstr_file_name );


	/*-----------------------------------------------------------
	Remove a object file from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP RemoveObjectFile(  /* [in] */ BSTR bstr_file_name );


	/*-----------------------------------------------------------
	Replace an object file in the project.
	-----------------------------------------------------------*/
	STDMETHODIMP ReplaceObjectFile(  /* [in] */ BSTR bstr_file_name, /* [in] */ BSTR bstr_old_file_name );


	/*-----------------------------------------------------------
	Object files.
	-----------------------------------------------------------*/
	STDMETHODIMP ObjectFiles(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumObjectFiles * * pp_ienum_object_files );


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