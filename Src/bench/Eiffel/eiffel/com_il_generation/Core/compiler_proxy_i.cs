/*
indexing
	description: "Interface used initially to make COM interop easier for EiffelCOM. It
		is also used now to make sure that `core.cs' and `EiffelReflectionEmit' defines
		the same set of features, since `core.cs' is a wrapper around `EiffelReflectionEmit'.

	date: "$Date$"
	revision: "$Revision$
*/

using System;
using System.Runtime.InteropServices;

namespace ISE.Compiler {

[InterfaceTypeAttribute (ComInterfaceType.InterfaceIsIUnknown)]
public interface COMPILER_PROXY_I
{
/*
feature -- Settings
*/
	void set_console_application();
		// Set console application generation

	void set_window_application();
		// Set window application generation

	void set_dll();
		// Set dll generation

	void set_version (int build, int major, int minor, int revision);
		// Set assembly version.

	void set_verifiability (bool v);
		// Set verifiability of code generation. If `v' is True, generate
		// verifiable code, otherwise code is not verifiable.

	void set_cls_compliant (bool v);
		// Set cls compliance of code generation. If `v' is True, generate
		// cls compliant code, otherwise code is not cls compliant.

	void set_any_type_id (int v);
		// Set `Any_id' with `v'.
/*
feature -- Generation structure
*/
	// Create Assembly with name `Name'.
	void StartAssemblyGeneration( string Name, string FName, string Location );

	// Load external assembly
	void AddAssemblyReference( string Name );

	// Create Module with name `Name' within current assembly.
	void StartModuleGeneration( string Name, bool Debug );
		
	// Finish creation of current assembly.
	// `CreateAssembly' should have been called before.
	void EndAssemblyGeneration();

/* Class info */

	// Set number of classes to generate
	void StartClassMappings( int ClassCount );
	
	// Generate a class map between name and TypeID
	void generate_class_mappings (string dotnet_name, string eiffel_name, int TypeID,
		int InterfaceID, string SourceFileName, string ElementTypeName);

	void generate_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.TYPE and `type_id'.

	void generate_class_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.CLASS_TYPE and `type_id'.

	void generate_generic_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.GENERIC_TYPE and `type_id'.

	void generate_formal_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.FORMAL_TYPE and `type_id'.

	void generate_none_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.NONE_TYPE and `type_id'.

	void generate_basic_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.BASIC_TYPE and `type_id'.

	void generate_eiffel_type_info_type_class_mapping (int type_id);
		// Generate mapping between `ISE.Runtime.EIFFEL_TYPE_INFO and `type_id'.

	// Generate class name and its specifier.
	void GenerateClassHeader (bool IsInterface,
		bool IsDeferred, bool IsFrozen, bool IsExpanded,
		bool IsExternal, int TypeID);
	
	// Bake .NET type
	void EndClass();

	// Add class with id `TypeID' into list of parents of current type.
	// `StartParentsLt' should have been called before.
	void AddToParentsList( int TypeID );

	// Add interface with id `TypeID' into list of parents of current tyep.
	void AddInterface (int TypeID);

	void set_implementation_class ();
		// Make class of `CurrentTypeID' an implementation one.

	// Finish inheritance part description
	// `StartParentsList' should have been called before.
	void EndParentsList();
	
/* Features info */

	// Start enumeration of features written in class with TypeID `TypeID'.
	void StartFeaturesList( int TypeID );

	// Mark the invariant routine
	void MarkInvariant( int FeatureID );

	// Mark creation routines
	void MarkCreationRoutines( int[] FeatureID );
	
	// Start enumeration of features written in current class.
	void StartFeatureDescription(int arg_count);

	// Generate info about current feature knowing that it is going 
	// to be generated in interface only.
	void GenerateInterfaceFeatureIdentification (string Name, int FeatureID, bool IsAttribute);

	// Generate info about current feature.
	void GenerateFeatureIdentification
		(string Name, int FeatureID, bool IsRedefined, bool IsDeferred, bool IsFrozen,
		bool IsAttribute, bool Is_C_External, bool IsStatic);

