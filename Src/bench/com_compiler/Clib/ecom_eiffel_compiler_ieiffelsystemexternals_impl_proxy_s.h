/*-----------------------------------------------------------
Implemented `IEiffelSystemExternals' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals_s.h"

#include "ecom_eiffel_compiler_IEnumIncludePaths_s.h"

#include "ecom_eiffel_compiler_IEnumObjectFiles_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals_impl_proxy
{
public:
	IEiffelSystemExternals_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelSystemExternals_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	void ccom_store();


	/*-----------------------------------------------------------
	Add a include path to the project.
	-----------------------------------------------------------*/
	void ccom_add_include_path(  /* [in] */ EIF_OBJECT include_path );


	/*-----------------------------------------------------------
	Remove a include path from the project.
	-----------------------------------------------------------*/
	void ccom_remove_include_path(  /* [in] */ EIF_OBJECT include_path );


	/*-----------------------------------------------------------
	Include paths.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_include_paths(  );


	/*-----------------------------------------------------------
	Add a object file to the project.
	-----------------------------------------------------------*/
	void ccom_add_object_file(  /* [in] */ EIF_OBJECT object_file );


	/*-----------------------------------------------------------
	Remove a object file from the project.
	-----------------------------------------------------------*/
	void ccom_remove_object_file(  /* [in] */ EIF_OBJECT object_file );


	/*-----------------------------------------------------------
	Object files.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_object_files(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * p_IEiffelSystemExternals;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_Eif_compiler.h"


#endif