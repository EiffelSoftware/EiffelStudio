/*-----------------------------------------------------------
Object File Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMOBJECTFILES_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMOBJECTFILES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumObjectFiles_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumObjectFiles_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumObjectFiles;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
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
#ifndef __ecom_EiffelComCompiler_IEnumObjectFiles_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumObjectFiles_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumObjectFiles : public IDispatch
{
public:
	IEnumObjectFiles () {};
	~IEnumObjectFiles () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ BSTR * pbstr_object_file, /* [out] */ ULONG * pul_fetched ) = 0;


	/*-----------------------------------------------------------
	Skip `ulCount' items.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG ul_count ) = 0;


	/*-----------------------------------------------------------
	Reset enumerator.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	Clone enumerator.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumObjectFiles * * pp_ienum_object_files ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ BSTR * pbstr_object_file ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerator item count.
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