	// Generate info about external feature.
	void GenerateExternalIdentification( string Name, string ComName, int ExternalKind, int FeatureID, int RoutineID, bool InCurrentClass, int WrittenTypeID, string[] Parameters, string ReturnType );

	// Generate info about current feature.
	void GenerateFeatureReturnType( int TypeID );
	
	// Generate info about current feature.
	void GenerateFeatureArgument( string Name, int TypeID );

	// Freeze current Method.
	void CreateFeatureDescription();

	// Define system entry point( root feature of root class );
	void DefineEntryPoint (int CreationTypeID, int TypeID, int FeatureID);

/* Error Handling */

	string LastError();

/* Custom Attributes Generation */

	// Start new custom attribute generation
	// TargetTypeID: type id of class where custom attribute is added
	// AttributeTypeID: Type id of custom attribute
	// ArgCount: Custom attribute constructor arguments count
	void AddCA( int TargetTypeID, int AttributeTypeID, int ArgCount );

	// Generate class wide custom attribute
	// `AddCA' must be called before
	// Any necessary call to `AddCAxxxArg' must be done before
	void GenerateClassCA();

	// Generate method or field custom attribute
	// `AddCA' must be called before
	// Any necessary call to `AddCAxxxArg' must be done before
	void GenerateFeatureCA( int FeatureID );

	// Add custom attribute constructor custom type argument (useful for enums)
	void AddCATypedArg( int Value, int TypeID );

	// Add custom attribute constructor integer argument
	void AddCAIntegerArg( int Value );

/* FIXME: No support for non-native integers yet.

	// Add custom attribute constructor byte argument
	void AddCAInteger8Arg( byte Value );
	
	// Add custom attribute constructor integer 16 argument
	void AddCAInteger16Arg( Int16 Value );
	
	// Add custom attribute constructor integer 64 argument
	void AddCAInteger64Arg( Int64 Value );
*/

	// Add custom attribute constructor string argument
	void AddCAStringArg( string Value );
	
	// Add custom attribute constructor real argument
	void AddCARealArg( double Value );
	
	// Add custom attribute constructor double argument
	void AddCADoubleArg( double Value );
	
	// Add custom attribute constructor character argument
	void AddCACharacterArg( char Value );
	
	// Add custom attribute constructor boolean argument
	void AddCABooleanArg( bool Value );

	// Add custom attribute constructor integer argument
	void AddCAArrayIntegerArg( int[] Value );
	
/* FIXME: No support for non-native integers yet.

	// Add custom attribute constructor byte argument
	void AddCAArrayInteger8Arg( byte[] Value );
	
	// Add custom attribute constructor integer 16 argument
	void AddCAArrayInteger16Arg( Int16[] Value );
	
	// Add custom attribute constructor integer 64 argument
	void AddCAArrayInteger64Arg( Int64[] Value );
*/
	// Add custom attribute constructor string argument
	void AddCAArrayStringArg( string[] Value );
	
	// Add custom attribute constructor real argument
	void AddCAArrayRealArg( double[] Value );
	
	// Add custom attribute constructor double argument
	void AddCAArrayDoubleArg( double[] Value );
	
	// Add custom attribute constructor character argument
	void AddCAArrayCharacterArg( char[] Value );
	
	// Add custom attribute constructor boolean argument
	void AddCAArrayBooleanArg( bool[] Value );
	
/* IL Generation */

	// Start IL Generation for current class
	void StartIlGeneration( int TypeID );
	
	// Generate info about current feature.
	void generate_type_feature (int feature_id);
	void GenerateFeatureIL (int FeatureID, int TypeID, int CodeFeatureID);
	void generate_feature_internal_duplicate (int FeatureID);
	void GenerateImplementationFeatureIL (int FeatureID);

	// Generate a MethodImpl from `ParentTypeID::ParentFeatureID' into 
	// `CurrentTypeID::FeatureID'.
	void GenerateMethodImpl (int FeatureID, int ParentTypeID, int ParentFeatureID);

