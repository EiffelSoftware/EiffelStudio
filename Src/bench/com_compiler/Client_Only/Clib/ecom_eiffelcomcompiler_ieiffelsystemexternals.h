/*-----------------------------------------------------------
Eiffel System Externals. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMEXTERNALS_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMEXTERNALS_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelSystemExternals_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemExternals_FWD_DEFINED__
namespace ecom_EiffelComCompiler
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

#ifndef __ecom_EiffelComCompiler_IEnumIncludePaths_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumIncludePaths_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumIncludePaths;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumObjectFiles_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumObjectFiles_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumObjectFiles;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelSystemExternals_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemExternals_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemExternals : public IDispatch
{
public:
	IEiffelSystemExternals () {};
	~IEiffelSystemExternals () {};

	/*-----------------------------------------------------------
	Add a include path to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddIncludePath(  /* [in] */ BSTR bstr_path ) = 0;


	/*-----------------------------------------------------------
	Remove a include path from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveIncludePath(  /* [in] */ BSTR bstr_path ) = 0;


	/*-----------------------------------------------------------
	Replace an include path in the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReplaceIncludePath(  /* [in] */ BSTR bstr_path, /* [in] */ BSTR bstr_old_path ) = 0;


	/*-----------------------------------------------------------
	Include paths.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IncludePaths(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumIncludePaths * * pp_ienum_include_paths ) = 0;


	/*-----------------------------------------------------------
	Add a object file to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddObjectFile(  /* [in] */ BSTR bstr_file_name ) = 0;


	/*-----------------------------------------------------------
	Remove a object file from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveObjectFile(  /* [in] */ BSTR bstr_file_name ) = 0;


	/*-----------------------------------------------------------
	Replace an object file in the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReplaceObjectFile(  /* [in] */ BSTR bstr_file_name, /* [in] */ BSTR bstr_old_file_name ) = 0;


	/*-----------------------------------------------------------
	Object files.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ObjectFiles(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumObjectFiles * * pp_ienum_object_files ) = 0;


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Store( void ) = 0;



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