/*-----------------------------------------------------------
Implemented `IEiffelClassDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLASSDESCRIPTOR_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLASSDESCRIPTOR_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelClassDescriptor_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor_s.h"

#include "ecom_eiffel_compiler_IEnumFeature_s.h"

#include "ecom_eiffel_compiler_IEnumClass_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelClassDescriptor_impl_proxy
{
public:
	IEiffelClassDescriptor_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelClassDescriptor_impl_proxy ();

	/*-----------------------------------------------------------
	Class name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Class description.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description(  );


	/*-----------------------------------------------------------
	Class external name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_external_name(  );


	/*-----------------------------------------------------------
	List of names of class features.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_feature_names(  );


	/*-----------------------------------------------------------
	List of class features.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_features(  );


	/*-----------------------------------------------------------
	Number of class features.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_feature_count(  );


	/*-----------------------------------------------------------
	List of class features including ancestor features.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_flat_features(  );


	/*-----------------------------------------------------------
	Number of flat class features.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_flat_feature_count(  );


	/*-----------------------------------------------------------
	List of class clients.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_clients(  );


	/*-----------------------------------------------------------
	Number of class clients.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_client_count(  );


	/*-----------------------------------------------------------
	List of class suppliers.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_suppliers(  );


	/*-----------------------------------------------------------
	Number of class suppliers.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_supplier_count(  );


	/*-----------------------------------------------------------
	List of direct ancestors of class.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ancestors(  );


	/*-----------------------------------------------------------
	Number of direct ancestors.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ancestor_count(  );


	/*-----------------------------------------------------------
	List of direct descendants of class.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_descendants(  );


	/*-----------------------------------------------------------
	Number of direct descendants.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_descendant_count(  );


	/*-----------------------------------------------------------
	Full path to file.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_class_path(  );


	/*-----------------------------------------------------------
	Is class deferred?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_deferred(  );


	/*-----------------------------------------------------------
	Is class external?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_external(  );


	/*-----------------------------------------------------------
	Is class generic?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_generic(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * p_IEiffelClassDescriptor;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_Eif_compiler.h"


#endif