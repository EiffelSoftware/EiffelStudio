/*-----------------------------------------------------------
Implemented `IEiffelProject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPROJECT_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPROJECT_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelProject_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelProject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelProject_impl_stub : public ecom_eiffel_compiler::IEiffelProject
{
public:
	IEiffelProject_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelProject_impl_stub ();

	/*-----------------------------------------------------------
	Retrieve project.
	-----------------------------------------------------------*/
	STDMETHODIMP retrieve_project(  /* [in] */ BSTR a_project_file_name );


	/*-----------------------------------------------------------
	Create new project.
	-----------------------------------------------------------*/
	STDMETHODIMP create_project(  /* [in] */ BSTR an_ace_file_name, /* [in] */ BSTR project_directory_path );


	/*-----------------------------------------------------------
	Full path to .epr file.
	-----------------------------------------------------------*/
	STDMETHODIMP project_file_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Full path to Ace file.
	-----------------------------------------------------------*/
	STDMETHODIMP ace_file_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project directory.
	-----------------------------------------------------------*/
	STDMETHODIMP project_directory(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Is project valid?
	-----------------------------------------------------------*/
	STDMETHODIMP valid_project(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Last error message.
	-----------------------------------------------------------*/
	STDMETHODIMP last_error_message(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Compiler.
	-----------------------------------------------------------*/
	STDMETHODIMP compiler(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelCompiler * * return_value );


	/*-----------------------------------------------------------
	Has system been compiled?
	-----------------------------------------------------------*/
	STDMETHODIMP is_compiled(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	System Browser.
	-----------------------------------------------------------*/
	STDMETHODIMP system_browser(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemBrowser * * return_value );


	/*-----------------------------------------------------------
	Project Properties.
	-----------------------------------------------------------*/
	STDMETHODIMP project_properties(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelProjectProperties * * return_value );


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