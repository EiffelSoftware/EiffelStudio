/*-----------------------------------------------------------
Eiffel Class Descriptor.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLASSDESCRIPTOR_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLASSDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelClassDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClassDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClassDescriptor;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumFeature_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumFeature_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumFeature;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumClass_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClass_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClass;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelClassDescriptor_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClassDescriptor_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClassDescriptor : public IUnknown
{
public:
	IEiffelClassDescriptor () {};
	~IEiffelClassDescriptor () {};

	/*-----------------------------------------------------------
	Class name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Class description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Class external name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP external_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Class Tool Tip.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP tool_tip(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Is class in system?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_in_system(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	List of names of class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP feature_names(  /* [out, retval] */ SAFEARRAY *  * names ) = 0;


	/*-----------------------------------------------------------
	List of class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP features(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_features ) = 0;


	/*-----------------------------------------------------------
	Number of class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP feature_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of class features including ancestor features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP flat_features(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_features ) = 0;


	/*-----------------------------------------------------------
	Number of flat class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP flat_feature_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of class clients.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP clients(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_clients ) = 0;


	/*-----------------------------------------------------------
	Number of class clients.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP client_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of class suppliers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP suppliers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_suppliers ) = 0;


	/*-----------------------------------------------------------
	Number of class suppliers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP supplier_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of direct ancestors of class.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ancestors(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_ancestors ) = 0;


	/*-----------------------------------------------------------
	Number of direct ancestors.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ancestor_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of direct descendants of class.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP descendants(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_descendants ) = 0;


	/*-----------------------------------------------------------
	Number of direct descendants.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP descendant_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	Full path to file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP class_path(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Is class deferred?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_deferred(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is class external?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_external(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is class generic?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_generic(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;



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