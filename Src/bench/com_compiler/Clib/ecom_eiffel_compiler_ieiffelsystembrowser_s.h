/*-----------------------------------------------------------
System Browser.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelSystemBrowser_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemBrowser_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemBrowser;
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



#ifndef __ecom_eiffel_compiler_IEiffelClassDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClassDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClassDescriptor;
}
#endif



#ifndef __ecom_eiffel_compiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelSystemBrowser_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemBrowser_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemBrowser : public IUnknown
{
public:
	IEiffelSystemBrowser () {};
	~IEiffelSystemBrowser () {};

	/*-----------------------------------------------------------
	List of classes in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP system_classes(  /* [out, retval] */ SAFEARRAY *  * names ) = 0;


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP class_count(  /* [out, retval] */ LONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP system_clusters(  /* [out, retval] */ SAFEARRAY *  * names ) = 0;


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_count(  /* [out, retval] */ LONG * return_value ) = 0;


	/*-----------------------------------------------------------
	Cluster descriptor.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_descriptor(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterDescriptor * * return_value ) = 0;


	/*-----------------------------------------------------------
	Class descriptor.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP class_descriptor(  /* [in] */ BSTR class_name1, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClassDescriptor * * return_value ) = 0;


	/*-----------------------------------------------------------
	Feature descriptor.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP feature_descriptor(  /* [in] */ BSTR class_name1, /* [in] */ BSTR feature_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelFeatureDescriptor * * return_value ) = 0;



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