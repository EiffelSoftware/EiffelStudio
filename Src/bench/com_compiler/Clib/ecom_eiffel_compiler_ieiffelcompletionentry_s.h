/*-----------------------------------------------------------
Eiffel Completion entry.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONENTRY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONENTRY_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelCompletionEntry_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompletionEntry_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompletionEntry;
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
#ifndef __ecom_eiffel_compiler_IEiffelCompletionEntry_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompletionEntry_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompletionEntry : public IUnknown
{
public:
	IEiffelCompletionEntry () {};
	~IEiffelCompletionEntry () {};

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP signature(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Is entry a feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_feature(  /* [out] */ VARIANT_BOOL * return_value ) = 0;



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