/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_CODEGENERATOR__XMLCODEGENERATOR_H__
#define __ECOM_ISE_REFLECTION_CODEGENERATOR__XMLCODEGENERATOR_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_CodeGenerator__XmlCodeGenerator_FWD_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__XmlCodeGenerator_FWD_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _XmlCodeGenerator;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelClass_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelClass_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelClass;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_CodeGenerator__XmlCodeGenerator_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__XmlCodeGenerator_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _XmlCodeGenerator : public IDispatch
{
public:
	_XmlCodeGenerator () {};
	~_XmlCodeGenerator () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ToString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Equals(  /* [in] */ VARIANT obj, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetHashCode(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetType(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DtdTypeFilename(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Comma(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TrueString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DtdAssemblyFilename(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DotString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Dash(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP XmlExtension(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FalseString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IndexFilename(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EmptyString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DtdExtension(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Space(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InheritElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ElementChangeElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ParentNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvariantsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PreconditionElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ArgumentTypeFullNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FieldElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ArgumentsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BodyElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericTypeElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HeaderElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CommentsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DeferredElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvariantTagElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvariantElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ArgumentExternalNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RenameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NamespaceElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LiteralValueElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AbstractElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DerivationTypesCountElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvariantTextElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PostconditionTextElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MethodElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumLiteralElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssembliesElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SpecialsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericDerivationElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FrozenElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyTypeFilenameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ParentElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassEiffelNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EiffelClusterPathElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BasicOperationsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConstraintElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreationRoutineElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AccessElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SelectElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ImplementationElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyTypesElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PostconditionTagElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AliasElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InfixElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericDerivationsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UnaryOperatorsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ArgumentEiffelNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PreconditionTextElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericParameterIndexElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureExternalNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BinaryOperatorsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyVersionElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RedefineElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExpandedElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateNoneElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PreconditionTagElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PostconditionElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PreconditionsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BitOrInfixElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReturnTypeFullNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UndefineElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PrefixElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ArgumentElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EmitterVersionNumberElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReturnTypeElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyPublicKeyElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FooterElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsLiteralElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NewSlotElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConstraintsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyCultureElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExportElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SimpleNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumTypeElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReturnTypeGenericParameterIndexElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FrozenFeatureElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericTypeExternalNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StaticElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyFilenameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericTypeEiffelNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ArgumentTypeElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitializationElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ModifiedElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureEiffelNameElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ModifiedFeatureElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PostconditionsElement(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TypeStorer(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EndAssemblyGeneration( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateType(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * an_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReplaceType(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * an_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MakeXmlCodeGenerator( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartAssemblyGeneration(  /* [in] */ IDispatch * an_eiffel_assembly ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CacheHandler(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_TypeStorer(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_TypeStorer(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_CacheHandler(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_CacheHandler(  /* [in] */ IDispatch * p_ret_val ) = 0;



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