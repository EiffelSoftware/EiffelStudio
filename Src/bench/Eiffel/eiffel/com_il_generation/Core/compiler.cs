/*
indexing
	description: "Kernel of the Eiffel code generation using Reflection.Emit. In there
		there are features used to describe the hierarchy and content of classes that
		will be generated as well as features used to generate the actual IL code.
	
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
// Used to access the Debugger class
//using System.Diagnostics;
using System.Runtime.InteropServices;

namespace ISE.Compiler {

[ClassInterfaceAttribute (ClassInterfaceType.None)]
internal class COMPILER : MarshalByRefObject, COMPILER_PROXY_I {

/*
feature -- Settings
*/
	public void set_console_application()
		// Set console application generation
	{
		application_kind = PEFileKinds.ConsoleApplication;
	}

	public void set_window_application()
		// Set window application generation
	{
		application_kind = PEFileKinds.WindowApplication;
	}

	public void set_dll()
		// Set dll generation
	{
		application_kind = PEFileKinds.Dll;
	}

	public void set_version (int build, int major, int minor, int revision)
		// Set assembly version.
	{
		Version ver;

		if (assembly_name == null) {
			assembly_name = new AssemblyName();
		}

		ver = new Version (build, major, minor, revision);
		assembly_name.Version = ver;
	}

	public void set_verifiability (bool v)
		// Set verifiability of code generation. If `v' is True, generate
		// verifiable code, otherwise code is not verifiable.
	{
		is_verifiable = v;
	}

	public void set_cls_compliant (bool v)
		// Set cls compliance of code generation. If `v' is True, generate
		// cls compliant code, otherwise code is not cls compliant.
	{
		is_cls_compliant = v;
	}

	public void set_any_type_id (int v)
		// Set `Any_id' with `v'.
	{
		Any_id = v;
	}

