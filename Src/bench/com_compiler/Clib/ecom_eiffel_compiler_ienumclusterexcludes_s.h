/*-----------------------------------------------------------
Eiffel Cluster Exluded Directories Enumeration.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IENUMCLUSTEREXCLUDES_S_H__
#define __ECOM_EIFFEL_COMPILER_IENUMCLUSTEREXCLUDES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEnumClusterExcludes_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClusterExcludes_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClusterExcludes;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumClusterExcludes_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClusterExcludes_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClusterExcludes;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEnumClusterExcludes_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEnumClusterExcludes_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClusterExcludes : public IUnknown
{
public:
	IEnumClusterExcludes () {};
	~IEnumClusterExcludes () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ BSTR * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_eiffel_compiler::IEnumClusterExcludes * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ BSTR * rgelt ) = 0;


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