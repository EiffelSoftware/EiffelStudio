/*
indexing
	description: "Wrapper around `EiffelReflectionEmit'. Initially made because of 
		a memory leak due to the generated assembly being loaded in memory and not
		freed by the .NET runtime. The solution was to create a new AppDomain in
		which we were doing the generation and at the end we were destroying this
		AppDomain and thus will collect the non-used memory.

		However this solution turned out to be very slow (57s versus 23) when you
		are using AppDomain versus using a simple delegation. Because of that we
		introduced a `ISE_APPDOMAIN' switch. If it is defined the class will use
		the AppDomain, otherwise it will use the delegation.
	
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.Remoting;
using System.Runtime.InteropServices;

[ClassInterfaceAttribute (ClassInterfaceType.None)]
public class Core : ICore {

	public void StartAssemblyGeneration (string Name, string FName,  string Location) {
		AssemblyName name = new AssemblyName();

#if ISE_APPDOMAIN
		Assembly assembly;
#endif

			// Define assembly we want to load..
		name.Name = "EiffelCompiler";
		name.Version = new Version (5,1,5,1);
		name.SetPublicKeyToken (new byte[8] {0x5b, 0x82, 0xf0, 0xd7, 0x09, 0x55, 0x93, 0x9a});
		name.CultureInfo = new System.Globalization.CultureInfo ("");

#if ISE_APPDOMAIN
			// Create AppDomain
		CoreApp = AppDomain.CreateDomain ("EiffelCompiler_domain");

			// Load our assembly into `CoreApp'.
		assembly = CoreApp.Load (name);

			// Create an instance of `EiffelReflectionEmit' in `CoreWrap' and
			// get a reference to it.
		core = (EiffelReflectionEmit) CoreApp.CreateInstanceAndUnwrap
			(assembly.FullName, "EiffelReflectionEmit");
#else
		core = new EiffelReflectionEmit();
#endif

#if ISE_APPDOMAIN
			// Make sure `CoreApp' stays alive until we unload it.
		CoreApp.InitializeLifetimeService();
#endif

			// Start IL generation through `core'.
		core.StartAssemblyGeneration (Name, FName, Location);
	}

	public void EndAssemblyGeneration() {
		core.EndAssemblyGeneration ();
		cleanup();
	}
		
	public string LastError() {
		string error = core.LastError ();
		cleanup();
		return error;
	}

	private void cleanup () {
#if ISE_APPDOMAIN
		AppDomain.Unload(CoreApp);
		CoreApp = null;
#endif
		core = null;
		GC.Collect();
	}

#if ISE_APPDOMAIN
	private AppDomain CoreApp;
#endif
	private EiffelReflectionEmit core;

/* Delegation to EiffelReflectionEmit object */

	public void SetConsoleApplication() {
		core.SetConsoleApplication();
	}

	public void SetWindowApplication() {
		core.SetWindowApplication ();
	}

	public void SetDll() {
		core.SetDll();
	}

	public void AddAssemblyReference (string Name) {
		core.AddAssemblyReference (Name);
	}

	public void StartModuleGeneration (string Name, bool Debug) {
		core.StartModuleGeneration (Name, Debug);
	}
		
	public void StartClassMappings (int nb) {
		core.StartClassMappings (nb);
	}
	
	public void GenerateClassMappings (string ClassName, int TypeID, int InterfaceID,
		string SourceFileName, string ElementTypeName)
	{
		core.GenerateClassMappings (ClassName, TypeID, InterfaceID, SourceFileName,
			ElementTypeName);
	}
	
	public void GenerateClassHeader (bool IsInterface,
		bool IsDeferred, bool IsFrozen, bool IsExpanded,
		bool IsExternal, int TypeID)
	{
		core.GenerateClassHeader (IsInterface, IsDeferred, IsFrozen, IsExpanded, IsExternal, TypeID);
	}
	
	public void EndClass() {
		core.EndClass();
	}

	public void AddToParentsList (int TypeID) {
		core.AddToParentsList (TypeID);
	}
	
	public void AddInterface (int TypeID) {
		core.AddInterface (TypeID);
	}

	public void AddEiffelInterface (int TypeID) {
		core.AddEiffelInterface (TypeID);
	}

	public void EndParentsList() {
		core.EndParentsList();
	}

	public void StartFeaturesList (int TypeID) {
		core.StartFeaturesList (TypeID);
	}

	public void MarkInvariant (int FeatureID) {
		core.MarkInvariant (FeatureID);
	}

	public void MarkCreationRoutines (int[] FeatureIDs) {
		core.MarkCreationRoutines (FeatureIDs);
	}
	
	public void StartFeatureDescription (int arg_count) {
		core.StartFeatureDescription (arg_count);
	}

	public void GenerateInterfaceFeatureIdentification
		(string Name, int FeatureID, bool IsAttribute)
	{
		core.GenerateInterfaceFeatureIdentification (Name, FeatureID, IsAttribute);
	}

	public void GenerateFeatureIdentification
		(string Name, int FeatureID, bool IsRedefined, bool IsDeferred, bool IsFrozen,
		bool IsAttribute, bool Is_C_External, bool IsStatic)
	{
		core.GenerateFeatureIdentification (Name, FeatureID, IsRedefined, IsDeferred,
			IsFrozen, IsAttribute, Is_C_External, IsStatic);
	}

	public void GenerateExternalIdentification (string Name, string ComName,
		int ExternalKind, int FeatureID, int RoutineID, bool InCurrentClass,
		int WrittenTypeID, string[] Parameters, string ReturnType)
	{
		core.GenerateExternalIdentification (Name, ComName, ExternalKind,
			FeatureID, RoutineID, InCurrentClass, WrittenTypeID,
			Parameters, ReturnType);
	}

	public void GenerateFeatureReturnType (int TypeID) {
		core.GenerateFeatureReturnType (TypeID);
	}
	
	public void GenerateFeatureArgument (string Name, int TypeID) {
		core.GenerateFeatureArgument (Name, TypeID);
	}

	public void CreateFeatureDescription() {
		core.CreateFeatureDescription ();
	}

	public void DefineEntryPoint (int CreationTypeID, int TypeID, int FeatureID) {
		core.DefineEntryPoint (CreationTypeID, TypeID, FeatureID);
	}

	public void AddCA (int TargetTypeID, int AttributeTypeID, int ArgCount) {
		core.AddCA (TargetTypeID, AttributeTypeID, ArgCount);
	}

	public void GenerateClassCA() {
		core.GenerateClassCA ();
	}

	public void GenerateFeatureCA (int FeatureID) {
		core.GenerateFeatureCA (FeatureID);
	}

	public void AddCATypedArg (int Value, int TypeID) {
		core.AddCATypedArg (Value, TypeID);
	}
	
	public void AddCAIntegerArg (int Value) {
		core.AddCAIntegerArg (Value);
	}
	
	public void AddCAInteger8Arg (byte Value) {
		core.AddCAInteger8Arg (Value);
	}
	
	public void AddCAInteger16Arg (Int16 Value) {
		core.AddCAInteger16Arg (Value);
	}
	
	public void AddCAInteger64Arg (Int64 Value) {
		core.AddCAInteger64Arg (Value);
	}

	public void AddCAStringArg (string Value) {
		core.AddCAStringArg (Value);
	}
	
	public void AddCARealArg (float Value) {
		core.AddCARealArg (Value);
	}
	
	public void AddCADoubleArg (double Value) {
		core.AddCADoubleArg (Value);
	}
	
	public void AddCACharacterArg (char Value) {
		core.AddCACharacterArg (Value);
	}
	
	public void AddCABooleanArg (bool Value) {
		core.AddCABooleanArg (Value);
	}

	public void AddCAArrayIntegerArg (int[] Value) {
		core.AddCAArrayIntegerArg (Value);
	}

	public void AddCAArrayInteger8Arg (byte[] Value) {
		core.AddCAArrayInteger8Arg (Value);
	}
	
	public void AddCAArrayInteger16Arg (Int16[] Value) {
		core.AddCAArrayInteger16Arg (Value);
	}
	
	public void AddCAArrayInteger64Arg (Int64[] Value) {
		core.AddCAArrayInteger64Arg (Value);
	}

	public void AddCAArrayStringArg (string[] Value) {
		core.AddCAArrayStringArg (Value);
	}
	
	public void AddCAArrayRealArg (float[] Value) {
		core.AddCAArrayRealArg (Value);
	}
	
	public void AddCAArrayDoubleArg (double[] Value) {
		core.AddCAArrayDoubleArg (Value);
	}
	
	public void AddCAArrayCharacterArg (char[] Value) {
		core.AddCAArrayCharacterArg (Value);
	}
	
	public void AddCAArrayBooleanArg (bool[] Value) {
		core.AddCAArrayBooleanArg (Value);
	}
	
	public void StartIlGeneration (int TypeID) {
		core.StartIlGeneration (TypeID);
	}
	
	public void GenerateImplementationFeatureIL (int FeatureID) {
		core.GenerateImplementationFeatureIL (FeatureID);
	}

	public void GenerateFeatureIL (int FeatureID, int TypeID, int CodeFeatureID) {
		core.GenerateFeatureIL (FeatureID, TypeID, CodeFeatureID);
	}

	public void GenerateMethodImpl (int FeatureID, int ParentTypeID, int ParentFeatureID){
		core.GenerateMethodImpl (FeatureID, ParentTypeID, ParentFeatureID);
	}

	public void GenerateFeatureInternalClone (int FeatureID) {
		core.GenerateFeatureInternalClone (FeatureID);
	}

	public void GenerateCreationFeatureIL (int FeatureID) {
		core.GenerateCreationFeatureIL (FeatureID);
	}

	public void GenerateExternalCall (
			string ExternalTypeName,
			string Name,
			int ExternalKind,
			string[] ParameterTypes,
			string ReturnType,
			bool IsVirtual,
			int TypeID,
			int FeatureID)
	{
		core.GenerateExternalCall (ExternalTypeName, Name, ExternalKind, ParameterTypes,
			ReturnType, IsVirtual, TypeID, FeatureID);
	}

	public void PutResultInfo (int TypeID) {
		core.PutResultInfo (TypeID);
	}
	
	public void PutLocalInfo (int TypeID, string Name) {
		core.PutLocalInfo (TypeID, Name);
	}

	public void CreateLikeCurrentObject() {
		core.CreateLikeCurrentObject ();
	}
	
	public void CreateObject (int TypeID) {
		core.CreateObject (TypeID);
	}

	public void CreateAttributeObject (int TypeID, int FeatureID) {
		core.CreateAttributeObject (TypeID, FeatureID);
	}

	public void SetEiffelType (int ExportedTypeID) {
		core.SetEiffelType (ExportedTypeID);
	}

	public void DuplicateTop() {
		core.DuplicateTop();
	}

	public void Pop() {
		core.Pop();
	}

	public void GenerateMetamorphose (int TypeID) {
		core.GenerateMetamorphose (TypeID);
	}
	
	public void GenerateUnmetamorphose (int TypeID) {
		core.GenerateUnmetamorphose (TypeID);
	}

	public void GenerateCheckCast (int SourceTypeID, int TargetTypeID) {
		core.GenerateCheckCast (SourceTypeID, TargetTypeID);
	}

	public void ConvertToNativeInt () {
		core.ConvertToNativeInt ();
	}
	public void ConvertToBoolean () {
		core.ConvertToBoolean ();
	}
	public void ConvertToCharacter () {
		core.ConvertToCharacter ();
	}
	public void ConvertToInteger8 () {
		core.ConvertToInteger8 ();
	}
	public void ConvertToInteger16 () {
		core.ConvertToInteger16 ();
	}
	public void ConvertToInteger32 () {
		core.ConvertToInteger32 ();
	}
	public void ConvertToInteger64 () {
		core.ConvertToInteger64 ();
	}
	public void ConvertToDouble () {
		core.ConvertToDouble ();
	}
	public void ConvertToReal () {
		core.ConvertToReal ();
	}

	public void GenerateCurrent() {
		core.GenerateCurrent ();
	}

	public void GenerateResult() {
		core.GenerateResult ();
	}

	public void GenerateAttribute (int TypeID, int FeatureID) {
		core.GenerateAttribute (TypeID, FeatureID);
	}

	public void GenerateFeatureAccess (int TypeID, int FeatureID, bool IsVirtual) {
		core.GenerateFeatureAccess (TypeID, FeatureID, IsVirtual);
	}
	
	public void GeneratePrecursorFeatureAccess (int TypeID, int FeatureID) {
		core.GeneratePrecursorFeatureAccess (TypeID, FeatureID);
	}
	
	public void PutMethodToken (int TypeID, int FeatureID) {
		core.PutMethodToken (TypeID, FeatureID);
	}

	public void GenerateArgument (int n) {
		core.GenerateArgument (n);
	}
	
	public void GenerateLocal (int n) {
		core.GenerateLocal (n);
	}

	public void GenerateInAssertionTest (int EndOfAssertLabel) {
		core.GenerateInAssertionTest (EndOfAssertLabel);
	}

	public void GenerateSetAssertionStatus() {
		core.GenerateSetAssertionStatus ();
	}

	public void GenerateRestoreAssertionStatus() {
		core.GenerateRestoreAssertionStatus ();
	}

	public void GenerateAssertionCheck (int AssertType, string Tag) {
		core.GenerateAssertionCheck (AssertType, Tag);
	}

	public void GeneratePreconditionCheck (string Tag, int LabelID) {
		core.GeneratePreconditionCheck (Tag, LabelID);
	}

	public void GeneratePreconditionViolation() {
		core.GeneratePreconditionViolation ();
	}

	public void GenerateInvariantChecking (int TypeID) {
		core.GenerateInvariantChecking (TypeID);
	}

	public void GenerateStartExceptionBlock(){
		core.GenerateStartExceptionBlock ();
	}

	public void GenerateStartRescue(){	
		core.GenerateStartRescue ();
	}

	public void GenerateEndExceptionBlock(){
		core.GenerateEndExceptionBlock ();
	}

	public void GenerateIsInstanceOf (int TypeID) {
		core.GenerateIsInstanceOf (TypeID);
	}

	public void GenerateAttributeAssignment (int TypeID, int FeatureID) {
		core.GenerateAttributeAssignment (TypeID, FeatureID);
	}
	
	public void GenerateLocalAssignment (int n) {
		core.GenerateLocalAssignment (n);
	}
	
	public void GenerateResultAssignment() {
		core.GenerateResultAssignment ();
	}

	public void GenerateLocalAddress (int n) {
		core.GenerateLocalAddress (n);
	}

	public void GenerateRoutineAddress (int TypeID, int FeatureID) {
		core.GenerateRoutineAddress (TypeID, FeatureID);
	}

 	public void GenerateResultAddress() {
		core.GenerateResultAddress ();
	}

	public void GenerateCurrentAddress() {
		core.GenerateCurrentAddress ();
	}

	public void GenerateAttributeAddress (int TypeID, int FeatureID) {
		core.GenerateAttributeAddress (TypeID, FeatureID);
	}

	public void GenerateArgumentAddress (int n) {
		core.GenerateArgumentAddress (n);
	}

	public void GenerateLoadFromAddress (int TypeID) {
		core.GenerateLoadFromAddress (TypeID);
	}

	public void GenerateArrayAccess (int Kind) {
		core.GenerateArrayAccess (Kind);
	}

	public void GenerateArrayWrite (int Kind) {
		core.GenerateArrayWrite (Kind);
	}

	public void GenerateArrayCreation (int TypeID) {
		core.GenerateArrayCreation (TypeID);
	}
	
	public void GenerateReturn() {
		core.GenerateReturn ();
	}
	
	public void GenerateReturnValue() {
		core.GenerateReturnValue ();
	}

	public void GenerateOnceDoneInfo (string name) {
		core.GenerateOnceDoneInfo (name);
	}

	public void GenerateOnceResultInfo (string name, int TypeID) {
		core.GenerateOnceResultInfo (name, TypeID);
	}

	public void GenerateOnceTest() {
		core.GenerateOnceTest ();
	}

	public void GenerateOnceResult() {
		core.GenerateOnceResult ();
	}

	public void GenerateOnceStoreResult() {
		core.GenerateOnceStoreResult ();
	}

	public void GenerateArrayLower() {
		core.GenerateArrayLower ();
	}
	
	public void GenerateArrayUpper() {
		core.GenerateArrayUpper ();
	}
	
	public void GenerateArrayCount() {
		core.GenerateArrayCount ();
	}
	
	public void PutVoid() {
		core.PutVoid ();
	}
	
	public void PutManifestString (string s) {
		core.PutManifestString (s);
	}
	
	public void PutInteger8Constant (int i ) {
		core.PutInteger8Constant (i);
	}

	public void PutInteger16Constant (int i ) {
		core.PutInteger16Constant (i);
	}

	public void PutInteger32Constant (int i ) {
		core.PutInteger32Constant (i);
	}

	public void PutInteger64Constant (long i ) {
		core.PutInteger64Constant (i);
	}

	public void PutDoubleConstant (double d) {
		core.PutDoubleConstant (d);
	}

	public void PutRealConstant (float d) {
		core.PutRealConstant (d);
	}

	public void PutCharacterConstant (char c) {
		core.PutCharacterConstant (c);
	}

	public void PutBooleanConstant (bool b) {
		core.PutBooleanConstant (b);
	}

	public void BranchOnTrue (int label) {
		core.BranchOnTrue (label);
	}

	public void BranchOnFalse (int label) {
		core.BranchOnFalse (label);
	}

	public void BranchTo (int label) {
		core.BranchTo (label);
	}

	public void MarkLabel (int label) {
		core.MarkLabel (label);
	}

	public void GenerateLt() {
		core.GenerateLt();
	}

	public void GenerateLe() {
		core.GenerateLe();
	}
	
	public void GenerateGt() {
		core.GenerateGt();
	}		

	public void GenerateGe() {
		core.GenerateGe();
	}
	
	public void GenerateStar() {
		core.GenerateStar();
	}

	public void GeneratePower() {
		core.GeneratePower();
	}

	public void GenerateMin(int TypeID) {
		core.GenerateMin(TypeID);
	}

	public void GenerateMax(int TypeID) {
		core.GenerateMax(TypeID);
	}

	public void GenerateAbs(int TypeID) {
		core.GenerateAbs(TypeID);
	}

	public void GenerateToString () {
		core.GenerateToString ();
	}

	public void GeneratePlus() {
		core.GeneratePlus();
	}

	public void GenerateMod() {
		core.GenerateMod();
	}

	public void GenerateMinus() {
		core.GenerateMinus();
	}

	public void GenerateDiv() {
		core.GenerateDiv();
	}

	public void GenerateXor() {
		core.GenerateXor();
	}

	public void GenerateOr() {
		core.GenerateOr();
	}

	public void GenerateAnd() {
		core.GenerateAnd();
	}

	public void GenerateImplies() {
		core.GenerateImplies();
	}

	public void GenerateEq() {
		core.GenerateEq();
	}

	public void GenerateShl() {
		core.GenerateShl();
	}

	public void GenerateShr() {
		core.GenerateShr();
	}

	public void GenerateNe() {
		core.GenerateNe();
	}

	public void GenerateUMinus() {
		core.GenerateUMinus();
	}

	public void GenerateNot() {
		core.GenerateNot();
	}

	public void GenerateBitwiseNot() {
		core.GenerateBitwiseNot();
	}

	public void PutLineInfo (int n) {
		core.PutLineInfo (n);
	}

	public int CreateLabel() {
		return core.CreateLabel ();
	}

	public void SetForInterfaces () {
		core.SetForInterfaces();
	}

	public void SetForImplementations () {
		core.SetForImplementations();
	}

}
