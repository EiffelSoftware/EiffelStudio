/*-----------------------------------------------------------
Eiffel System Externals. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMEXTERNALS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelSystemExternals_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemExternals_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumIncludePaths_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumIncludePaths_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumIncludePaths;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumObjectFiles_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumObjectFiles_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumObjectFiles;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelSystemExternals_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemExternals_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals : public IUnknown
{
public:
	IEiffelSystemExternals () {};
	~IEiffelSystemExternals () {};

	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP store( void ) = 0;


	/*-----------------------------------------------------------
	Add a include path to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_include_path(  /* [in] */ BSTR include_path ) = 0;


	/*-----------------------------------------------------------
	Remove a include path from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_include_path(  /* [in] */ BSTR include_path ) = 0;


	/*-----------------------------------------------------------
	Replace an include path in the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP replace_include_path(  /* [in] */ BSTR new_include_path, /* [in] */ BSTR old_include_path ) = 0;


	/*-----------------------------------------------------------
	Include paths.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP include_paths(  /* [out, retval] */ ecom_eiffel_compiler::IEnumIncludePaths * * return_value ) = 0;


	/*-----------------------------------------------------------
	Add a object file to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_object_file(  /* [in] */ BSTR object_file ) = 0;


	/*-----------------------------------------------------------
	Remove a object file from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_object_file(  /* [in] */ BSTR object_file ) = 0;


	/*-----------------------------------------------------------
	Replace an object file in the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP replace_object_file(  /* [in] */ BSTR new_include_path, /* [in] */ BSTR old_object_file ) = 0;


	/*-----------------------------------------------------------
	Object files.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP object_files(  /* [out, retval] */ ecom_eiffel_compiler::IEnumObjectFiles * * return_value ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif