/*-----------------------------------------------------------
Eiffel Class Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMEIFFELCLASS_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMEIFFELCLASS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelClassDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClassDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClassDescriptor;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumEiffelClass_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumEiffelClass_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass : public IDispatch
{
public:
	IEnumEiffelClass () {};
	~IEnumEiffelClass () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelClassDescriptor * * pp_ieiffel_class_descriptor, /* [out] */ ULONG * pul_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelClassDescriptor * * pp_ieiffel_class_descriptor ) = 0;


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