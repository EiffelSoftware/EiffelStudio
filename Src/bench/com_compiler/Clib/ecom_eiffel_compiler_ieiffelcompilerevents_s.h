/*-----------------------------------------------------------
Eiffel Compiler Events.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILEREVENTS_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILEREVENTS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelCompilerEvents_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompilerEvents_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompilerEvents;
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
#ifndef __ecom_eiffel_compiler_IEiffelCompilerEvents_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompilerEvents_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompilerEvents : public IUnknown
{
public:
	IEiffelCompilerEvents () {};
	~IEiffelCompilerEvents () {};

	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP should_continue(  /* [in, out] */ VARIANT_BOOL * a_boolean ) = 0;


	/*-----------------------------------------------------------
	Output string.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP output_string(  /* [in] */ BSTR a_string ) = 0;


	/*-----------------------------------------------------------
	Last error.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP last_error(  /* [in] */ BSTR error_message, /* [in] */ BSTR file_name, /* [in] */ ULONG line_number ) = 0;



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