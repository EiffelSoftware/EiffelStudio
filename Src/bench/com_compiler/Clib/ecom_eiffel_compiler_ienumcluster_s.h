/*-----------------------------------------------------------
Eiffel Cluster Enumeration.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IENUMCLUSTER_S_H__
#define __ECOM_EIFFEL_COMPILER_IENUMCLUSTER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumCluster;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEiffelClusterDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClusterDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClusterDescriptor;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumCluster;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEnumCluster_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEnumCluster_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumCluster : public IUnknown
{
public:
	IEnumCluster () {};
	~IEnumCluster () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_eiffel_compiler::IEiffelClusterDescriptor * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_eiffel_compiler::IEnumCluster * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ ecom_eiffel_compiler::IEiffelClusterDescriptor * * rgelt ) = 0;


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