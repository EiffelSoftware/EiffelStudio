/*-----------------------------------------------------------
Include Path Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMINCLUDEPATHS_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMINCLUDEPATHS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumIncludePaths_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumIncludePaths_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumIncludePaths;
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



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumIncludePaths_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumIncludePaths_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumIncludePaths : public IDispatch
{
public:
	IEnumIncludePaths () {};
	~IEnumIncludePaths () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ BSTR * pbstr_include_path, /* [out] */ ULONG * pul_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG ul_count ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumIncludePaths * * pp_ienum_include_paths ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ BSTR * pbstr_include_path ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Count(  /* [out, retval] */ ULONG * pul_count ) = 0;



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