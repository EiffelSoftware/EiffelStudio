/*-----------------------------------------------------------
Eiffel Project HTML Documentation Generator.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator;
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
#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator : public IUnknown
{
public:
	IEiffelHTMLDocGenerator () {};
	~IEiffelHTMLDocGenerator () {};

	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_excluded_cluster(  /* [in] */ BSTR cluster_full_name ) = 0;


	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_excluded_cluster(  /* [in] */ BSTR cluster_full_name ) = 0;


	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP generate(  /* [in] */ BSTR path ) = 0;



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