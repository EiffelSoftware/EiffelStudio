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

#ifndef __ecom_eiffel_compiler_IEnumClass_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClass_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClass;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumCluster;
}
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



#ifndef __ecom_eiffel_compiler_IEnumFeature_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumFeature_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumFeature;
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
	virtual STDMETHODIMP system_classes(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_classes ) = 0;


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP class_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP system_clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumCluster * * some_clusters ) = 0;


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_count(  /* [out, retval] */ ULONG * return_value ) = 0;


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


	/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP search_classes(  /* [in] */ BSTR a_string, /* [in] */ VARIANT_BOOL is_substring, /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_classes ) = 0;


	/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP search_features(  /* [in] */ BSTR a_string, /* [in] */ VARIANT_BOOL is_substring, /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_features ) = 0;



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