/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_CODEGENERATOR__EIFFELCODEGENERATOR_H__
#define __ECOM_ISE_REFLECTION_CODEGENERATOR__EIFFELCODEGENERATOR_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator_FWD_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator_FWD_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _EiffelCodeGenerator;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelFeature_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelFeature_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelFeature;
}
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
#ifndef __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _EiffelCodeGenerator : public IDispatch
{
public:
	_EiffelCodeGenerator () {};
	~_EiffelCodeGenerator () {};

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
	virtual STDMETHODIMP EnsureKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Integer8Class(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ElementChangeFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RedefineKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AliasKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SignatureKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BasicOperationsFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DeferredKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IntegerClass(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Integer16Class(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BinaryOperatorsFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EndKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InheritKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClosingSquareBracket(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Use(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExternalNameKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvertedComma(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericTypesKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DoKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PropertySetPrefix(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DoubleClass(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OpeningRoundBracket(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitializationFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Creator(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumTypeKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClosingRoundBracket(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SelectKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConstraintsKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InfixKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RealClass(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP WindowsNewLine(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StaticField(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RenameKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IL(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExpandedKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RequireKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SpecialsFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateNone(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Tab(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ImplementationFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Dashes(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Static(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FrozenKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Colon(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IndexingKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Operator(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitializationFeatureClauseExportedToNone(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratorName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PrefixKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EiffelClassExtension(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NewLine(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CharacterClass(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AnyClass(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OpeningSquareBracket(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Integer64Class(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExternalKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SemiColon(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UndefineKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Field(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UnaryOperatorsFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BooleanClass(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratorIndexingClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AccessFeatureClause(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EiffelAssembly(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureAssertions(  /* [in] */ IDispatch * assertions, /* [in] */ BSTR keyword ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BitOrInfixSignature(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateConstraints( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BuiltInComment(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratedCode(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateEiffelFeature(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * a_feature ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateGenericTypes( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateEiffelClassFromPath(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * an_eiffel_class, /* [in] */ BSTR a_path ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InternGenerateClassFeatures(  /* [in] */ IDispatch * a_list ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsSpecialClass(  /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MakeEiffelCodeGenerator( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateInheritanceClauses(  /* [in] */ IDispatch * clauses ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Parents(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateGenericClauses( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateEiffelClass(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * an_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MakeFromInfo(  /* [in] */ IDispatch * an_eiffel_assembly ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasAnyRename(  /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasAnyRedefine(  /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateExternalClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * a_feature ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateCreateClause( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateInheritClause( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateClassFeatures( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasAnyUndefine(  /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SpecialClasses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_EiffelClass(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureSignature(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * a_feature, /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InternGenerateEiffelClass(  /* [in] */ BSTR a_filename ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BitOrInfixCode(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_EiffelAssembly(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_EiffelAssembly(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_GeneratedCode(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_GeneratedCode(  /* [in] */ BSTR p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_Parents(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_Parents(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_EiffelClass(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_EiffelClass(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * p_ret_val ) = 0;



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