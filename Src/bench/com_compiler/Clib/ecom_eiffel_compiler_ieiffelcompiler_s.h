/*-----------------------------------------------------------
Eiffel Compiler.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelCompiler_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompiler_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompiler;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelCompiler_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompiler_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompiler : public IUnknown
{
public:
	IEiffelCompiler () {};
	~IEiffelCompiler () {};

	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP compile( void ) = 0;


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_successful(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Compiler version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP compiler_version(  /* [out, retval] */ BSTR * return_value ) = 0;



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