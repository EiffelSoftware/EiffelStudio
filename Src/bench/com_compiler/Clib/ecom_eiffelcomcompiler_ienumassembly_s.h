/*-----------------------------------------------------------
Eiffel Assembly Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMASSEMBLY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMASSEMBLY_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumAssembly_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumAssembly_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumAssembly;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelAssemblyProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelAssemblyProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelAssemblyProperties;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumAssembly_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumAssembly_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumAssembly;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumAssembly_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumAssembly_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumAssembly : public IDispatch
{
public:
	IEnumAssembly () {};
	~IEnumAssembly () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelAssemblyProperties * * pp_ieiffel_assembly_properties, /* [out] */ ULONG * pul_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumAssembly * * pp_ienum_assembly ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_count, /* [out] */ ecom_EiffelComCompiler::IEiffelAssemblyProperties * * pp_ieiffel_assembly_properties ) = 0;


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