/*-----------------------------------------------------------
Implemented `IEiffelSystemExternals' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_PROXY_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_IMPL_PROXY_H__
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

#include "ecom_eiffel_compiler_IEiffelSystemExternals.h"

#include "ecom_eiffel_compiler_IEnumIncludePaths.h"

#include "ecom_eiffel_compiler_IEnumObjectFiles.h"

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
	Replace an include path in the project.
	-----------------------------------------------------------*/
	void ccom_replace_include_path(  /* [in] */ EIF_OBJECT new_include_path,  /* [in] */ EIF_OBJECT old_include_path );


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
	Replace an object file in the project.
	-----------------------------------------------------------*/
	void ccom_replace_object_file(  /* [in] */ EIF_OBJECT new_include_path,  /* [in] */ EIF_OBJECT old_object_file );


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




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif