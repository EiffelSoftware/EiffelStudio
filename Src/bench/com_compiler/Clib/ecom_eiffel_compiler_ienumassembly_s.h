/*-----------------------------------------------------------
Eiffel Assembly Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IENUMASSEMBLY_S_H__
#define __ECOM_EIFFEL_COMPILER_IENUMASSEMBLY_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEnumAssembly_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumAssembly_FWD_DEFINED__
namespace ecom_eiffel_compiler
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

#ifndef __ecom_eiffel_compiler_IEiffelAssemblyProperties_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelAssemblyProperties_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumAssembly_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumAssembly_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumAssembly;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEnumAssembly_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEnumAssembly_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumAssembly : public IUnknown
{
public:
	IEnumAssembly () {};
	~IEnumAssembly () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG celt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_eiffel_compiler::IEnumAssembly * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * rgelt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP count(  /* [out, retval] */ ULONG * return_value ) = 0;



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