	// Generate info about current feature.
	void GenerateCreationFeatureIL( int FeatureID );

	void GenerateExternalCall(
			string ExternalTypeName,
			string Name,
			int ExternalKind,
			string[] ParameterTypes,
			string ReturnType,
			bool IsVirtual);

/* Local Variable Info Generator */

	void PutResultInfo( int TypeID );
	
	void PutLocalInfo( int TypeID, string Name );

/* Object Creation */

	void CreateLikeCurrentObject();
	
	void CreateObject( int TypeID );

	void CreateAttributeObject( int TypeID, int FeatureID );

/* IL stack managment */

	void DuplicateTop();

	// Remove top element of IL stack.
	void Pop();

/* Variables access */

	// Generate box operation
	void GenerateMetamorphose( int TypeID );
	
	// Generate unbox operation followed by load indirect
	void GenerateUnmetamorphose( int TypeID );

	// Generate Cast
	void GenerateCheckCast (int SourceTypeID, int TargetTypeID);

	// Convert Object on top of stack into appropriate type.
	void ConvertToNativeInt ();
	void ConvertToBoolean ();
	void ConvertToCharacter ();
	void ConvertToInteger8 ();
	void ConvertToInteger16 ();
	void ConvertToInteger32 ();
	void ConvertToInteger64 ();
	void ConvertToDouble ();
	void ConvertToReal ();


	// Generate access to `Current'.
	void GenerateCurrent();

	// Generate result
	void GenerateResult();

	// Generate attribute
	void GenerateAttribute( int TypeID, int FeatureID );

	// Generate feature access
	void GenerateFeatureAccess( int TypeID, int FeatureID, bool IsVirtual );
	void GeneratePrecursorFeatureAccess( int TypeID, int FeatureID);
	void PutMethodToken (int TypeID, int FeatureID);

	void put_type_token (int type_id);
		// Put type token associated to type `type_id'.

	// Generate access to `n'-th argument of current feature.
	// Cannot be `0', reserved for `Current'.
	void GenerateArgument( int n );
	
	// Generate access to `n'-th local variable of current feature.
	void GenerateLocal( int n );

/* Assertions */

	// Check if assertions are already being checked,
	// in that case we need to skip the assertion block.
	void GenerateInAssertionTest( int EndOfAssertLabel );

	// Set `in_assertion' flag to True.
	void GenerateSetAssertionStatus();

	// Set `in_assertion' flag to False.
	void GenerateRestoreAssertionStatus();

	// Raise an assertion violation with `Tag' name when evaluation of
	// assertion yield a False value.
	void GenerateAssertionCheck( int AssertType, string Tag );

	// If evaluation of precondition yield a False value we put on top
	// of IL stack a string that will be used to raise an exception later
	// at the end of preconditions evaluations.
	void GeneratePreconditionCheck( string Tag, int LabelID );

	void GeneratePreconditionViolation();

	// Generate call to invariant routine
	void GenerateInvariantChecking( int TypeID );

/* Exception */

	// Start exception block
	void GenerateStartExceptionBlock();

	// Start rescue clause and store last exception
	void GenerateStartRescue ();

	// End of rescue clause
	void GenerateEndExceptionBlock();

/* Assignments */

	// Generate a check for IsInstance of
	void GenerateIsInstanceOf( int TypeID );

	// Generate assignment to attribute of `Name' in current class.
	void GenerateAttributeAssignment (int TypeID, int FeatureID);
	
	// Generate assignment to `n'-th local variable of current feature.
	void GenerateLocalAssignment( int n );
	
	// Generate assignment to result of current feature.
	void GenerateResultAssignment();

/* Addresses */

	// Generate `ldloca n' instruction
	void GenerateLocalAddress( int n );

	// Generate `ldftn f' or `ldvirtftn f' instruction
	void GenerateRoutineAddress( int TypeID, int FeatureID );

	// Generate `ldloca Result' instruction
 	void GenerateResultAddress();

	// Generate `ldarga 0' instruction
	void GenerateCurrentAddress();

