/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMPILER_ICORE_H__
#define __ECOM_EIFFELCOMPILER_ICORE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelCompiler_ICore_FWD_DEFINED__
#define __ecom_EiffelCompiler_ICore_FWD_DEFINED__
namespace ecom_EiffelCompiler
{
class ICore;
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
#ifndef __ecom_EiffelCompiler_ICore_INTERFACE_DEFINED__
#define __ecom_EiffelCompiler_ICore_INTERFACE_DEFINED__
namespace ecom_EiffelCompiler
{
class ICore : public IUnknown
{
public:
	ICore () {};
	~ICore () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetConsoleApplication( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetWindowApplication( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetDll( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartAssemblyGeneration(  /* [in] */ BSTR name, /* [in] */ BSTR fname, /* [in] */ BSTR location ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddAssemblyReference(  /* [in] */ BSTR name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartModuleGeneration(  /* [in] */ BSTR name, /* [in] */ VARIANT_BOOL debug1 ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EndAssemblyGeneration( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartClassMappings(  /* [in] */ LONG class_count ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateClassMappings(  /* [in] */ BSTR class_name1, /* [in] */ LONG type_id, /* [in] */ LONG interface_id, /* [in] */ BSTR source_file_name, /* [in] */ BSTR element_type_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateClassHeader(  /* [in] */ VARIANT_BOOL is_interface, /* [in] */ VARIANT_BOOL is_deferred, /* [in] */ VARIANT_BOOL is_frozen, /* [in] */ VARIANT_BOOL is_expanded, /* [in] */ VARIANT_BOOL is_external, /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EndClass( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddToParentsList(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddInterface(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddEiffelInterface(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EndParentsList( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartFeaturesList(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MarkInvariant(  /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MarkCreationRoutines(  /* [in] */ SAFEARRAY *  feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartFeatureDescription(  /* [in] */ LONG arg_count ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateInterfaceFeatureIdentification(  /* [in] */ BSTR name, /* [in] */ LONG feature_id, /* [in] */ VARIANT_BOOL is_attribute ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureIdentification(  /* [in] */ BSTR name, /* [in] */ LONG feature_id, /* [in] */ VARIANT_BOOL is_redefined, /* [in] */ VARIANT_BOOL is_deferred, /* [in] */ VARIANT_BOOL is_frozen, /* [in] */ VARIANT_BOOL is_attribute, /* [in] */ VARIANT_BOOL is_c_external, /* [in] */ VARIANT_BOOL is_static ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateExternalIdentification(  /* [in] */ BSTR name, /* [in] */ BSTR com_name, /* [in] */ LONG external_kind, /* [in] */ LONG feature_id, /* [in] */ LONG routine_id, /* [in] */ VARIANT_BOOL in_current_class, /* [in] */ LONG written_type_id, /* [in] */ SAFEARRAY *  parameters, /* [in] */ BSTR return_type ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureReturnType(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureArgument(  /* [in] */ BSTR name, /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateFeatureDescription( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DefineEntryPoint(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LastError(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCA(  /* [in] */ LONG target_type_id, /* [in] */ LONG attribute_type_id, /* [in] */ LONG arg_count ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateClassCA( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureCA(  /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCATypedArg(  /* [in] */ LONG a_value, /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAIntegerArg(  /* [in] */ LONG a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAStringArg(  /* [in] */ BSTR a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCARealArg(  /* [in] */ FLOAT a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCADoubleArg(  /* [in] */ double a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCACharacterArg(  /* [in] */ USHORT a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCABooleanArg(  /* [in] */ VARIANT_BOOL a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAArrayIntegerArg(  /* [in] */ SAFEARRAY *  a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAArrayStringArg(  /* [in] */ SAFEARRAY *  a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAArrayRealArg(  /* [in] */ SAFEARRAY *  a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAArrayDoubleArg(  /* [in] */ SAFEARRAY *  a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAArrayCharacterArg(  /* [in] */ SAFEARRAY *  a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCAArrayBooleanArg(  /* [in] */ SAFEARRAY *  a_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP StartIlGeneration(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureIL(  /* [in] */ LONG feature_id, /* [in] */ LONG type_id, /* [in] */ LONG code_feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureInternalClone(  /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateImplementationFeatureIL(  /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMethodImpl(  /* [in] */ LONG feature_id, /* [in] */ LONG parent_type_id, /* [in] */ LONG parent_feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateCreationFeatureIL(  /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateExternalCall(  /* [in] */ BSTR external_type_name, /* [in] */ BSTR name, /* [in] */ LONG external_kind, /* [in] */ SAFEARRAY *  parameter_types, /* [in] */ BSTR return_type, /* [in] */ VARIANT_BOOL is_virtual, /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutResultInfo(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutLocalInfo(  /* [in] */ LONG type_id, /* [in] */ BSTR name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateLikeCurrentObject( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateObject(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateAttributeObject(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetEiffelType(  /* [in] */ LONG exported_type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DuplicateTop( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Pop( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMetamorphose(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateUnmetamorphose(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateCheckCast(  /* [in] */ LONG source_type_id, /* [in] */ LONG target_type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToNativeInt( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToBoolean( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToCharacter( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToInteger8( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToInteger16( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToInteger32( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToInteger64( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToDouble( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ConvertToReal( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateCurrent( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateResult( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateAttribute(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateFeatureAccess(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id, /* [in] */ VARIANT_BOOL is_virtual ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratePrecursorFeatureAccess(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutMethodToken(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArgument(  /* [in] */ LONG n ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateLocal(  /* [in] */ LONG n ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateInAssertionTest(  /* [in] */ LONG end_of_assert_label ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateSetAssertionStatus( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateRestoreAssertionStatus( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateAssertionCheck(  /* [in] */ LONG assert_type, /* [in] */ BSTR tag ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratePreconditionCheck(  /* [in] */ BSTR tag, /* [in] */ LONG label_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratePreconditionViolation( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateInvariantChecking(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateStartExceptionBlock( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateStartRescue( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateEndExceptionBlock( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateIsInstanceOf(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateAttributeAssignment(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateLocalAssignment(  /* [in] */ LONG n ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateResultAssignment( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateLocalAddress(  /* [in] */ LONG n ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateRoutineAddress(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateResultAddress( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateCurrentAddress( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateAttributeAddress(  /* [in] */ LONG type_id, /* [in] */ LONG feature_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArgumentAddress(  /* [in] */ LONG n ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateLoadFromAddress(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArrayAccess(  /* [in] */ LONG kind ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArrayWrite(  /* [in] */ LONG kind ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArrayCreation(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateReturn( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateReturnValue( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateOnceDoneInfo(  /* [in] */ BSTR name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateOnceResultInfo(  /* [in] */ BSTR name, /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateOnceTest( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateOnceResult( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateOnceStoreResult( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArrayLower( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArrayUpper( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateArrayCount( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutVoid( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutManifestString(  /* [in] */ BSTR s ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutInteger8Constant(  /* [in] */ LONG i ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutInteger16Constant(  /* [in] */ LONG i ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutInteger32Constant(  /* [in] */ LONG i ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutInteger64Constant(  /* [in] */ LONGLONG i ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutDoubleConstant(  /* [in] */ double d ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutRealConstant(  /* [in] */ FLOAT d ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutCharacterConstant(  /* [in] */ USHORT c ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutBooleanConstant(  /* [in] */ VARIANT_BOOL b ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BranchOnTrue(  /* [in] */ LONG label ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BranchOnFalse(  /* [in] */ LONG label ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BranchTo(  /* [in] */ LONG label ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MarkLabel(  /* [in] */ LONG label ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateLt( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateLe( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateGt( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateGe( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateStar( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratePower( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMax(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMin(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateAbs(  /* [in] */ LONG type_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateToString( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GeneratePlus( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMod( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMinus( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateDiv( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateXor( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateOr( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateAnd( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateImplies( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateEq( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateShl( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateShr( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateNe( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateUMinus( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateNot( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateBitwiseNot( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PutLineInfo(  /* [in] */ LONG n ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateLabel(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetForInterfaces( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetForImplementations( void ) = 0;



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