/*
feature -- Generation Structure
*/
	// Create Assembly with name `Name'.
	public void StartAssemblyGeneration (string Name, string FName, string Location) {
		#if DEBUG
			DeleteLog();
			Log ("StartAssemblyGeneration" + " (" + Name + ", " +
				FName + ", " + Location + ")");
		#endif
		try {
			AppDomain curAppDomain = AppDomain.CurrentDomain;
			if (curAppDomain == null)
				throw new ApplicationException ("Null current application domain");

			if (assembly_name == null) {
				assembly_name = new AssemblyName();
			}
			assembly_name.Name = Name;

			dll_name = "lib" + Name + ".dll";
			dll_prefix = Name;

			FileStream fs = new FileStream (Location + "\\" + Name +
											Key_filename_extension, FileMode.Open);
//			assembly_name.KeyPair = new StrongNameKeyPair (fs);
			fs.Close();
			FileName = FName ;
			assembly = curAppDomain.DefineDynamicAssembly (assembly_name,
					AssemblyBuilderAccess.Save, Location);
			assembly.SetCustomAttribute (new CustomAttributeBuilder (
					typeof (System.CLSCompliantAttribute).GetConstructor
					(new Type[] {typeof (bool)}), new object[] {true}));

			ExternalAssemblies = new System.Collections.ArrayList();
			
			Ca_factory = new CA_FACTORY();

			// Initialize access to ISE Runtime Classes
			PrepareISERuntime();
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Load external assembly
	public void AddAssemblyReference (string Name) {
		#if DEBUG
			Log ("AddAssemblyReference" + " (" + Name + ")");
		#endif
		try {
			ExternalAssemblies.Add (Assembly.LoadFrom (Name));
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Create Module with name `Name' within current assembly.
	public void StartModuleGeneration (string Name, bool Debug) {
		#if DEBUG
			Log ("StartModuleGeneration" + " (" + Name + ", " + Debug + ")");
		#endif
		try {
			is_debugging_enabled = Debug;
			main_module = assembly.DefineDynamicModule (Name, Name, Debug);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
		
	// Finish creation of current assembly.
	// `CreateAssembly' should have been called before.
	public void EndAssemblyGeneration() {
		#if DEBUG
			Log ("EndAssemblyGeneration");
		#endif
		try {
			assembly.Save (FileName);
			CleanUp();
		}
		catch (Exception error) {
			LogError (error);
		}
	}
		
/* Class info */

	// Set number of classes to generate
	public void StartClassMappings (int nb) {
		#if DEBUG
			Log ("StartClassMappings" + " (" + nb + ")");
		try {
		#endif
			Classes = new CLASS [nb + 1];
		#if DEBUG
		}
		catch (Exception error) {
			LogError (error);
		}
		#endif
	}
	
	// Generate a class map between name and TypeID
	public void generate_class_mappings (string dotnet_name, string eiffel_name,
		int TypeID, int InterfaceID,
		string SourceFileName, string ElementTypeName)
	{
		#if DEBUG
			Log ("Class " + TypeID + ": " + eiffel_name);
		#endif
		try
		{
			bool is_array = ElementTypeName.Length > 0;
			CLASS eiffel_class;

			switch (dotnet_name)
			{
				case "System.Object": Object_id = TypeID; break;
				case "System.Int32": Integer_32_id = TypeID; break;
				case "System.Int64": Integer_64_id = TypeID; break;
				case "System.Int16": Integer_16_id = TypeID; break;
				case "System.Byte": Integer_8_id = TypeID; break;
				case "System.Single": Real_id = TypeID; break;
				case "System.Double": Double_id = TypeID; break;
				case "System.Char": Character_id = TypeID; break;
				case "System.Boolean": Boolean_id = TypeID; break;
				case "System.Exception": Exception_id = TypeID; break;
				case "System.IntPtr": Pointer_id = TypeID; break;
				default: break;
			}

			eiffel_class = new CLASS ();
			Classes [TypeID] = eiffel_class;
			eiffel_class.set_name (dotnet_name);
			eiffel_class.set_eiffel_name (eiffel_name);
			eiffel_class.SetTypeID (TypeID);
			eiffel_class.SetInterfaceID (InterfaceID);
			eiffel_class.SetIsArray(is_array);
			if (is_array)
				eiffel_class.SetArrayElementName (ElementTypeName);
			if (is_debugging_enabled) {
				eiffel_class.set_source_file_name (SourceFileName);
			}
		}
		catch (Exception error) {
			LogError (error, "For class " + dotnet_name + " with TypeID "
				+ TypeID + " and source file " + SourceFileName);
		}
	}

	public void generate_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.TYPE and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_type, type_id);
	}

	public void generate_class_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.CLASS_TYPE' and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_class_type, type_id);
	}

	public void generate_generic_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.GENERIC_TYPE and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_generic_type, type_id);
	}

	public void generate_formal_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.FORMAL_TYPE and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_formal_type, type_id);
	}

	public void generate_none_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.NONE_TYPE and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_none_type, type_id);
	}

	public void generate_eiffel_type_info_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.EIFFEL_TYPE_INFO and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_eiffel_type_info_type, type_id);
	}

	public void generate_basic_type_class_mapping (int type_id)
		// Generate mapping between `ISE.Runtime.BASIC_TYPE and `type_id'.
	{
		internal_generate_type_class_mapping (RUNTIME.Ise_basic_type, type_id);
	}

	// Generate class name and its specifier.
	public void GenerateClassHeader (bool IsInterface,
		bool IsDeferred, bool IsFrozen, bool IsExpanded,
		bool IsExternal, int TypeID)
	{
		Type ExternalType;
		#if DEBUG
			Log ("GenerateClassHeader ("+ IsInterface + ", " +
						 IsDeferred + ", " + IsExpanded + ", " + IsExternal + ", " + TypeID + ")");
		#endif
		
		try {
			CLASS eiffel_class = Classes [TypeID];

			if (IsExternal) {
				ExternalType = TypeFromName (eiffel_class.name);
				if (ExternalType == null)
					throw (new ApplicationException ("Could not find type " +
								eiffel_class.name));
				eiffel_class.SetTypeBuilder (ExternalType);
				eiffel_class.SetIsInterface (ExternalType.IsInterface);
				eiffel_class.SetIsDeferred (ExternalType.IsAbstract);
				eiffel_class.SetIsExpanded (ExternalType.IsValueType);
			} else {
				if (nb_classes_generated % Nb_classes_per_module == 0) {
					string module_name = "internal_module_" + (nb_classes_generated / Nb_classes_per_module) + ".dll";
					module = assembly.DefineDynamicModule (module_name, module_name, is_debugging_enabled);
				}
				nb_classes_generated = nb_classes_generated + 1;
				eiffel_class.set_module (module);
				eiffel_class.SetIsDeferred(IsDeferred);
				eiffel_class.SetIsInterface(IsInterface);
				eiffel_class.SetIsExpanded(IsExpanded);
				if (is_debugging_enabled) {
					eiffel_class.create_document ();
				}
			}
			eiffel_class.SetIsExternal (IsExternal);
			eiffel_class.SetIsFrozen (IsFrozen);
			CurrentTypeID = TypeID;
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Bake .NET type
	public void EndClass() {
		#if DEBUG
			Log ("EndClass");
		#endif
		try {
			#if DEBUG
				Log ("Full Name: " +
					 ((TypeBuilder)Classes [CurrentTypeID].Builder).FullName);
				Log ("Base type: " +
					 ((TypeBuilder)Classes [CurrentTypeID].Builder).BaseType);
				Log ("Declaring type: " +
					 ((TypeBuilder)Classes [CurrentTypeID].Builder).DeclaringType);
				Log ("Name: " +
					 ((TypeBuilder)Classes [CurrentTypeID].Builder).Name);
				Log ("Reflected type: " +
					 ((TypeBuilder)Classes [CurrentTypeID].Builder).ReflectedType);
				Log ("Size: " +
					 ((TypeBuilder)Classes [CurrentTypeID].Builder).Size);
				Type[] types = ((TypeBuilder)Classes [CurrentTypeID].Builder).GetInterfaces();
				for (int i = 0; i < types.Length; i++)
				{
					Log ("Interface " + i + ": " + types [i]);
				}
				Log ("Attributes: " +
					((TypeBuilder)Classes [CurrentTypeID].Builder).Attributes.ToString());
				Log ("Is abstract? : " +
					((TypeBuilder)Classes [CurrentTypeID].Builder).IsAbstract);
				Log ("Is public? : " +
					((TypeBuilder)Classes [CurrentTypeID].Builder).IsPublic);
			#endif
			CLASS eiffel_class = Classes [CurrentTypeID];
			((TypeBuilder) eiffel_class.Builder).CreateType();
			if (eiffel_class.StaticFeatureIDTable != eiffel_class.FeatureIDTable) {
				// We are current generating an implementation class, we can get rid
				// of its FeatureIDTable
				eiffel_class.SetFeatureIDTable (null);
			}
		}
		catch (Exception error) {
			LogError (error, "In class " +
				((TypeBuilder)Classes [CurrentTypeID].Builder));
		}
	}

	// Add class with id `TypeID' into list of parents of current type.
	public void AddToParentsList (int TypeID) {
		#if DEBUG
			Log ("AddToParentsList" + " (" + TypeID + ")");
		#endif
		Classes [CurrentTypeID].AddParent (TypeID);
	}
	
	// Add interface with id `TypeID' into list of parents of current type.
	public void AddInterface (int TypeID) {
		#if DEBUG
			Log ("AddToParentsList" + " (" + TypeID + ")");
		#endif
		Classes [CurrentTypeID].AddParent (TypeID);
	}

	public void set_implementation_class ()
		// Make class of ID `CurrentTypeID' to be an implementation class.
	{
		Classes [CurrentTypeID].set_implementation_class ();
	}

	// Finish inheritance part description
	public void EndParentsList()
	{
		#if DEBUG
			Log ("EndParentsList");
		#endif
		if (!Classes [CurrentTypeID].IsInterface && Classes [CurrentTypeID].BaseType == No_value) {
			Classes [CurrentTypeID].AddParent (Object_id);
		}		
		Classes [CurrentTypeID].CreateTypeBuilder();
	}

/* Features info */

	// Start enumeration of features written in class with TypeID `TypeID'.
	public void StartFeaturesList (int TypeID) {
		#if DEBUG
			Log ("StartFeaturesList (" + TypeID+ ")");
		#endif
		try
		{
			CurrentTypeID = TypeID;
			System.Collections.Hashtable CurrentFeatureIDTable;
			CurrentFeatureIDTable = new System.Collections.Hashtable();
			Classes [TypeID].SetFeatureIDTable (CurrentFeatureIDTable);
			if (Classes [TypeID].IsFrozen || Classes [TypeID].IsInterface) {
				Classes [TypeID].SetStaticFeatureIDTable (CurrentFeatureIDTable);
			} else {
				Classes [TypeID].SetStaticFeatureIDTable (new System.Collections.Hashtable());
			}
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Mark the invariant routine
	public void MarkInvariant (int FeatureID) {
		#if DEBUG
			Log ("MarkInvariant (" + FeatureID + ")");
		#endif
		try {
			Classes[CurrentTypeID].SetInvariant (FeatureID);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Mark the invariant routine
	public void MarkCreationRoutines (int[] FeatureIDs) {
		Classes[CurrentTypeID].SetCreationRoutines (FeatureIDs);
	}
	
	// Start enumeration of features written in current class.
	public void StartFeatureDescription (int arg_count) {
		CurrentMethod = new FEATURE (CurrentTypeID, arg_count);
		arg_pos = 0;
	}

	// Generate info about current feature knowing that it is going 
	// to be generated in interface only.
	public void GenerateInterfaceFeatureIdentification
		(string Name, int FeatureID, bool is_attribute)
	{
		CurrentMethod.set_eiffel_name (Name);
		CurrentMethod.set_feature_id (FeatureID);
		CurrentMethod.set_is_attribute (is_attribute);
		CurrentMethod.set_is_deferred (true);
		CurrentMethod.set_is_interface_routine (true);
		Classes [CurrentTypeID].FeatureIDTable.Add (FeatureID, CurrentMethod);
	}

	// Generate info about current feature.
	public void GenerateFeatureIdentification
		(string Name, int FeatureID, bool IsRedefined, bool IsDeferred, bool IsFrozen,
		bool is_attribute, bool is_c_external, bool is_static)
	{
		CurrentMethod.set_eiffel_name (Name);
		CurrentMethod.set_feature_id (FeatureID);
		CurrentMethod.set_is_redefined (IsRedefined);
		CurrentMethod.set_is_deferred (IsDeferred);
		CurrentMethod.set_is_frozen (IsFrozen);
		CurrentMethod.set_is_attribute (is_attribute);
		CurrentMethod.set_is_static (is_static);
		CurrentMethod.set_is_c_external (is_c_external);
		if (is_static) {
			Classes [CurrentTypeID].StaticFeatureIDTable.Add (FeatureID, CurrentMethod);
		} else {
			Classes [CurrentTypeID].FeatureIDTable.Add (FeatureID, CurrentMethod);
		}
	}

	// Generate info about external feature.
	public void GenerateExternalIdentification (string Name, string ComName,
		int ExternalKind, int FeatureID, int RoutineID, bool InCurrentClass,
		int WrittenTypeID, string[] Parameters, string ReturnType)
	{
		CurrentMethod.set_feature_id (FeatureID);
		CurrentMethod.set_eiffel_name (Name);
		CurrentMethod.set_real_name (ComName);
		Classes [CurrentTypeID].FeatureIDTable.Add (FeatureID, CurrentMethod);
	}

	// Generate info about current feature.
	public void GenerateFeatureReturnType (int TypeID) {
		CurrentMethod.set_return_type_id (TypeID);
	}
	
	// Generate info about current feature.
	public void GenerateFeatureArgument (string Name, int TypeID) {
		CurrentMethod.add_argument (Name, TypeID, arg_pos);
		arg_pos++;
	}

	// Freeze current Method.
	public void CreateFeatureDescription() {
		try {
			CurrentMethod.create_method_builder ();
		}
		catch (Exception error) {
			LogError (error, "In method " + CurrentMethod.name () + " from " +
				Classes [CurrentTypeID].name);
		}
	}

	// Define system entry point (root feature of root class)
	public void DefineEntryPoint (int CreationTypeID, int TypeID, int FeatureID)
	{
		try
		{
			TypeBuilder EntryType;
			MethodBuilder entry_point;
			ILGenerator Generator;
			FEATURE eiffel_entry_point;
	
			EntryType = main_module.DefineType (Classes [TypeID].name + EntryTypeName);


			entry_point = EntryType.DefineMethod (Entry_point_name,
				MethodAttributes.Public | MethodAttributes.Static,
				Type.GetType ("void"), Type.EmptyTypes);

			entry_point.SetCustomAttribute (CA.debugger_hidden_attr);
			entry_point.SetCustomAttribute (CA.debugger_step_through_attr);
			
			Generator = entry_point.GetILGenerator();
			eiffel_entry_point = ((FEATURE) (Classes [TypeID].
				StaticFeatureIDTable [FeatureID]));
			if (eiffel_entry_point == null)
				throw new ApplicationException ("DefineEntryPoint: Real entry point " + 
					"not found (TypeID: " + TypeID + ", FeatureID: " + FeatureID + ")");


			Generator.Emit ( OpCodes.Newobj, Classes [CreationTypeID].DefaultConstructor);
			if (eiffel_entry_point.argument_count > 1) {
				Generator.Emit (OpCodes.Ldarg_0);
			}

			Generator.Emit (OpCodes.Call, eiffel_entry_point.method_builder);

			if (is_debugging_enabled) {
				Classes [TypeID].module.SetUserEntryPoint (eiffel_entry_point.method_builder);
			}

			Generator.Emit (OpCodes.Ret);
			EntryType.CreateType();
			assembly.SetEntryPoint (entry_point, application_kind);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

/* Error Handling */

	public string LastError() {
		string Message = null;

		if (LastException != null) {
			Message = LastException.Message;
			if ((LastException.Source != null)&& (LastException.Source.Length > 0)) {
				Message += "\nSource: ";
				Message += LastException.Source;
			}
		}
		return Message;
	}

/* Custom Attributes Generation */

	// Start new custom attribute generation
	// TargetTypeID: type id of class where custom attribute is added
	// AttributeTypeID: Type id of custom attribute
	// ArgCount: Custom attribute constructor arguments count
	public void AddCA (int TargetTypeID, int AttributeTypeID, int ArgCount) {
		#if DEBUG
			Log ("AddClassCustomAttribute (" + TargetTypeID.ToString() +
				", " + AttributeTypeID.ToString()+ ", " + ArgCount.ToString()+ ")");
		#endif
		try {
			Ca_factory.StartNewAttribute (TargetTypeID, AttributeTypeID, ArgCount);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// 	
	// `AddCA' must be called before
	// Any necessary call to `AddCAxxxArg' must be done before
	public void GenerateClassCA() {
		#if DEBUG
			Log ("GenerateClassCA()");
		#endif
		try {
			Ca_factory.GenerateClassCA();
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Generate method or field custom attribute
	// `AddCA' must be called before
	// Any necessary call to `AddCAxxxArg' must be done before
	public void GenerateFeatureCA (int FeatureID) {
		#if DEBUG
			Log ("GenerateFeatureCA (" + FeatureID.ToString()+ ")");
		#endif
		try {
			Ca_factory.GenerateFeatureCA (FeatureID);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Add custom attribute constructor custom type argument (useful for enums)
	public void AddCATypedArg (int Value, int TypeID) {
		#if DEBUG
			Log ("AddCATypedArg (" + Value.ToString()+ ", " + TypeID.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value, Classes [TypeID].Builder);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor integer argument
	public void AddCAIntegerArg (int Value) {
		#if DEBUG
			Log ("AddCAIntegerArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor byte argument
	public void AddCAInteger8Arg (byte Value) {
		#if DEBUG
			Log ("AddCAInteger8Arg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 16 argument
	public void AddCAInteger16Arg (Int16 Value) {
		#if DEBUG
			Log ("AddCAInteger16Arg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 64 argument
	public void AddCAInteger64Arg (Int64 Value) {
		#if DEBUG
			Log ("AddCAInteger64Arg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Add custom attribute constructor string argument
	public void AddCAStringArg (string Value) {
		#if DEBUG
			Log ("AddCAstringArg (" + Value + ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor real argument
	public void AddCARealArg (double Value) {
		#if DEBUG
			Log ("AddCARealArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg ((float) Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor double argument
	public void AddCADoubleArg (double Value)
	{
		#if DEBUG
			Log ("AddCADoubleArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor character argument
	public void AddCACharacterArg (char Value) {
		#if DEBUG
			Log ("AddCACharacterArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor boolean argument
	public void AddCABooleanArg (bool Value) {
		#if DEBUG
			Log ("AddCABooleanArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Add custom attribute constructor integer argument
	public void AddCAArrayIntegerArg (int[] Value) {
		#if DEBUG
			Log ("AddCAArrayIntegerArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Add custom attribute constructor byte argument
	public void AddCAArrayInteger8Arg (byte[] Value) {
		#if DEBUG
			Log ("AddCAArrayInteger8Arg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 16 argument
	public void AddCAArrayInteger16Arg (Int16[] Value) {
		#if DEBUG
			Log ("AddCAArrayInteger16Arg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 64 argument
	public void AddCAArrayInteger64Arg (Int64[] Value) {
		#if DEBUG
			Log ("AddCAArrayInteger64Arg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}

	// Add custom attribute constructor string argument
	public void AddCAArrayStringArg (string[] Value) {
		#if DEBUG
			Log ("AddCAArraystringArg (" + Value + ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor real argument
	public void AddCAArrayRealArg (double [] Value) {
		#if DEBUG
			Log ("AddCAArrayRealArg (" + Value.ToString()+ ")");
		#endif
		try {
			float [] values = new float[Value.Length];
			for (int i = 0; i < Value.Length; i++) {
				values [i] = (float) Value [i];
			}
			Ca_factory.AddCAConstructorArg (values);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor double argument
	public void AddCAArrayDoubleArg (double[] Value) {
		#if DEBUG
			Log ("AddCAArrayDoubleArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor character argument
	public void AddCAArrayCharacterArg (char[] Value) {
		#if DEBUG
			Log ("AddCAArrayCharacterArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
	// Add custom attribute constructor boolean argument
	public void AddCAArrayBooleanArg (bool[] Value) {
		#if DEBUG
			Log ("AddCAArrayBooleanArg (" + Value.ToString()+ ")");
		#endif
		try {
			Ca_factory.AddCAConstructorArg (Value);
		}
		catch (Exception error) {
			LogError (error);
		}
	}
	
/* IL Generation */

	// Start IL Generation for current class
	public void StartIlGeneration (int TypeID) {
		CurrentTypeID = TypeID;
	}

	public void generate_finalize_feature (int feature_id)
		// Generate `Finalize' feature on Eiffel objects.
	{
		MethodBuilder finalize;
		FEATURE implementation;
		
		finalize = ((TypeBuilder) Classes [CurrentTypeID].Builder).DefineMethod ("Finalize",
				MethodAttributes.Family | MethodAttributes.HideBySig | MethodAttributes.Virtual,
				VoidType, Type.EmptyTypes);

		implementation = (FEATURE) Classes [CurrentTypeID].StaticFeatureIDTable [feature_id];

		MethodIL = finalize.GetILGenerator();
		GenerateCurrent();
		MethodIL.Emit (OpCodes.Call, implementation.method_builder);
		MethodIL.Emit (OpCodes.Ret);
	}

	// Generate info about current feature.
	public void GenerateImplementationFeatureIL (int FeatureID) {
		try {
			CurrentMethod = (FEATURE) Classes [CurrentTypeID].StaticFeatureIDTable [FeatureID];
			if (!CurrentMethod.is_attribute && !CurrentMethod.is_c_external) {
				Labels = new System.Collections.ArrayList();
				MethodIL = ((MethodBuilder)CurrentMethod.method_builder).GetILGenerator();
				Locals = new System.Collections.ArrayList();
			}
		}
		catch (Exception error) {
			LogError (error, "In GenerateFeatureIL with FeatureID " + FeatureID);
		}
	}

	public void generate_type_feature (int feature_id)
		// Prepare for code generation of formal derivation.
	{
		CurrentMethod = (FEATURE) Classes [CurrentTypeID].FeatureIDTable [feature_id];
		Labels = new System.Collections.ArrayList();
		MethodIL = ((MethodBuilder)CurrentMethod.method_builder).GetILGenerator();
		Locals = new System.Collections.ArrayList();
	}

	// Generate info about current feature.
	// We generate here a dummy call to location where code is actually defined,
	// i.e. in class `TypeID' to feature `CodeFeatureID' in StaticFeatureIDTable
	public void GenerateFeatureIL (int FeatureID, int TypeID, int CodeFeatureID) {
		try {
			FEATURE Method, DefinitionMethod;
			int i, nb;

			Method = (FEATURE) Classes [CurrentTypeID].
				FeatureIDTable [FeatureID];

			DefinitionMethod = (FEATURE) Classes [TypeID].
				StaticFeatureIDTable [CodeFeatureID];

			if (DefinitionMethod != null) {
				if (DefinitionMethod.is_attribute) {
						// Generate Getter of attribute
					MethodIL = ((MethodBuilder) Method.method_builder).GetILGenerator();
					GenerateCurrent ();
					MethodIL.Emit (OpCodes.Ldfld, DefinitionMethod.attribute_builder);
					generate_cast (Method.return_type_id, DefinitionMethod.return_type_id);
					MethodIL.Emit (OpCodes.Ret);		

					MethodBuilder Setter = Method.setter_builder;
					MethodIL = Setter.GetILGenerator();
					GenerateCurrent ();
					GenerateArgument (1);
					generate_cast (Method.return_type_id, DefinitionMethod.return_type_id);
					MethodIL.Emit (OpCodes.Stfld, DefinitionMethod.attribute_builder);
				} else {
					MethodIL = ((MethodBuilder) Method.method_builder).GetILGenerator();
					nb = DefinitionMethod.argument_count + 1;
					if (!DefinitionMethod.is_c_external) {
						GenerateCurrent();
					}
					for (i = 1; i < nb; i++) {
						GenerateArgument (i);
						generate_cast (Method.parameter_type_ids [i - 1],
							DefinitionMethod.parameter_type_ids [i - 1]);
					}
					MethodIL.Emit (OpCodes.Call, DefinitionMethod.method_builder);
					if (Method.has_return_type) {
							// It is inverted from the parameter has we need to pull the
							// result from `DefinitionMethod' to match the signature of `Method'.
						generate_cast (DefinitionMethod.return_type_id, Method.return_type_id);
					}
				}
			} else {
				MethodIL = ((MethodBuilder) Method.method_builder).GetILGenerator();
				Console.WriteLine ("One more feature");
			}
			MethodIL.Emit (OpCodes.Ret);		
		}
		catch (Exception error) {
			LogError (error, "In GenerateFeatureIL with FeatureID " + FeatureID);
		}
	}

	// Generate a MethodImpl from `ParentTypeID::ParentFeatureID' into 
	// `CurrentTypeID::FeatureID'.
	public void GenerateMethodImpl (int FeatureID, int ParentTypeID, int ParentFeatureID) {
		try {
			FEATURE Method, ParentMethod;
			MethodBuilder override_method;
			int[] param_info = null, parent_param_info = null;
			int i, nb;
			bool same_type;

			Method = (FEATURE) Classes [CurrentTypeID].
				FeatureIDTable [FeatureID];
			ParentMethod = (FEATURE) Classes [ParentTypeID].
				FeatureIDTable [ParentFeatureID];

		if (ParentMethod != null) {
			param_info = Method.parameter_type_ids;
			parent_param_info = ParentMethod.parameter_type_ids;
			nb = Method.argument_count;
			same_type = Object.Equals (Method.method_builder.ReturnType, ParentMethod.method_builder.ReturnType);
			i = 0;
			while (same_type && i < nb) {
				same_type = (param_info [i] == parent_param_info [i]);
				i++;
			}

			if (same_type) {
				((TypeBuilder) Classes [CurrentTypeID].Builder).
					DefineMethodOverride (
						Method.method_builder,
						ParentMethod.method_builder);
				if (Method.is_attribute && ParentMethod.is_attribute) {
						// Generate MethodImp for Setter
					((TypeBuilder) Classes [CurrentTypeID].Builder).
						DefineMethodOverride (Method.setter_builder, ParentMethod.setter_builder);
				}
			} else {
				param_info = ParentMethod.parameter_type_ids;
				Type[] ParameterTypes = new Type [param_info.Length ];
				for (i = 0; i < nb; i++)
					ParameterTypes [i] = Classes [param_info [i]].Builder;

				override_method = ((TypeBuilder) Classes [CurrentTypeID].Builder).
					DefineMethod (Override_prefix + ParentMethod.name () + counter.ToString(),
						MethodAttributes.Virtual | MethodAttributes.Final |
							MethodAttributes.Private,
						ParentMethod.method_builder.ReturnType,
						ParameterTypes);

				override_method.SetCustomAttribute (CA.not_cls_compliant_attr);

				counter = counter + 1;

				MethodIL = override_method.GetILGenerator();
				GenerateCurrent ();
				for (i = 0; i < nb ; i++) {
					GenerateArgument (i + 1);
					generate_cast (ParentMethod.parameter_type_ids [i],
						Method.parameter_type_ids [i]);
				}
				MethodIL.Emit (OpCodes.Callvirt, Method.method_builder);

				if (Method.has_return_type) {
						// It is inverted from the parameter has we need to pull the
						// result from `Method' to match the signature of `ParentMethod'.
					generate_cast (Method.return_type_id, ParentMethod.return_type_id);
				}

				MethodIL.Emit (OpCodes.Ret);

				((TypeBuilder) Classes [CurrentTypeID].Builder).
					DefineMethodOverride (override_method, ParentMethod.method_builder);

				if (Method.is_attribute && ParentMethod.is_attribute) {
						// Generate MethodImpl on Setter.
					override_method = ((TypeBuilder) Classes [CurrentTypeID].Builder).
						DefineMethod (Override_prefix + Setter_prefix + ParentMethod.name () +
							counter.ToString(), MethodAttributes.Virtual | MethodAttributes.Final |
								MethodAttributes.Private, VoidType,
							new Type [1] {ParentMethod.method_builder.ReturnType});

					counter = counter + 1;

					MethodIL = override_method.GetILGenerator();
					GenerateCurrent ();
					GenerateArgument (1);
					generate_cast (ParentMethod.return_type_id,
						Method.return_type_id);
					MethodIL.Emit (OpCodes.Callvirt, Method.setter_builder);
					MethodIL.Emit (OpCodes.Ret);

					((TypeBuilder) Classes [CurrentTypeID].Builder).
						DefineMethodOverride (override_method, ParentMethod.setter_builder);
				}
			}
		} else {
			Console.WriteLine ("Bad MethodImpl");
		}
		}
		catch (Exception error) {
			LogError (error, "In GenerateMethodImpl with FeatureID " + FeatureID);
		}
	}

	// Generate implementation of `internal_duplicate' of ANY
	public void generate_feature_internal_duplicate (int FeatureID) {
		if (MemberwiseCloneMethod == null) {
			MemberwiseCloneMethod = ObjectType.GetMethod ("MemberwiseClone",
					BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public |
					BindingFlags.NonPublic);
		}

		FEATURE Method = (FEATURE) Classes [CurrentTypeID].FeatureIDTable [FeatureID];

		MethodIL = ((MethodBuilder) Method.method_builder).GetILGenerator();
		GenerateCurrent ();
		MethodIL.Emit (OpCodes.Call, MemberwiseCloneMethod);
		generate_cast (0, CurrentTypeID);
		MethodIL.Emit (OpCodes.Ret);		
	}

	// Generate info about current creation feature.
	public void GenerateCreationFeatureIL (int FeatureID) {
		try {
			Labels = new System.Collections.ArrayList();
			CurrentMethod = (FEATURE) Classes [CurrentTypeID].
				FeatureIDTable [FeatureID];
			Locals = new System.Collections.ArrayList();
			// To implement: 
			// MethodIL = (???).GetILGenerator();
		}
		catch (Exception error) {
			LogError (error, "In GenerateCreationFeatureIL with FeatureID " + FeatureID);
		}
	}

	public void GenerateExternalCall (
			string ExternalTypeName,
			string Name,
			int ExternalKind,
			string[] ParameterTypes,
			string ReturnType,
			bool IsVirtual)
	{
		Type NewType = null;
		Type[] Parameters;
		int i;
		
		try {
			Parameters = new Type[ ParameterTypes.Length ];
			for (i = 0; i < ParameterTypes.Length; i++)
			{
				NewType = TypeFromName (ParameterTypes [i]);
				if (NewType == null)
					throw new ApplicationException (
						"GenerateExternalCall: Unknown argument type: " + ParameterTypes [i]);
				Parameters [i] = NewType;
			}
			NewType = TypeFromName (ExternalTypeName);
			if (NewType == null)
				throw new ApplicationException ("Type " + ExternalTypeName + " not found.");
			switch (ExternalKind)
			{
				case Normal_type:
				case Deferred_type:
					if (IsVirtual)
						MethodIL.Emit (OpCodes.Callvirt, NewType.GetMethod (Name,
							BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public |
							BindingFlags.NonPublic, null, Parameters, null));
					else
						MethodIL.Emit (OpCodes.Call, NewType.GetMethod (Name,
							BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public |
							BindingFlags.NonPublic, null, Parameters, null));
					break;
				case Creator_type:
					MethodIL.Emit (OpCodes.Newobj, NewType.GetConstructor (Parameters));
					break;
				case Field_type:
					MethodIL.Emit (OpCodes.Ldfld, NewType.GetField (Name));
					break;
				case Static_field_type:
					MethodIL.Emit (OpCodes.Ldsfld, NewType.GetField (Name));
					break;
				case Set_field_type:
					MethodIL.Emit (OpCodes.Stfld, NewType.GetField (Name));
					break;
				case Set_static_field_type:
					MethodIL.Emit (OpCodes.Stsfld, NewType.GetField (Name));
					break;
				case Static_type:
					MethodIL.Emit (OpCodes.Call, NewType.GetMethod (Name,
						BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public |
						BindingFlags.NonPublic, null, Parameters, null));
					break;
				case Creator_call_type:
					MethodIL.Emit (OpCodes.Call, NewType.GetConstructor (Parameters));
					break;
				default:
					throw new ApplicationException ("GenerateExternalCall: Invalid External Kind");
			}
		}
		catch (Exception error) {
			LogError (error, "For method " + Name + " on class " + NewType);
		}
	}

/* Local Variable Info Generator */

	public void PutResultInfo (int TypeID) {
		try {
			Result = MethodIL.DeclareLocal (Classes[ TypeID ].Builder);
			if (is_debugging_enabled)
				Result.SetLocalSymInfo (ResultName);
		}
		catch (Exception error) {
			LogError (error, "With object of type " + Classes [TypeID].Builder);
		}			
	}
	
	public void PutLocalInfo (int TypeID, string Name) {
		try {
			LocalBuilder NewLocal = MethodIL.DeclareLocal (Classes [TypeID].Builder);
			if (is_debugging_enabled)
				NewLocal.SetLocalSymInfo (Name);
			Locals.Add (NewLocal);
		}
		catch (Exception error) {
			LogError (error, "With object of type " + Classes [TypeID].Builder);
		}			
	}

/* Object Creation */

	public void CreateLikeCurrentObject() {
			// FIXME: Code is not correct, we should evaluate current type
			// and create an instance of it.
		CLASS eiffel_class = Classes [CurrentTypeID];
		MethodIL.Emit (OpCodes.Newobj, eiffel_class.DefaultConstructor);
		LastCreatedClass = eiffel_class;
	}
	
	public void CreateObject (int TypeID) {
			// In case of Eiffel generated classes:
			// Classes [TypeID] corresponds to interface class
			// Classes [TypeID + 1] corresponds to implementation class
			// For external classes or Frozen classes, there is only one
			// entry in Classes.
		CLASS eiffel_class = Classes [TypeID];

		if (!eiffel_class.IsExternal && !eiffel_class.IsFrozen)
			eiffel_class = Classes [TypeID + 1];

		MethodIL.Emit (OpCodes.Newobj, eiffel_class.DefaultConstructor);
		LastCreatedClass = eiffel_class;
	}

	public void CreateAttributeObject (int TypeID, int FeatureID) {
		CLASS eiffel_class = Classes [TypeID];
		FEATURE f = (FEATURE) eiffel_class.FeatureIDTable [FeatureID];

		try {
			#if ASSERTIONS	
				if (f == null || f.return_type_id == No_value)
					throw new ApplicationException ("Not an attribute or like function");
			#endif

			int type_id = f.return_type_id;
			eiffel_class = Classes [type_id];
			
			if (!eiffel_class.IsExternal && !eiffel_class.IsFrozen)
				type_id = type_id + 1;
			
			eiffel_class = Classes [type_id];
			if (eiffel_class.IsArray) {
				MethodIL.Emit (OpCodes.Newarr, eiffel_class.ArrayElementType());
			} else {
				if (! (eiffel_class.IsExternal)) {
					MethodIL.Emit (OpCodes.Newobj, eiffel_class.DefaultConstructor);
				}
			}
			LastCreatedClass = eiffel_class;
		}
		catch (Exception error)
		{
			LogError (error, "With object of type " + Classes [TypeID].Builder);
		}
	}

/* IL stack managment */

	public void DuplicateTop() {
		MethodIL.Emit (OpCodes.Dup);
	}

	// Remove top element of IL stack.
	public void Pop() {
		MethodIL.Emit (OpCodes.Pop);
	}

/* Variables access */

	// Generate box operation
	public void GenerateMetamorphose (int TypeID) {
		MethodIL.Emit (OpCodes.Box, Classes [TypeID].Builder);
	}
	
	// Generate unbox operation followed by load indirect
	public void GenerateUnmetamorphose (int TypeID) {
		MethodIL.Emit (OpCodes.Unbox, Classes [TypeID].Builder);
		GenerateLoadFromAddress (TypeID);
	}

	// Generate Cast
	public void GenerateCheckCast (int SourceTypeID, int TargetTypeID) {
		MethodIL.Emit (OpCodes.Castclass, Classes [TargetTypeID].Builder);
	}

	public void generate_cast (int source_id, int target_id)
		// If `is_verifiable' is True, and `source_id' is different from `target_id'
		// and `source_id' does not conform to `target_id', we generate a cast
		// to type represented by `target_id'.
		// If `source_id' is `0' we force a cast to `target_id'.
	{
		if
			(is_verifiable && (source_id != target_id) &&
			(source_id == 0 ||
			!Classes [target_id].Builder.IsSubclassOf (Classes [source_id].Builder)))
		{
			MethodIL.Emit (OpCodes.Castclass, Classes [target_id].Builder);
		}
	}

/* Conversion */

	// Convert Object on top of stack into appropriate type.
	public void ConvertToNativeInt () {
		MethodIL.Emit (OpCodes.Conv_I);
	}
	public void ConvertToBoolean () {
		MethodIL.Emit (OpCodes.Conv_I1);
	}
	public void ConvertToCharacter () {
		MethodIL.Emit (OpCodes.Conv_I2);
	}
	public void ConvertToInteger8 () {
		MethodIL.Emit (OpCodes.Conv_I1);
	}
	public void ConvertToInteger16 () {
		MethodIL.Emit (OpCodes.Conv_I2);
	}
	public void ConvertToInteger32 () {
		MethodIL.Emit (OpCodes.Conv_I4);
	}
	public void ConvertToInteger64 () {
		MethodIL.Emit (OpCodes.Conv_I8);
	}
	public void ConvertToDouble () {
		MethodIL.Emit (OpCodes.Conv_R8);
	}
	public void ConvertToReal () {
		MethodIL.Emit (OpCodes.Conv_R4);
	}

/* Generate Local access */

	// Generate access to `Current'.
	public void GenerateCurrent() {
		MethodIL.Emit (OpCodes.Ldarg_0);
	}

	// Generate result
	public void GenerateResult() {
		MethodIL.Emit (OpCodes.Ldloc, Result);
	}

	// Generate attribute
	public void GenerateAttribute (int TypeID, int FeatureID) {
		try {
			MethodIL.Emit (OpCodes.Ldfld, ((FEATURE)Classes [TypeID].
				FeatureIDTable [FeatureID]).attribute_builder);
		}
		catch (Exception error) {
			LogError (error, "In feature with ID " + FeatureID + " (" +
				((FEATURE)Classes [TypeID].FeatureIDTable [FeatureID]).name ()+
				")of " + Classes [TypeID].Builder);
		}
	}

	// Generate feature access
	public void GenerateFeatureAccess (int TypeID, int FeatureID, bool IsVirtual) {
		MethodInfo Feature = null;
		try {
			Feature = ((FEATURE)Classes [TypeID].FeatureIDTable [FeatureID]).method_builder;
			if (IsVirtual)
				MethodIL.Emit (OpCodes.Callvirt, Feature);
			else
				MethodIL.Emit (OpCodes.Call, Feature);
		}
		catch (Exception error) {
			LogError (error, " in class " + ((CLASS)Classes [TypeID]).name +
				" (TypeID = " + TypeID + ")for method " + ((FEATURE)Classes [TypeID].
				FeatureIDTable [FeatureID]).name ()+ " (FeatureID = " + FeatureID + "): " + Feature);
		}
	}

	// Generate precursor feature access
	public void GeneratePrecursorFeatureAccess (int TypeID, int FeatureID) {
		MethodInfo Feature = null;
		Feature = ((FEATURE)Classes [TypeID].
				StaticFeatureIDTable [FeatureID]).method_builder;
		MethodIL.Emit (OpCodes.Call, Feature);
	}

	// Put associated token of a feature
	public void PutMethodToken (int TypeID, int FeatureID) {
		try {
			MethodBuilder Feature = (MethodBuilder) ((FEATURE)Classes [TypeID].
						FeatureIDTable [FeatureID]).method_builder;
			MethodIL.Emit (OpCodes.Ldtoken, Feature);
		}
		catch (Exception error) {
			LogError (error, " in method " + ((FEATURE)Classes [TypeID].
				FeatureIDTable [FeatureID]).name () + " from class " +
				((CLASS)Classes [TypeID]).name);
		}
	}

	public void put_type_token (int type_id)
		// Put associated token to `type_id'.
	{
		MethodIL.Emit (OpCodes.Ldtoken, Classes [type_id].Builder);
	}
	
	// Generate access to `n'-th argument of current feature.
	// Cannot be `0', reserved for `Current'.
	public void GenerateArgument (int n) {
		switch (n) {
			case 0: MethodIL.Emit (OpCodes.Ldarg_0); break;
			case 1: MethodIL.Emit (OpCodes.Ldarg_1); break;
			case 2: MethodIL.Emit (OpCodes.Ldarg_2); break;
			case 3: MethodIL.Emit (OpCodes.Ldarg_3); break;
			default: MethodIL.Emit (OpCodes.Ldarg, n); break;
		}
	}
	
	// Generate access to `n'-th local variable of current feature.
	public void GenerateLocal (int n) {
		MethodIL.Emit (OpCodes.Ldloc, (LocalBuilder) Locals [n - 1]);
	}

/* Assertions */

	// Check if assertions are already being checked,
	// in that case we need to skip the Assertion block.
	public void GenerateInAssertionTest (int EndOfAssertLabel) {
		MethodIL.Emit (OpCodes.Ldsfld, RUNTIME.In_assertion);
		BranchOnTrue (EndOfAssertLabel);
	}

	// Set `in_assertion' flag to True.
	public void GenerateSetAssertionStatus() {
		PutBooleanConstant (true);
		MethodIL.Emit (OpCodes.Stsfld, RUNTIME.In_assertion);
	}

	// Set `in_assertion' flag to False.
	public void GenerateRestoreAssertionStatus() {
		PutBooleanConstant (false);
		MethodIL.Emit (OpCodes.Stsfld, RUNTIME.In_assertion);
	}

	// Raise an assertion violation with `Tag' name when evaluation of
	// assertion yield a False value.
	public void GenerateAssertionCheck (int AssertType, string Tag) {
		Label NewLabel = MethodIL.DefineLabel();
		Type ExceptionType = Classes [Exception_id].Builder;
		Type [] ArrayType = new Type [1] {typeof (string)};

		BranchOnTrue (NewLabel);
		GenerateRestoreAssertionStatus();
		MethodIL.Emit (OpCodes.Ldstr, Tag);
		MethodIL.Emit (OpCodes.Newobj, ExceptionType.GetConstructor (ArrayType));
		MethodIL.Emit (OpCodes.Throw);
		MethodIL.MarkLabel (NewLabel);
	}

	// If evaluation of precondition yield a False value we put on top
	// of IL stack a string that will be used to raise an exception later
	// at the end of preconditions evaluations.
	public void GeneratePreconditionCheck (string Tag, int LabelID) {
		MethodIL.Emit (OpCodes.Ldstr, Tag);
		MethodIL.Emit (OpCodes.Stsfld, RUNTIME.Assertion_tag);
		BranchOnFalse (LabelID);
	}

	public void GeneratePreconditionViolation() {
		Type ExceptionType = Classes [Exception_id].Builder;
		Type [] ArrayType = new Type [1] {typeof (string)};

		GenerateRestoreAssertionStatus();
		MethodIL.Emit (OpCodes.Ldsfld, RUNTIME.Assertion_tag);
		MethodIL.Emit (OpCodes.Newobj, ExceptionType.GetConstructor (ArrayType));
		MethodIL.Emit (OpCodes.Throw);
	}

	// Generate call to invariant routine
	public void GenerateInvariantChecking (int TypeID) {
		CLASS c = Classes[TypeID];
		if (c.InvariantRoutine != null) {
			MethodIL.Emit (OpCodes.Call, (MethodInfo)Classes[TypeID].InvariantRoutine.method_builder);
		}
	}

/* Exception */

	// Start exception block
	public void GenerateStartExceptionBlock(){
		Label label = MethodIL.BeginExceptionBlock();
	}

	// Start rescue clause and store last exception
	public void GenerateStartRescue(){
		MethodIL.BeginCatchBlock (Classes [Exception_id].Builder);
		MethodIL.Emit (OpCodes.Stsfld, RUNTIME.Last_exception);
	}

	// End of rescue clause
	public void GenerateEndExceptionBlock(){
		MethodIL.EndExceptionBlock();
	}

/* Assignments */

	// Generate a check for IsInstance of
	public void GenerateIsInstanceOf (int TypeID)
	{
		MethodIL.Emit (OpCodes.Isinst, Classes [TypeID].Builder);
	}

	// Generate assignment to attribute of `Name' in current class.
	public void GenerateAttributeAssignment (int TypeID, int FeatureID)
	{
		CLASS written_class = Classes [TypeID];

		if (written_class.IsFrozen) {
				// Class is frozen, so we can directly and safely assign
				// to its attribute.
			MethodIL.Emit (OpCodes.Stfld, ((FEATURE) written_class.
				FeatureIDTable [FeatureID]).attribute_builder);
		} else {
				// Assignment is done through a feature call.
			MethodInfo Feature = ((FEATURE) written_class.
					FeatureIDTable [FeatureID]).setter_builder;
			MethodIL.Emit (OpCodes.Callvirt, Feature);
		}
	}
	
	// Generate assignment to `n'-th local variable of current feature.
	public void GenerateLocalAssignment (int n) {
		MethodIL.Emit (OpCodes.Stloc, (LocalBuilder) Locals [n - 1]);
	}
	
	// Generate assignment to result of current feature.
	public void GenerateResultAssignment() {
		MethodIL.Emit (OpCodes.Stloc, Result);
	}

/* Addresses */

	// Generate `ldloca n' instruction
	public void GenerateLocalAddress (int n) {
		MethodIL.Emit (OpCodes.Ldloca, (LocalBuilder) Locals [n - 1]);
	}

	// Generate `ldftn f' or `ldvirtftn f' instruction
	public void GenerateRoutineAddress (int TypeID, int FeatureID) {
		MethodInfo Method = ((FEATURE)Classes [TypeID].
										FeatureIDTable [FeatureID]).method_builder;
		DuplicateTop();
		MethodIL.Emit (OpCodes.Ldvirtftn, Method);
	}

	// Generate `ldloca Result' instruction
 	public void GenerateResultAddress() {
		MethodIL.Emit (OpCodes.Ldloca, Result);
	}

	// Generate `ldarga 0' instruction
	public void GenerateCurrentAddress() {
		MethodIL.Emit (OpCodes.Ldarga, 0);
	}

	// Generate `ldflda attr' instruction
	public void GenerateAttributeAddress (int TypeID, int FeatureID) {
		MethodIL.Emit (OpCodes.Ldflda, ((FEATURE)Classes [TypeID].
			FeatureIDTable [FeatureID]).attribute_builder);
	}

	// Generate `ldarga n' instruction
	public void GenerateArgumentAddress (int n) {
		MethodIL.Emit (OpCodes.Ldarga, n);
	}

	// Generate `ldint.xx' instruction
	public void GenerateLoadFromAddress (int TypeID) {
		if (TypeID == Integer_32_id)
			MethodIL.Emit (OpCodes.Ldind_I4);
		else if (TypeID == Integer_64_id)
			MethodIL.Emit (OpCodes.Ldind_I8);
		else if (TypeID == Integer_16_id)
			MethodIL.Emit (OpCodes.Ldind_I2);
		else if (TypeID == Integer_8_id)
			MethodIL.Emit (OpCodes.Ldind_I1);
		else if (TypeID == Character_id)
			MethodIL.Emit (OpCodes.Ldind_I2);
		else if (TypeID == Boolean_id)
			MethodIL.Emit (OpCodes.Ldind_I1);
		else if (TypeID == Real_id)
			MethodIL.Emit (OpCodes.Ldind_R4);
		else if (TypeID == Double_id)
			MethodIL.Emit (OpCodes.Ldind_R8);
		else if (TypeID == Pointer_id)
			MethodIL.Emit (OpCodes.Ldind_I);
		else
			MethodIL.Emit (OpCodes.Ldobj, Classes [TypeID].Builder);
	}

/* Array Manipulation */

	// Generate call to `item' of ARRAY.
	public void GenerateArrayAccess (int Kind) {
		OpCode op;
		switch (Kind) {
			case Il_i1: op = OpCodes.Ldelem_I1; break;
			case Il_i2: op = OpCodes.Ldelem_I2; break;
			case Il_i4: op = OpCodes.Ldelem_I4; break;
			case Il_i8:
			case Il_u8:
				op = OpCodes.Ldelem_I8;
				break;
			case Il_r4: op = OpCodes.Ldelem_R4; break;
			case Il_r8: op = OpCodes.Ldelem_R8; break;
			case Il_ref: op = OpCodes.Ldelem_Ref; break;
			case Il_i: op = OpCodes.Ldelem_I; break;
			case Il_u1: op = OpCodes.Ldelem_U1; break;
			case Il_u2: op = OpCodes.Ldelem_U2; break;
			case Il_u4: op = OpCodes.Ldelem_U4; break;
			default:
				op = OpCodes.Nop;
				break;
		}
		MethodIL.Emit (op);
	}

	// Generate call to `put' of ARRAY.
	public void GenerateArrayWrite (int Kind) {
		OpCode op;
		switch (Kind) {
			case Il_i1:
			case Il_u1:
				op = OpCodes.Stelem_I1;
				break;
			case Il_i2:
			case Il_u2:
				op = OpCodes.Stelem_I2;
				break;
			case Il_i4:
			case Il_u4:
				op = OpCodes.Stelem_I4;
				break;
			case Il_i8:
			case Il_u8:
				op = OpCodes.Stelem_I8;
				break;
			case Il_r4: op = OpCodes.Stelem_R4; break;
			case Il_r8: op = OpCodes.Stelem_R8; break;
			case Il_ref: op = OpCodes.Stelem_Ref; break;
			case Il_i: op = OpCodes.Stelem_I; break;
			default:
				op = OpCodes.Nop;
				break;
		}
		MethodIL.Emit (op);
	}

	// Create a new array.
	public void GenerateArrayCreation (int TypeID) {
		MethodIL.Emit (OpCodes.Newarr, Classes [TypeID].Builder);
	}
	
/* Generate return statements */

	public void GenerateReturn() {
		MethodIL.Emit (OpCodes.Ret);		
	}
	
/* Onces */

	public void GenerateOnceDoneInfo (string name) {
		FieldAttributes AttributeAttributes;

		AttributeAttributes = FieldAttributes.Private | FieldAttributes.Static;

		DoneBuilder = ((TypeBuilder)Classes [CurrentTypeID].Builder).
			DefineField (name + "Done", Classes [Boolean_id].Builder, AttributeAttributes);
	}

	public void GenerateOnceResultInfo (string name, int TypeID) {
		FieldAttributes AttributeAttributes;

		AttributeAttributes = FieldAttributes.Private | FieldAttributes.Static;

		ResultBuilder = ((TypeBuilder)Classes [CurrentTypeID].Builder).
			DefineField (name + "Result", Classes [TypeID].Builder, AttributeAttributes);
	}

	public void generate_once_computed () {
		PutBooleanConstant (true);
		MethodIL.Emit (OpCodes.Stsfld, DoneBuilder);
	}

	public void GenerateOnceTest() {
		MethodIL.Emit (OpCodes.Ldsfld, DoneBuilder);
	}

	public void generate_once_result_address ()
		// Load address of static variable holding value of `Result'.
	{
		MethodIL.Emit (OpCodes.Ldsflda, ResultBuilder);
	}

	public void GenerateOnceResult() {
		MethodIL.Emit (OpCodes.Ldsfld, ResultBuilder);
	}

	public void GenerateOnceStoreResult() {
		MethodIL.Emit (OpCodes.Stsfld, ResultBuilder);
	}

/* Arrays */

	public void GenerateArrayLower() {
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Call, GetLowerBound);
	}
	
	public void GenerateArrayUpper() {
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Call, GetUpperBound);
	}
	
	public void GenerateArrayCount() {
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Call, GetLength);
	}
	
/* Constants generation */

	// Put `void' on IL stack.
	public void PutVoid() {
		MethodIL.Emit (OpCodes.Ldnull);
	}
	
	// Put `s' on IL stack.
	public void PutManifestString (string s) {
		MethodIL.Emit (OpCodes.Ldstr, s);
	}

	// Put `i' on IL stack.
	public void PutInteger8Constant (Int32 i) {
		MethodIL.Emit (OpCodes.Ldc_I4, i);
	}

	// Put `i' on IL stack.
	public void PutInteger16Constant (Int32 i) {
		MethodIL.Emit (OpCodes.Ldc_I4, i);
	}
	
	// Put `i' on IL stack.
	public void PutInteger32Constant (Int32 i ) {
		MethodIL.Emit (OpCodes.Ldc_I4, i);
	}

	// Put `i' on IL stack.
	public void PutInteger64Constant (long i ) {
		MethodIL.Emit (OpCodes.Ldc_I8, i);
	}

		// Put `d' on IL stack.
	public void PutRealConstant (double d) {
		MethodIL.Emit (OpCodes.Ldc_R4, (float) d);
	}

	// Put `d' on IL stack.
	public void PutDoubleConstant (double d) {
		MethodIL.Emit (OpCodes.Ldc_R8, d);
	}

	// Put `c' on IL stack.
	public void PutCharacterConstant (char c) {
		MethodIL.Emit (OpCodes.Ldc_I4, c);
	}

	// Put `b' on IL stack.
	public void PutBooleanConstant (bool b) {
		if (b)
		 	MethodIL.Emit (OpCodes.Ldc_I4, 1);
		else
		 	MethodIL.Emit (OpCodes.Ldc_I4, 0);
	}

/* Labels and branching */

	// Generate a branch instruction to `label' if top of
	// IL stack True.
	public void BranchOnTrue (int label) {
		MethodIL.Emit (OpCodes.Brtrue, (Label)Labels [label]);
	}
	private void BranchOnTrue ( Label label) {
		MethodIL.Emit (OpCodes.Brtrue, label);
	}

	// Generate a branch instruction to `label' if top of
	// IL stack False.
	public void BranchOnFalse (int label) {
		MethodIL.Emit (OpCodes.Brfalse, (Label)Labels [label]);
	}

	// Generate a branch instruction to `label'.
	public void BranchTo (int label) {
		MethodIL.Emit (OpCodes.Br, (Label)Labels [label]);
	}

	// Mark a portion of code with `label'.
	public void MarkLabel (int label) {
		MethodIL.MarkLabel ((Label)Labels [label]);
	}

/* Binary Operator generation */

	// Generate `<' operator.
	public void GenerateLt() {
		MethodIL.Emit (OpCodes.Clt);
	}

	// Generate `<=' operator.
	public void GenerateLe() {
		MethodIL.Emit (OpCodes.Cgt);
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}
	
	// Generate `>' operator.
	public void GenerateGt() {
		MethodIL.Emit (OpCodes.Cgt);
	}		

	// Generate `>=' operator.
	public void GenerateGe() {
		MethodIL.Emit (OpCodes.Clt);
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}
	
	// Generate `*' operator.
	public void GenerateStar() {
		MethodIL.Emit (OpCodes.Mul);
	}

	// Generate `^' operator.
	public void GeneratePower() {
		if (PowerInfo == null) {
			Type[] PowerArgumentsTypes;
			Type Float64 = Type.GetType ("System.Double");
			PowerArgumentsTypes = new Type[]{ Float64, Float64 };
			PowerInfo = SystemMath.GetMethod ("Pow", PowerArgumentsTypes);
		}
		MethodIL.Emit (OpCodes.Call, PowerInfo);
	}

	// Generate `min' operation on basic types.
	public void GenerateMin (int TypeID) {
		Type element_type = Classes [TypeID].Builder;
		Type[] MinTypes = new Type [] {element_type, element_type};
		
		MethodIL.Emit (OpCodes.Call, SystemMath.GetMethod ("Min", MinTypes));
	}

	// Generate `max' operation on basic types.
	public void GenerateMax (int TypeID) {
		Type element_type = Classes [TypeID].Builder;
		Type[] MaxTypes = new Type [] {element_type, element_type};
		
		MethodIL.Emit (OpCodes.Call, SystemMath.GetMethod ("Max", MaxTypes));
	}

	// Generate `max' operation on basic types.
	public void GenerateAbs (int TypeID) {
		Type[] AbsTypes = new Type [] {Classes [TypeID].Builder};
		
		MethodIL.Emit (OpCodes.Call, SystemMath.GetMethod ("Abs", AbsTypes));
	}

	// Generate `min' operation on basic types.
	public void GenerateToString () {
		MethodIL.Emit (OpCodes.Callvirt, ObjectType.GetMethod ("ToString"));
	}

	// Generate `+' operator.
	public void GeneratePlus() {
		MethodIL.Emit (OpCodes.Add);
	}

	// Generate `\\' operator.
	public void GenerateMod() {
		MethodIL.Emit (OpCodes.Rem);
	}

	// Generate `-' operator.
	public void GenerateMinus() {
		MethodIL.Emit (OpCodes.Sub);
	}

	// Generate `/' operator.
	public void GenerateDiv() {
		MethodIL.Emit (OpCodes.Div);
	}

	// Generate `xor' operator.
	public void GenerateXor() {
		MethodIL.Emit (OpCodes.Xor);
	}

	// Generate `or' operator.
	public void GenerateOr() {
		MethodIL.Emit (OpCodes.Or);
	}

	// Generate `and' operator.
	public void GenerateAnd() {
		MethodIL.Emit (OpCodes.And);
	}

	// Generate `implies operator.
	public void GenerateImplies() {
	}

	// Generate `=' operator.
	public void GenerateEq() {
		MethodIL.Emit (OpCodes.Ceq);
	}

	// Generate `<<' operator.
	public void GenerateShl() {
		MethodIL.Emit (OpCodes.Shl);
	}

	// Generate `>>' operator.
	public void GenerateShr() {
		MethodIL.Emit (OpCodes.Shr);
	}

	// Generate `/=' operator.
	public void GenerateNe() {
		MethodIL.Emit (OpCodes.Ceq);
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}

/* Unary operator generation */

	// Generate '-' operator.
	public void GenerateUMinus() {
		MethodIL.Emit (OpCodes.Neg);
	}

	// Generate 'not' operator.
	public void GenerateNot() {
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}

	// Generate bitwise not operator.
	public void GenerateBitwiseNot () {
		MethodIL.Emit (OpCodes.Not);
	}

/* Line info */

	public void put_line_info (int line_number, int start_column, int end_column)
		// Generate debug information to enable to find corresponding
		// Eiffel class file in IL code.
	{
		MethodIL.MarkSequencePoint (
			Classes [CurrentTypeID].Document,
			line_number, start_column,
			line_number, end_column);
	}

/* Labels creation */

	// Create a new label and return corresponding index.
	public int CreateLabel() {
		Label NewLabel = MethodIL.DefineLabel();
		Labels.Add (NewLabel);
		return Labels.Count - 1;
	}

/* Generate the ISE run-time class */

	private void PrepareISERuntime() {
		RUNTIME.prepare ();
		ExternalAssemblies.Add (RUNTIME.Ise_runtime_assembly);
	}

/* Perform Type lookup */

	private Type TypeFromName (string TypeName) {
			// Search current assembly and mscorlib
		Type ExternalType = Type.GetType (TypeName, false, false);
		if (ExternalType == null) {
				// Search in referenced assemblies
			foreach (Assembly assembly in ExternalAssemblies) {
				ExternalType = assembly.GetType (TypeName);
				if (ExternalType != null)
					return ExternalType;
			}
		}
		return ExternalType;
	}

/* Code generation switch between generation of interfaces and implementation */
	public void SetForInterfaces () {
	}

	public void SetForImplementations () {
	}

	private void CleanUp () {
		Classes = null;
		assembly = null;
		main_module = null;
		ExternalAssemblies = null;
		MethodIL = null;
		Labels = null;
		CurrentMethod = null;
		Locals = null;
		Result = null;
		Ca_factory = null;
		FileName = null;
		LastException = null;
	}

/*
feature {NONE} -- Implementation
*/
	private void internal_generate_type_class_mapping (Type type, int type_id)
		// Generate mapping between `type' and `type_id'.
	{
		CLASS eiffel_class = new CLASS ();
		Classes [type_id] = eiffel_class;
		eiffel_class.set_name (type.Name);
		eiffel_class.SetTypeID (type_id);
		eiffel_class.SetInterfaceID (type_id);
		eiffel_class.SetIsInterface(true);
		eiffel_class.SetIsExternal (true);
		eiffel_class.SetTypeBuilder (type);
	}

	internal const int Il_i1 = 30;
	internal const int Il_i2 = 31;
	internal const int Il_i4 = 32;
	internal const int Il_i8 = 33;
	internal const int Il_r4 = 34;
	internal const int Il_r8 = 35;
	internal const int Il_ref = 36;
	internal const int Il_i = 37;
	internal const int Il_u1 = 38;
	internal const int Il_u2 = 39;
	internal const int Il_u4 = 40;
	internal const int Il_u8 = 41;
		// Constants used to generate proper opcode for Array access.

	internal const int Normal_type = 1;
	internal const int Creator_type = 2;
	internal const int Field_type = 3;
	internal const int Static_field_type = 4;
	internal const int Set_field_type = 5;
	internal const int Set_static_field_type = 6;
	internal const int Static_type = 7;
	internal const int Get_property_type = 8;
	internal const int Set_property_type = 9;
	internal const int Deferred_type = 10;
	internal const int Operator_type = 11;
	internal const int Creator_call_type = 12;
	internal const int Enum_field_type = 13;
		// Constants used to find type of .NET feature being called.

/*
feature -- Private
*/
	
	// Custom attributes factory
	private CA_FACTORY Ca_factory;
	
	// Referenced assemblies
	private System.Collections.ArrayList ExternalAssemblies;

	// Built assembly
	private AssemblyBuilder assembly;
	
	// Main module being built
	private ModuleBuilder main_module;

	// Current module used for code generation
	private ModuleBuilder module = null;

	// Number of classes per module
	private const int Nb_classes_per_module = 50;
	private int nb_classes_generated = 0;
	
	// Current Method IL Generator
	private ILGenerator MethodIL;
	
	// Labels used in current method
	private System.Collections.ArrayList Labels;
	
	// Currently build method
	private FEATURE CurrentMethod;

	// List of local variables builders
	private System.Collections.ArrayList Locals;
	
	// Currently generated feature result
	private LocalBuilder Result;
	
	// MethodInfo for Power of System.Math
	private MethodInfo PowerInfo;
	private MethodInfo MemberwiseCloneMethod;
	
	// FileName for generated exe
	private string FileName;
	
	// ISE Once function management
	private FieldInfo DoneBuilder;
	private FieldInfo ResultBuilder;

	// Is generated application a console application, a window application or a dll?
	private PEFileKinds application_kind;
	private AssemblyName assembly_name;

/*
feature -- Statics
*/
	internal static Guid Language_guid = new Guid ("6805C61E-8195-490c-87EE-A713301A670C");
	internal static Guid Language_vendor_guid = new Guid ("B68AF30E-9424-485f-8264-D4A726C162E7");
	internal static Guid Document_type_guid = Guid.Empty;
		// Guids used for generation of debug information.

	// Current mapped class
	internal static int CurrentTypeID;

	// Position of argument declared through `add_argument'.
	private static int arg_pos;

	// Predefined class type ids
	private static int Object_id, Pointer_id, Integer_32_id, Boolean_id,
		Character_id, Double_id, Real_id, Integer_8_id, Integer_16_id,
		Integer_64_id, Exception_id;

	internal static int Any_id;
		// Id of ANY interface.

	// Key pair filename extension
	private static string Key_filename_extension = ".snk";
	
	// Initial values for IDs
	internal const int No_value = -1;

	// Eiffel classes to be generated
	internal static CLASS[] Classes;

	// System.Object Type
	internal static Type ObjectType = Type.GetType( "System.Object" );

	// System.Math type for power operation
	private static Type SystemMath = Type.GetType ("System.Math");
	
	// Void Type
	internal static Type VoidType = Type.GetType( "void" );

	// Eiffel `Result' keyword
	internal static String ResultName = "Result";

	// Log debug information
	internal static void Log( String text )
	{
		FileStream fs = new FileStream("log.txt", FileMode.Append, FileAccess.Write);
		StreamWriter s = new StreamWriter( fs );
		s.WriteLine(text);
 		s.Close();
	}

	// Delete Log file
	internal static void DeleteLog () {
		File.Delete ("log.txt");
	}

	// Log exception
	internal static void LogError( Exception error )
	{
		#if DEBUG
			Log( error.ToString());
		#endif
		LastException = error;
		throw error;
	}

	// Log exception with additional info
	internal static void LogError( Exception error, String Info )
	{
		#if DEBUG
			Log( error.ToString());
			Log( Info );
		#endif
		LastException = error;
 		throw error;
	}

	// Name of type with entry point
	internal static String EntryTypeName = "_STARTUP";

	// Name of entry point
	internal static String Entry_point_name = "Main";

	// Lower Bound of arrays
	internal static System.Reflection.MethodInfo GetLowerBound = Type.GetType( "System.Array" ).GetMethod( "GetLowerBound" );

	// Upper Bound of arrays
	internal static System.Reflection.MethodInfo GetUpperBound = Type.GetType( "System.Array" ).GetMethod( "GetUpperBound" );

	// Element count of arrays
	internal static System.Reflection.MethodInfo GetLength = Type.GetType( "System.Array" ).GetMethod( "GetLength" );

	//Web Method Attribute
	internal static System.Web.Services.WebMethodAttribute WebMethodAttribute = new System.Web.Services.WebMethodAttribute();

	// Prefix for override functions used to emulate renaming/covariance
	internal static String Override_prefix = "__";
	internal static String Setter_prefix = "_set_";
	
	// Last exception
	internal static Exception LastException = null;

	// Internal counter for MethodImpl
	private static int counter = 0;

	// Last created Eiffel type
	private static CLASS LastCreatedClass = null;

	// Name of DLL containing C externals.
	public static string dll_name;
	public static string dll_prefix;

/*
feature -- Access
*/
	internal static bool is_debugging_enabled = false;
		// Is current generation including debug information?

	internal static bool is_verifiable = true;
		// Is current code generation verifiable?
	
	internal static bool is_cls_compliant = true;
		// Is current code generation cls compliant?

} // end of COMPILER

} // end of namespace