	// Generate `ldflda attr' instruction
	void GenerateAttributeAddress( int TypeID, int FeatureID );

	// Generate `ldarga n' instruction
	void GenerateArgumentAddress( int n );

	// Generate `ldint.xx' instruction
	void GenerateLoadFromAddress (int type_id);

/* Array Manipulation */

	// Generate call to `item' of ARRAY.
	void GenerateArrayAccess( int Kind );

	// Generate call to `put' of ARRAY.
	void GenerateArrayWrite( int Kind );

	// Create a new array.
	void GenerateArrayCreation( int TypeID );
	
/* Generate return statements */

	void GenerateReturn();
	
/* Onces */


	void GenerateOnceDoneInfo( string name );

	void GenerateOnceResultInfo( string name, int TypeID );

	void generate_once_computed ();
	void generate_once_result_address ();

	void GenerateOnceTest();

	void GenerateOnceResult();

	void GenerateOnceStoreResult();

/* Arrays */

	void GenerateArrayLower();
	
	void GenerateArrayUpper();
	
	void GenerateArrayCount();
	
/* Constants generation */

	// Put `void' on IL stack.
	void PutVoid();
	
	// Put `s' on IL stack.
	void PutManifestString( string s );
	
	// Put `i' on IL stack.
	void PutInteger8Constant( Int32 i  );
	void PutInteger16Constant( Int32 i  );
	void PutInteger32Constant( Int32 i  );
	void PutInteger64Constant( Int64 i  );

	// Put `d' on IL stack.
	void PutDoubleConstant( double d );
	void PutRealConstant( double d );

	// Put `c' on IL stack.
	void PutCharacterConstant( char c );

	// Put `b' on IL stack.
	void PutBooleanConstant( bool b );

/* Labels and branching */

	// Generate a branch instruction to `label' if top of
	// IL stack  True.
	void BranchOnTrue( int label );

	// Generate a branch instruction to `label' if top of
	// IL stack  False.
	void BranchOnFalse( int label );

	// Generate a branch instruction to `label'.
	void BranchTo( int label );

	// Mark a portion of code with `label'.
	void MarkLabel( int label );

/* Binary Operator generation */

	// Generate `<' operator.
	void GenerateLt();

	// Generate `<=' operator.
	void GenerateLe();
	
	// Generate `>' operator.
	void GenerateGt();

	// Generate `>=' operator.
	void GenerateGe();
	
	// Generate `*' operator.
	void GenerateStar();

	// Generate `^' and other basic math operations.
	void GeneratePower();
	void GenerateMax (int TypeID);
	void GenerateMin (int TypeID);
	void GenerateAbs (int TypeID);
	void GenerateToString ();

	// Generate `+' operator.
	void GeneratePlus();

	// Generate `\\' operator.
	void GenerateMod();

	// Generate `-' operator.
	void GenerateMinus();

	// Generate `/' operator.
	void GenerateDiv();

	// Generate `xor' operator.
	void GenerateXor();

	// Generate `or' operator.
	void GenerateOr();

	// Generate `and' operator.
	void GenerateAnd();

	// Generate `implies operator.
	void GenerateImplies();

	// Generate `=' operator.
	void GenerateEq();

	// Generate `<<' and `>>' operator.
	void GenerateShl();
	void GenerateShr();

	// Generate `/=' operator.
	void GenerateNe();

/* Unary operator generation */

	// Generate '-' operator.
	void GenerateUMinus();

	// Generate 'not' operator.
	void GenerateNot();

	// Generate bitwise not operator.
	void GenerateBitwiseNot();

/* Line info */

	void put_line_info (int line_number, int start_column, int end_column);
		// Generate `n' to enable to find corresponding
		// Eiffel class file in IL code.

/* Labels creation */

	// Create a new label and return corresponding index.
	int CreateLabel();

/* Code generation switch between generation of interfaces and implementation */

	void SetForInterfaces ();
	void SetForImplementations ();

} // end of COMPILER_PROXY_I

} // end of namespace
