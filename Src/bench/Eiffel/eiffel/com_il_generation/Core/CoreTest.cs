/*
indexing
	description: "Test class for testing the IL code generator component."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.Reflection;
class CoreTest
{
	static void Main()
	{
		CoreTest test = new CoreTest();
		test.Run();
	}
	
	public CoreTest()
	{
	}
	
	public void Run()
	{
		Core C = new Core();
		C.StartAssemblyGeneration( CoreTestResultFileName );
		C.StartModuleGeneration( CoreTestResultFileName, false );
		
		C.StartClassMappings( ClassCount );
		
		C.GenerateClassMappings( CoreTestClassName, CoreTestResultTypeID, CoreTestResultSourceFileName );
		C.GenerateClassMappings( BooleanClassName, BooleanTypeID, BooleanSourceFileName );

		C.GenerateClassHeader( false, false, false, false, CoreTestResultTypeID );
		C.EndParentsList();
		
		C.GenerateClassHeader( false, false, false, true, BooleanTypeID );
		
		C.StartFeaturesList( CoreTestResultTypeID );

		C.StartFeatureDescription();
		C.GenerateFeatureNature( false, false, false, false );
		C.GenerateFeatureIdentification( FeatureName, FeatureID, RoutineID, true, CoreTestResultTypeID );
		C.GenerateFeatureReturnType( CoreTestResultTypeID );
		C.GenerateFeatureArgument( ArgumentName, CoreTestResultTypeID );
		C.CreateFeatureDescription();

		C.StartFeatureDescription();
		C.GenerateFeatureNature( false, false, false, true );
		C.GenerateFeatureIdentification( AttributeName, AttributeID, AttributeRID, true, CoreTestResultTypeID );
		C.GenerateFeatureReturnType( BooleanTypeID );
//		C.GenerateFeatureReturnType( CoreTestResultTypeID );
		C.CreateFeatureDescription();

		C.EndFeaturesList();
		
		C.StartIlGeneration( CoreTestResultTypeID );
		C.GenerateFeatureIL( FeatureID );
		C.PutResultInfo( CoreTestResultTypeID );
		C.GenerateReturnValue();
		
		C.EndClass();
		C.EndModuleGeneration();
		C.EndAssemblyGeneration();
	}
	
	// Number of generated classes
	static int ClassCount = 2;
//	static int ClassCount = 1;
	
	// CoreTestResult test class type identifier
	static int CoreTestResultTypeID = 1;
	
	// Object class type identifier
	static int BooleanTypeID = 2;
	
	// Source File Name
	static String CoreTestResultSourceFileName = "core_test.e";
	
	// Result File Name
	static String CoreTestResultFileName = "CoreTestResult.exe";
	
	// Test Class Name
	static String CoreTestClassName = "CORE_TEST";
	

	// Source File Name
	static String BooleanSourceFileName = "core_test.e";
	
	// Test Class Name
	static String BooleanClassName = "System.Int32";
	
	// Feature Name
	static String FeatureName = "test";
	
	// Feature Name
	static String AttributeName = "test2";
	
	// Feature ID
	static int FeatureID = 1;
	
	// Routine ID
	static int RoutineID = 1;
	
	// Feature ID
	static int AttributeID = 2;
	
	// Routine ID
	static int AttributeRID = 2;
	
	// Argument Name
	static String ArgumentName = "argument";
}
