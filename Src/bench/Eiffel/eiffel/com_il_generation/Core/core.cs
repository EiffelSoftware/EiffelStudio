using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
// Used to access the Debugger class
//using System.Diagnostics;
using System.Runtime.InteropServices;

[ClassInterfaceAttribute (ClassInterfaceType.None)]
public class Core : ICore
{
	// Set console application generation
	public void SetConsoleApplication()
	{
		ApplicationKind = PEFileKinds.ConsoleApplication;
	}

	// Set window application generation
	public void SetWindowApplication()
	{
		ApplicationKind = PEFileKinds.WindowApplication;
	}

	// Set dll generation
	public void SetDll()
	{
		ApplicationKind = PEFileKinds.Dll;
	}

	// Create Assembly with name `Name'.
	public void StartAssemblyGeneration (string Name, string FName,  string Location)
	{
		#if DEBUG
			Globals.DeleteLog();
			Globals.Log ("StartAssemblyGeneration" + " (" + Name + ", " + FName + ", " + Location + ")");
		#endif
		try
		{
			AppDomain curAppDomain = System.Threading.Thread.GetDomain();
			if (curAppDomain == null)
				throw new ApplicationException ("Null current application domain");
			AssemblyName assemblyName = new AssemblyName();
			assemblyName.Name = Name;
			FileStream fs = new FileStream (Location + "\\" + Name + Key_filename_extension, FileMode.Open);
			assemblyName.KeyPair = new StrongNameKeyPair (fs);
			fs.Close();
			FileName = FName ;
			assembly = curAppDomain.DefineDynamicAssembly (assemblyName, AssemblyBuilderAccess.Save, Location);
			assembly.SetCustomAttribute (new CustomAttributeBuilder (typeof (System.CLSCompliantAttribute).GetConstructor (new Type[] {typeof (bool)}), new object[] {true}));

			ExternalAssemblies = new System.Collections.ArrayList();
			
			CAFactory = new CustomAttributesFactory();

			// Initialize access to ISE Runtime Classes
			PrepareISERuntime();
		}
		catch (Exception error)
		{
			Globals.LogError (error);
	}
		}

	// Load external assembly
	public void AddAssemblyReference (string Name)
	{
		#if DEBUG
			Globals.Log ("AddAssemblyReference" + " (" + Name + ")");
		#endif
		try
		{
			ExternalAssemblies.Add (Assembly.LoadFrom (Name));
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Create Module with name `Name' within current assembly.
	public void StartModuleGeneration (string Name, bool Debug)
	{
		#if DEBUG
			Globals.Log ("StartModuleGeneration" + " (" + Name + ", " + Debug + ")");
		#endif
		try
		{
			DebugMode = Debug;
			module = assembly.DefineDynamicModule (Name, Name, Debug);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
		
	// Finish creation of current assembly.
	// `CreateAssembly' should have been called before.
	public void EndAssemblyGeneration()
	{
		#if DEBUG
			Globals.Log ("EndAssemblyGeneration");
		#endif
		try
		{
			assembly.Save (FileName);
			Globals.LastException = new ApplicationException ("No Error.");
			Globals.ClassTable = null;
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
		
	// Finish creation of current module.
	// `CreateModule' should have been called before.
	public void EndModuleGeneration()
	{
	}

/* Class info */

	// Set number of classes to generate
	public void StartClassMappings (int ClassCount)
	{
		#if DEBUG
			Globals.Log ("StartClassMappings" + " (" + ClassCount + ")");
		#endif
		try
		{
			Globals.ClassTable = new EiffelClass [ClassCount + 1];
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Generate a class map between name and TypeID
	public void GenerateClassMappings (string ClassName, int TypeID, string SourceFileName)
	{
		#if DEBUG
			Globals.Log ("Class " + TypeID + ": " + ClassName);
		#endif
		try
		{
			if (ClassName == Globals.AnyName)
				Globals.AnyID = TypeID;
			Globals.ClassTable [TypeID] = new EiffelClass (module);
			Globals.ClassTable [TypeID].SetName (ClassName);
			Globals.ClassTable [TypeID].SetTypeID (TypeID);
			if (DebugMode)
				Globals.ClassTable [TypeID].SetDocument (module.DefineDocument (SourceFileName, System.Guid.Empty, System.Guid.Empty, System.Guid.Empty));
		}
		catch (Exception error)
		{
			Globals.LogError (error, "For class " +  ClassName + " with TypeID " + TypeID + " and source file " + SourceFileName);
		}
	}

	// Generate an array class map between name and TypeID
	public void GenerateArrayClassMappings (string ClassName, string ElementTypeName, int TypeID)
	{
		#if DEBUG
			Globals.Log ("GenerateArrayClassMappings ("+ ClassName + ", " + ElementTypeName + ", " + TypeID + ")");
		#endif
		try
		{
			Globals.ClassTable [TypeID] = new EiffelClass (module);
			Globals.ClassTable [TypeID].SetName (ClassName);
			Globals.ClassTable [TypeID].SetTypeID (TypeID);
			Globals.ClassTable [TypeID].SetIsArray();
			Globals.ClassTable [TypeID].SetArrayElementName (ElementTypeName);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Position of argument declared through `AddArgument'.
	static int arg_pos;

	// Int32 type id
	static int Int32ID;

	// Boolean type id
	static int BooleanID;

	// Char type id
	static int CharID;

	// Double type id
	static int DoubleID;

	// Single type id
	static int SingleID;

	// Byte type id
	static int ByteID;

	// Int16 type id
	static int Int16ID;

	// Int64 type id
	static int Int64ID;
	
	// Generate class name and its specifier.
	public void GenerateClassHeader (Boolean IsInterface, Boolean Deferred, Boolean Expanded, Boolean IsExternal, int TypeID)
	{
		Type ExternalType;
		#if DEBUG
			Globals.Log ("GenerateClassHeader ("+ IsInterface + ", " + Deferred + ", " + Expanded + ", " + IsExternal + ", " + TypeID + ")");
		#endif
		
		try
		{
			if (IsExternal)
			{
				switch (Globals.ClassTable [TypeID].Name)
				{
					case "System.Int32": Int32ID = TypeID; break;
					case "System.Int64": Int64ID = TypeID; break;
					case "System.Int16": Int16ID = TypeID; break;
					case "System.Byte": ByteID = TypeID; break;
					case "System.Single": SingleID = TypeID; break;
					case "System.Doube": DoubleID = TypeID; break;
					case "System.Char": CharID = TypeID; break;
					case "System.Boolean": BooleanID = TypeID; break;
					default: break;
				}
				ExternalType = TypeFromName (Globals.ClassTable [TypeID].Name);
				if (ExternalType == null)
					throw (new ApplicationException ("Could not find type " + Globals.ClassTable [TypeID].Name));
				if (ExternalType.IsAbstract)
					Globals.ClassTable [TypeID].SetDeferred();
				if (ExternalType.IsInterface)
					Globals.ClassTable [TypeID].SetInterface();
				if (ExternalType.IsValueType)
					Globals.ClassTable [TypeID].SetExpanded();
				Globals.ClassTable [TypeID].SetExternal();
				Globals.ClassTable [TypeID].SetTypeBuilder (ExternalType);
				if (!Globals.ClassTable [TypeID].IsArray)
					Globals.ClassTable [TypeID].SetDefaultConstructor (
						ExternalType.GetConstructor (
							BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance,
							null, Type.EmptyTypes, null));
			}
			else
			{
				if (Deferred)
					Globals.ClassTable [TypeID].SetDeferred();
				if (IsInterface)
					Globals.ClassTable [TypeID].SetInterface();
				if (Expanded)
					Globals.ClassTable [TypeID].SetExpanded();
			}
			CurrentTypeID = TypeID;
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Bake .NET type
	public void EndClass()
	{
		#if DEBUG
			Globals.Log ("EndClass");
		#endif
		try
		{
			#if (DEBUG)
				Globals.Log ("Full Name: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).FullName);
				Globals.Log ("Base type: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).BaseType);
				Globals.Log ("Declaring type: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).DeclaringType);
				Globals.Log ("Name: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).Name);
				Globals.Log ("Reflected type: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).ReflectedType);
				Globals.Log ("Size: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).Size);
				Type[] types = ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).GetInterfaces();
				for (int i =  0; i < types.Length; i++)
				{
					Globals.Log ("Interface " + i + ": " + types [i]);
				}
				Globals.Log ("Attributes: " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).Attributes.ToString());
				Globals.Log ("Is abstract? : " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).IsAbstract);
				Globals.Log ("Is public? : " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).IsPublic);
			#endif
			 ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).CreateType();
		}
		catch (Exception error)
		{
			Globals.LogError (error, "In class " + ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder));
		}
	}

	// Add class with id `TypeID' into list of parents of current type.
	// `StartParentsLt' should have been called before.
	public void AddToParentsList (int TypeID)
	{
		#if DEBUG
			Globals.Log ("AddToParentsList" + " (" + TypeID + ")");
		#endif
		try
		{
			if (!Globals.ClassTable [CurrentTypeID].IsInterface || Globals.ClassTable [TypeID].IsInterface)
				Globals.ClassTable [CurrentTypeID].AddParent (TypeID);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Finish inheritance part description
	// `StartParentsList' should have been called before.
	public void EndParentsList()
	{
		#if DEBUG
			Globals.Log ("EndParentsList");
		#endif
		try
		{
			if (!Globals.ClassTable [CurrentTypeID].IsInterface && Globals.ClassTable [CurrentTypeID].BaseType == Globals.NoValue)
				Globals.ClassTable [CurrentTypeID].AddParent (Globals.AnyID);
			Globals.ClassTable [CurrentTypeID].CreateTypeBuilder();
		}
		catch (Exception error)
		{
			Globals.LogError (error,  "In class " + Globals.ClassTable [CurrentTypeID].Name + " with parent " + Globals.ClassTable [CurrentTypeID].BaseType);
		}
	}

/* Features info */

	// Start enumeration of features written in class with TypeID `TypeID'.
	public void StartFeaturesList (int TypeID)
	{
		#if DEBUG
			Globals.Log ("StartFeaturesList (" + TypeID+ ")");
		#endif
		try
		{
			CurrentFeatureIDTable = new System.Collections.Hashtable();
			CurrentRoutIDTable = new System.Collections.Hashtable();
			CurrentTypeID = TypeID;
			Globals.ClassTable [CurrentTypeID].SetFeatureIDTable (CurrentFeatureIDTable);
			Globals.ClassTable [CurrentTypeID].SetRoutIDTable (CurrentRoutIDTable);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Finish enumeration of features written in current class.
	public void EndFeaturesList()
	{
		#if DEBUG
			Globals.Log ("EndFeaturesList");
		#endif
		try
		{
		}
		catch (Exception error)
		{
			Globals.LogError (error, "For class " + Globals.ClassTable [CurrentTypeID].Name);
		}
	}

	// Mark the invariant routine
	public void MarkInvariant (int FeatureID)
	{
		#if DEBUG
			Globals.Log ("MarkInvariant (" + FeatureID+ ")");
		#endif
		try
		{
			Globals.ClassTable[CurrentTypeID].SetInvariant (FeatureID);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Mark the invariant routine
	public void MarkCreationRoutines (int[] FeatureIDs)
	{
		try
		{
			Globals.ClassTable[CurrentTypeID].SetCreationRoutines (FeatureIDs);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Start enumeration of features written in current class.
	public void StartFeatureDescription (int arg_count)
	{
		try
		{
			CurrentMethod = new EiffelMethod (CurrentTypeID, arg_count);
			arg_pos = 0;
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Generate info about current feature.
	public void GenerateFeatureNature (Boolean Redefined, Boolean Deferred, Boolean Frozen, Boolean IsAttribute)
	{
		#if DEBUG
			Globals.Log ("GenerateFeatureNature (" + Redefined + ", " + Deferred + ", " + Frozen + ", " + IsAttribute + ")");
		#endif
		try
		{
			if (Redefined)
				CurrentMethod.SetRedefined();
			if (Deferred)
				CurrentMethod.SetDeferred();
			if (Frozen)
				CurrentMethod.SetFrozen();
			if (IsAttribute)
				CurrentMethod.SetIsAttribute();
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	
	// Generate info about current feature.
	// Called for both features generated in Current type and parent types
	public void GenerateFeatureIdentification (string Name, int FeatureID, int[] RoutineIDs, Boolean InCurrentClass, int WrittenTypeID)
	{
		int RoutineID = RoutineIDs [0];
		#if DEBUG
			Globals.Log ("GenerateFeatureIdentification (" + Name + ", " + FeatureID + ", " + RoutineID + ", " + InCurrentClass + ", " + WrittenTypeID + ")");
		#endif
		EiffelMethod Method;
		try
		{
					
			if (WrittenTypeID != CurrentTypeID)
			{
				bool found = false;
				int i = 0, nb = RoutineIDs.Length;

				for (; (i < nb)&& !found; i++){
					found = Globals.ClassTable [WrittenTypeID].RoutIDTable.ContainsKey (RoutineIDs [i]);
				}
				if (!found)
				{
						// Method is inherited but the Eiffel compiler gave a new RoutineID
						// due to a select clause which give to the non-selected feature
						// a new RoutineID. Therefore the CurrentMethod is seen as if it
						// had been written in CurrentTypeID.
						//
						// class A feature f is deferred end end
						// class B inherit A feature f is do end end
						// class C inherit B A rename f as g select g end feature g is do end end
						//
						// In this example the B.f routine gets a new RoutineID in C because
						// C.g get the RoutineID from A.f.

					CurrentMethod.SetFeatureID (FeatureID);
					CurrentMethod.SetRoutineID (RoutineID);
					CurrentFeatureIDTable.Add (FeatureID, CurrentMethod);
					CurrentRoutIDTable.Add (RoutineID, CurrentMethod);
					CurrentMethod.SetEiffelName (Name);
				} else {
						// Retrieve parent method's routine id
					int parent_routine_id = RoutineIDs [i - 1];
					Method = (EiffelMethod)Globals.ClassTable[ WrittenTypeID ].RoutIDTable [parent_routine_id];
					if (Globals.ClassTable[ WrittenTypeID ].IsExternal)
						Method = new EiffelMethod (Method, FeatureID, RoutineID);
					else
						Method = new EiffelMethod (Method, Name, FeatureID, RoutineID);
					CurrentFeatureIDTable.Add (FeatureID, Method);
					CurrentRoutIDTable.Add (RoutineID, Method);
					CurrentMethod = Method;
				}
			}
			else
			{
				CurrentMethod.SetFeatureID (FeatureID);
				CurrentMethod.SetRoutineID (RoutineID);
				CurrentFeatureIDTable.Add (FeatureID, CurrentMethod);
				CurrentRoutIDTable.Add (RoutineID, CurrentMethod);

				if (!CurrentMethod.IsRedefined){
					CurrentMethod.SetEiffelName (Name);
				} else {
					EiffelClass CurrentClass = (EiffelClass)Globals.ClassTable [CurrentTypeID];
					bool Found = false;
					EiffelClass ParentClass = null;
					if (!CurrentClass.IsInterface)
					{
						ParentClass = (EiffelClass)Globals.ClassTable [CurrentClass.BaseType];
						Found = ParentClass.RoutIDTable.ContainsKey (CurrentMethod.RoutineID);
					}
					int i = 0;

					while (!Found && (i < CurrentClass.Interfaces.Count)){
						ParentClass = (EiffelClass)Globals.ClassTable [ (int)CurrentClass.Interfaces [i]];
						Found = ParentClass.RoutIDTable.ContainsKey (CurrentMethod.RoutineID);
						i++;
					}
				
					if (Found){
							// There is an ancestor feature
						EiffelMethod ParentMethod = (EiffelMethod)ParentClass.RoutIDTable [CurrentMethod.RoutineID];
						if (ParentClass.IsExternal){
							CurrentMethod.SetRealName (ParentMethod.RealName);
						}
						CurrentMethod.SetEiffelName (Name);
						if  (CurrentMethod.IsAttribute) {
								// We are redefining an attribute, we need to find the
								// original AttributeBuilder since we are not generating
								// a new attribute
							Method = (EiffelMethod)ParentClass.RoutIDTable [CurrentMethod.RoutineID];
							CurrentMethod.SetAttributeBuilder  (Method.AttributeBuilder);
						}
					} else {
						throw new ApplicationException ("A redefined feature always has a parent feature.");
					}
				}
				
			}

		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Generate info about external feature.
	public void GenerateExternalIdentification (string Name, string ComName, int ExternalKind, int FeatureID, int RoutineID, Boolean InCurrentClass, int WrittenTypeID, string[] Parameters, string ReturnType)
	{
		Type[] ParameterTypes;
		MethodInfo Result = null;
		FieldInfo Field;
		ConstructorInfo Constructor;
		Type ParameterType;
		MethodInfo[] Methods;
		ParameterInfo[] ParameterInfos;
		bool Found;
		try
		{
			if (WrittenTypeID != CurrentTypeID)
				throw new ApplicationException ("GenerateExternalIdentification: WrittenTypeID is same as CurrentTypeID");
			else
			{
				CurrentMethod.SetRealName (ComName);
				CurrentMethod.SetEiffelName (Name);
				CurrentMethod.SetFeatureID (FeatureID);
				CurrentMethod.SetRoutineID (RoutineID);
				if (ExternalKind == Globals.OperatorKind)
				{
					ParameterTypes = new Type [Parameters.Length + 1];
					ParameterTypes [0] = ((EiffelClass)Globals.ClassTable[ CurrentTypeID ]).Builder;
					if (Parameters.Length > 0)
						ParameterTypes [1] = TypeFromName (Parameters [0]);
					Methods = Globals.ClassTable [CurrentTypeID].Builder.GetMethods (BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
					foreach (MethodInfo Method in Methods)
					{
						if ((Method.Name == ComName)&& (Method.ReturnType.FullName == ReturnType))
						{
							ParameterInfos = Method.GetParameters();
							Found = true;
							for (int i = 0; (i < ParameterInfos.Length)&& (i < Parameters.Length)&&Found; i++)
								Found = (ParameterInfos [i].ParameterType == ParameterTypes [i]);
							if (Found)
							{
								Result = Method;
								break;
							}
						}
					}		
					if (Result == null)
						throw new ApplicationException ("GenerateExternalIdentification: Operator " + ComName + " not found in " + Globals.ClassTable [CurrentTypeID].Name); 
					CurrentMethod.SetMethodBuilder (Result);
				}
				else
				{
					if ((ExternalKind == Globals.StaticMethodKind)|| (ExternalKind == Globals.MethodKind)|| (ExternalKind == Globals.DeferredMethodKind))
					{
						ParameterTypes = new Type [Parameters.Length];
						for (int i = 0; i < Parameters.Length; i++)
						{
							ParameterType = TypeFromName (Parameters [i]);
							if (ParameterType == null)
								throw new ApplicationException ("GenerateExternalIdentification: Could not find type of " + Parameters [i]);
							ParameterTypes [i] = ParameterType;
						}
	// FIXEME: Temporary hack until we have access to MethodImpl, we check all the methods until we find the right one
	// Method = Globals.ClassTable [CurrentTypeID].Builder.GetMethod (ComName, ParameterTypes);
						Methods = Globals.ClassTable [CurrentTypeID].Builder.GetMethods (BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
						foreach (MethodInfo Method in Methods)
						{
							if ((Method.Name == ComName)&& (Method.ReturnType.FullName == ReturnType)&& (Method.GetParameters().Length == Parameters.Length))
							{
								ParameterInfos = Method.GetParameters();
								Found = true;
								for (int i = 0; (i < ParameterInfos.Length)&&Found; i++)
									Found = (ParameterInfos [i].ParameterType == ParameterTypes [i]);
								if (Found)
								{
									Result = Method;
									break;
								}
							}
						}		
						if (Result == null)
							throw new ApplicationException ("GenerateExternalIdentification: Method " + ComName + " not found in " + Globals.ClassTable [CurrentTypeID].Name); 
						CurrentMethod.SetMethodBuilder (Result);
					}
					else
					{
						if ((ExternalKind == Globals.StaticFieldAccessKind)|| (ExternalKind == Globals.FieldAccessKind))
							{
								Field = Globals.ClassTable [CurrentTypeID].Builder.GetField (ComName);
								if (Field == null)
									throw new ApplicationException ("GenerateExternalIdentification: Field " + ComName + " not found in " + Globals.ClassTable [CurrentTypeID].Name); 
								CurrentMethod.SetAttributeBuilder (Field);
								CurrentMethod.SetIsAttribute();
							}
						else
						{
							if (ExternalKind == Globals.CreatorKind)
							{
								ParameterTypes = new Type [Parameters.Length];
								for (int i = 0; i < Parameters.Length; i++)
								{
									ParameterType = TypeFromName (Parameters [i]);
									if (ParameterType == null)
										throw new ApplicationException ("GenerateExternalIdentification: Could not find type of " + Parameters [i]);
									ParameterTypes [i] = ParameterType;
								}
								Constructor = Globals.ClassTable [CurrentTypeID].Builder.GetConstructor (ParameterTypes);
								if (Constructor == null)
									throw new ApplicationException ("GenerateExternalIdentification: Constructor not found in " + Globals.ClassTable [CurrentTypeID].Name); 
								CurrentMethod.SetMethodBuilder (Constructor);
							}
							else
								if (ExternalKind != Globals.EnumFieldKind)
									throw new ApplicationException ("GenerateExternalIdentification: Unsupported External Kind " + ExternalKind);
						}
					}
				}
				CurrentFeatureIDTable.Add (FeatureID, CurrentMethod);			
				CurrentRoutIDTable.Add (RoutineID, CurrentMethod);		
			}
		}
		catch (Exception error)
		{
			Globals.LogError (error, "In identification of " + Name + " (" + ComName + ")from " + Globals.ClassTable [CurrentTypeID].Name);
		}
	}

	// Generate info about current feature.
	public void GenerateFeatureReturnType (int TypeID)
	{
		#if DEBUG
			Globals.Log  ("Return type is " + Globals.ClassTable [TypeID].Name);
		#endif
		try
		{
			CurrentMethod.SetReturnType (TypeID);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Generate info about current feature.
	public void GenerateFeatureArgument (string Name, int TypeID)
	{
		#if DEBUG
			Globals.Log  ("Argument `" + Name+ "' at " + arg_pos + " is of type " + Globals.ClassTable [TypeID].Name);
		#endif
		try
		{
			CurrentMethod.AddArgument (Name, TypeID, arg_pos);
			arg_pos++;
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Freeze current Method.
	public void CreateFeatureDescription()
	{
		try
		{
			CurrentMethod.CreateMethodBuilder();
		}
		catch (Exception error)
		{
			Globals.LogError (error, "In method " + CurrentMethod.Name()+ " from " + Globals.ClassTable [CurrentTypeID].Name);
		}
	}

	// Check need for renaming
	// Use MethodImpl to implement it if needed
	public void CheckRenaming()
	{
		try
		{
			EiffelClass CurrentClass = (EiffelClass)Globals.ClassTable [CurrentTypeID];
			if (CurrentClass.HasParent())
			{
				EiffelClass ParentClass = (EiffelClass)Globals.ClassTable [CurrentClass.BaseType];
				bool Found = ParentClass.RoutIDTable.ContainsKey (CurrentMethod.RoutineID);
				int i = 0;

				while (!Found && (i < CurrentClass.Interfaces.Count))
				{
					ParentClass = (EiffelClass)Globals.ClassTable [ (int)CurrentClass.Interfaces [i]];
					Found = ParentClass.RoutIDTable.ContainsKey (CurrentMethod.RoutineID);
					i++;
				}
		
				if (Found)
				{
					// There is an ancestor feature
					EiffelMethod ParentMethod = (EiffelMethod)ParentClass.RoutIDTable [CurrentMethod.RoutineID];
	
					if (ParentMethod.Name()!= CurrentMethod.Name())
					{
						// Parent feature is renamed
						if (! (ParentMethod.Builder is ConstructorInfo)&& !CurrentMethod.IsAttribute)
						// Can't methodimpl attributes or external creation routines - constructors...
						{
							EiffelMethod Override = new EiffelMethod (ParentMethod, CurrentMethod.Name(), CurrentTypeID);
							Override.CreateMethodBuilder();
							ILGenerator OverrideIL = ((MethodBuilder)Override.Builder).GetILGenerator();
							OverrideIL.Emit (OpCodes.Ldarg_0);
							OverrideIL.Emit (OpCodes.Call, (MethodInfo)ParentMethod.Builder);
							OverrideIL.Emit (OpCodes.Ret);
							 ((TypeBuilder)CurrentClass.Builder).DefineMethodOverride ((MethodInfo)Override.Builder, (MethodInfo)CurrentMethod.Builder);
						}
					}
				}
			}
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Check for covariance and renaming
	// Use MethodImpl to emulate these mechanisms
	public void CheckRenamingAndRedefinition()
	{
		#if (DEBUG)
			Globals.Log ("Checking Covariance and renaming for " + CurrentMethod.Name());
		#endif
		try
		{
			if (Globals.ClassTable [CurrentTypeID].BaseType != Globals.NoValue)
			{
				EiffelClass ParentClass = (EiffelClass)Globals.ClassTable [Globals.ClassTable [CurrentTypeID].BaseType];
				bool Found = ParentClass.RoutIDTable.ContainsKey (CurrentMethod.RoutineID);
				int i = 0;
				
				System.Collections.ArrayList Interfaces = Globals.ClassTable [CurrentTypeID].Interfaces;
				while (!Found && (i < Interfaces.Count))
				{
					ParentClass = Globals.ClassTable [ (int)Interfaces [i]];
					Found = ParentClass.RoutIDTable.ContainsKey (CurrentMethod.RoutineID);
					i++;
				}
		
				#if (DEBUG)
					Globals.Log ("Found in parent: " + Found);
				#endif
				if (Found)
				{
					// There is an ancestor feature
					EiffelMethod ParentMethod = (EiffelMethod)ParentClass.RoutIDTable [CurrentMethod.RoutineID];
					bool MustOverride = (ParentMethod.Name()!= CurrentMethod.Name());
					i = 0;
					
					if (!MustOverride)
						MustOverride = CurrentMethod.ReturnTypeID != ParentMethod.ReturnTypeID;
						
					while (!MustOverride && (i < CurrentMethod.ParameterTypeIDs.Length)&& (i < ParentMethod.ParameterTypeIDs.Length))
					{
						MustOverride = (CurrentMethod.ParameterTypeIDs [i] != ParentMethod.ParameterTypeIDs [i]);
						i++;
					}
					#if (DEBUG)
						Globals.Log ("Must override (redefine or rename): " + MustOverride);
					#endif	
					if (MustOverride)
					{
						// Parent feature is renamed or redefined
						Type[] ParameterTypes = new Type [ParentMethod.ParameterTypeIDs.Length ];
						for (i = 0; i < ParameterTypes.Length; i++)
							ParameterTypes [i] = Globals.ClassTable [ParentMethod.ParameterTypeIDs [i]].Builder;
						MethodBuilder Override = ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).DefineMethod (Globals.OverridePrefix + ParentMethod.Name(), MethodAttributes.Virtual | MethodAttributes.Final | MethodAttributes.Private, ((MethodInfo)ParentMethod.Builder).ReturnType, ParameterTypes);
						ILGenerator OverrideIL = Override.GetILGenerator();
						OverrideIL.Emit (OpCodes.Ldarg_0);
						if (ParameterTypes.Length > 0)
						{
							OverrideIL.Emit (OpCodes.Ldarg_1);
							if (CurrentMethod.ParameterTypeIDs [0] != ParentMethod.ParameterTypeIDs [0])
								OverrideIL.Emit (OpCodes.Castclass, Globals.ClassTable [CurrentMethod.ParameterTypeIDs [0]].Builder);
						}
						if (ParameterTypes.Length > 1)
						{
							OverrideIL.Emit (OpCodes.Ldarg_2);
							if (CurrentMethod.ParameterTypeIDs [0] != (int)ParentMethod.ParameterTypeIDs [1])
								OverrideIL.Emit (OpCodes.Castclass, Globals.ClassTable [CurrentMethod.ParameterTypeIDs [1]].Builder);
						}
						if (ParameterTypes.Length > 2)
						{
							OverrideIL.Emit (OpCodes.Ldarg_3);
							if (CurrentMethod.ParameterTypeIDs [0] != ParentMethod.ParameterTypeIDs [2])
								OverrideIL.Emit (OpCodes.Castclass, Globals.ClassTable [CurrentMethod.ParameterTypeIDs [2]].Builder);
						}
						if (ParameterTypes.Length > 3)
						{
							for (i = 4; i <= ParameterTypes.Length; i++)
							{
								OverrideIL.Emit (OpCodes.Ldarg_S, i);
								if (CurrentMethod.ParameterTypeIDs [i - 1] != ParentMethod.ParameterTypeIDs [i - 1])
									OverrideIL.Emit (OpCodes.Castclass, Globals.ClassTable [CurrentMethod.ParameterTypeIDs [i - 1]].Builder);
							}
						}
						OverrideIL.Emit (OpCodes.Callvirt, (MethodInfo)CurrentMethod.Builder);
						OverrideIL.Emit (OpCodes.Ret);
						 ((TypeBuilder) ((EiffelClass)Globals.ClassTable [CurrentTypeID]).Builder).DefineMethodOverride ((MethodInfo)Override, (MethodInfo)ParentMethod.Builder);
					}
				}

			}
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Define system entry point (root feature of root class)
	public void DefineEntryPoint (int TypeID, int FeatureID)
	{
		TypeBuilder EntryType;
		MethodBuilder EntryPoint;
		ILGenerator Generator;
		MethodBase RealEntryPoint;
	
		try
		{
			EntryType = module.DefineType (Globals.ClassTable [TypeID].Name + "_" + Globals.EntryTypeName);
			EntryPoint = EntryType.DefineMethod (Globals.EntryPointName, MethodAttributes.Public | MethodAttributes.Static, Type.GetType ("void"), Type.EmptyTypes);
			Generator = EntryPoint.GetILGenerator();
			RealEntryPoint = ((EiffelMethod) (Globals.ClassTable [TypeID].FeatureIDTable [FeatureID])).Builder;
			if (RealEntryPoint == null)
				throw new ApplicationException ("DefineEntryPoint: Real entry point not found (TypeID: " + TypeID + ", FeatureID: " + FeatureID + ")");

			Generator.Emit ( OpCodes.Newobj, Globals.ClassTable [TypeID].DefaultConstructor);
			if  (RealEntryPoint is MethodInfo) {
				if (((EiffelMethod) (Globals.ClassTable [TypeID].FeatureIDTable [FeatureID])).ParameterNames.Length > 0)
				Generator.Emit (OpCodes.Ldarg_0);
				Generator.Emit (OpCodes.Call,  (MethodInfo) RealEntryPoint);
			}
			Generator.Emit (OpCodes.Ret);
			EntryType.CreateType();
			assembly.SetEntryPoint (EntryPoint, ApplicationKind);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

/* Error Handling */

	public string LastError()
	{
		string Message = Globals.LastException.Message;
		if ((Globals.LastException.Source != null)&& (Globals.LastException.Source.Length > 0))
		{
			Message += "\nSource: ";
			Message += Globals.LastException.Source;
		}
		return Message;
	}

/* Custom Attributes Generation */

	// Start new custom attribute generation
	// TargetTypeID: type id of class where custom attribute is added
	// AttributeTypeID: Type id of custom attribute
	// ArgCount: Custom attribute constructor arguments count
	public void AddCA (int TargetTypeID, int AttributeTypeID, int ArgCount)
	{
		#if DEBUG
			Globals.Log ("AddClassCustomAttribute (" + TargetTypeID.ToString()+ ", " + AttributeTypeID.ToString()+ ", " + ArgCount.ToString()+ ")");
		#endif
		try
		{
			CAFactory.StartNewAttribute (TargetTypeID, AttributeTypeID, ArgCount);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// 	
	// `AddCA' must be called before
	// Any necessary call to `AddCAxxxArg' must be done before
	public void GenerateClassCA()
	{
		#if DEBUG
			Globals.Log ("GenerateClassCA()");
		#endif
		try
		{
			CAFactory.GenerateClassCA();
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Generate method or field custom attribute
	// `AddCA' must be called before
	// Any necessary call to `AddCAxxxArg' must be done before
	public void GenerateFeatureCA (int FeatureID)
	{
		#if DEBUG
			Globals.Log ("GenerateFeatureCA (" + FeatureID.ToString()+ ")");
		#endif
		try
		{
			CAFactory.GenerateFeatureCA (FeatureID);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Add custom attribute constructor custom type argument  (useful for enums)
	public void AddCATypedArg (int Value, int TypeID)
	{
		#if DEBUG
			Globals.Log ("AddCATypedArg (" + Value.ToString()+ ", " + TypeID.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value, Globals.ClassTable [TypeID].Builder);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor integer argument
	public void AddCAIntegerArg (int Value)
	{
		#if DEBUG
			Globals.Log ("AddCAIntegerArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
/* FIXME: No support for non-native integers yet.

	// Add custom attribute constructor byte argument
	public void AddCAInteger8Arg (byte Value)
	{
		#if DEBUG
			Globals.Log ("AddCAInteger8Arg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 16 argument
	public void AddCAInteger16Arg (Int16 Value)
	{
		#if DEBUG
			Globals.Log ("AddCAInteger16Arg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 64 argument
	public void AddCAInteger64Arg (Int64 Value)
	{
		#if DEBUG
			Globals.Log ("AddCAInteger64Arg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
*/

	// Add custom attribute constructor string argument
	public void AddCAStringArg (string Value)
	{
		#if DEBUG
			Globals.Log ("AddCAstringArg (" + Value + ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor real argument
	public void AddCARealArg (float Value)
	{
		#if DEBUG
			Globals.Log ("AddCARealArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor double argument
	public void AddCADoubleArg (double Value)
	{
		#if DEBUG
			Globals.Log ("AddCADoubleArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor character argument
	public void AddCACharacterArg (char Value)
	{
		#if DEBUG
			Globals.Log ("AddCACharacterArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor boolean argument
	public void AddCABooleanArg (bool Value)
	{
		#if DEBUG
			Globals.Log ("AddCABooleanArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

	// Add custom attribute constructor integer argument
	public void AddCAArrayIntegerArg (int[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayIntegerArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}

/* FIXME: No support for non-native integers yet.
	
	// Add custom attribute constructor byte argument
	public void AddCAArrayInteger8Arg (byte[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayInteger8Arg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 16 argument
	public void AddCAArrayInteger16Arg (Int16[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayInteger16Arg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor integer 64 argument
	public void AddCAArrayInteger64Arg (Int64[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayInteger64Arg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
*/
	// Add custom attribute constructor string argument
	public void AddCAArrayStringArg (string[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArraystringArg (" + Value + ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor real argument
	public void AddCAArrayRealArg (float[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayRealArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor double argument
	public void AddCAArrayDoubleArg (double[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayDoubleArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor character argument
	public void AddCAArrayCharacterArg (char[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayCharacterArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Add custom attribute constructor boolean argument
	public void AddCAArrayBooleanArg (bool[] Value)
	{
		#if DEBUG
			Globals.Log ("AddCAArrayBooleanArg (" + Value.ToString()+ ")");
		#endif
		try
		{
			CAFactory.AddCAConstructorArg (Value);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
/* IL Generation */

	// Start IL Generation for current class
	public void StartIlGeneration (int TypeID)
	{
		CurrentTypeID = TypeID;
	}
	
	// Generate info about current feature.
	public void GenerateFeatureIL (int FeatureID)
	{
		try
		{
			Labels = new System.Collections.ArrayList();
			CurrentMethod = ( EiffelMethod)Globals.ClassTable [CurrentTypeID].FeatureIDTable [FeatureID];
			MethodIL = ((MethodBuilder)CurrentMethod.Builder).GetILGenerator();
			Locals = new System.Collections.ArrayList();
		}
		catch (Exception error)
		{
			Globals.LogError (error, "In GenerateFeatureIL with FeatureID " + FeatureID);
		}
	}

	// Generate info about current creation feature.
	public void GenerateCreationFeatureIL (int FeatureID)
	{
		try
		{
			Labels = new System.Collections.ArrayList();
			CurrentMethod = ( EiffelMethod)Globals.ClassTable [CurrentTypeID].FeatureIDTable [FeatureID];
			MethodIL = ((MethodBuilder)CurrentMethod.ConstructorBuilder).GetILGenerator();
			Locals = new System.Collections.ArrayList();
		}
		catch (Exception error)
		{
			Globals.LogError (error, "In GenerateCreationFeatureIL with FeatureID " + FeatureID);
		}
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
		Type NewType = null;
		Type[] Parameters;
		int i;
		MethodInfo Result = null;
		MethodInfo[] Methods;
		ParameterInfo[] ParameterInfos;
		bool Found;
		
		try
		{
			Parameters = new Type[ ParameterTypes.Length ];
			for (i = 0; i < ParameterTypes.Length; i++)
			{
				NewType = TypeFromName (ParameterTypes [i]);
				if (NewType == null)
					throw new ApplicationException ("GenerateExternalCall: Unknown argument type: " + ParameterTypes [i]);
				Parameters [i] = NewType;
			}
			NewType = TypeFromName (ExternalTypeName);
			if (NewType == null)
				throw new ApplicationException ("Type " + ExternalTypeName + " not found.");
			switch (ExternalKind)
			{
				case 1:
// FIXME: Workaround until we have access to MethodImpl
//					Feature = NewType.GetMethod (Name, Parameters);
					Methods = NewType.GetMethods (BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
					foreach (MethodInfo Feature in Methods )
					{
						if ((Feature.Name == Name)&& (Feature.ReturnType.FullName == ReturnType)&& (Feature.GetParameters().Length == ParameterTypes.Length))
						{
							ParameterInfos = Feature.GetParameters();
							Found = true;
							for (i = 0; (i < ParameterInfos.Length)&& (i < ParameterTypes.Length)&&Found; i++)
								Found = (ParameterInfos [i].ParameterType.FullName == ParameterTypes [i]);
							if (Found)
							{
								Result = Feature;
								break;
							}
						}
					}		
					if (Result == null)
						throw new ApplicationException ("GenerateExternalCall: Method " + Name + " not found in " + NewType); 
					if (IsVirtual)
						MethodIL.Emit (OpCodes.Callvirt, Result);
					else
						MethodIL.Emit (OpCodes.Call, Result);
					break;
				case 2:
					MethodIL.Emit (OpCodes.Newobj, NewType.GetConstructor (Parameters));
					break;
				case 3:
					MethodIL.Emit (OpCodes.Ldfld, NewType.GetField (Name));
					break;
				case 4:
					MethodIL.Emit (OpCodes.Ldsfld, NewType.GetField (Name));
					break;
				case 5:
					MethodIL.Emit (OpCodes.Stfld, NewType.GetField (Name));
					break;
				case 6:
					MethodIL.Emit (OpCodes.Stsfld, NewType.GetField (Name));
					break;
				case 7:
					MethodIL.Emit (OpCodes.Call, NewType.GetMethod (Name, Parameters));
					break;
				case 12:
					MethodIL.Emit (OpCodes.Call, NewType.GetConstructor (Parameters));
					break;
				default:
					throw new ApplicationException ("GenerateExternalCall: Invalid External Kind");
			}
		}
		catch (Exception error)
		{
			Globals.LogError (error, "For method " + Name + " on class " + NewType);
		}
	}

/* Local Variable Info Generator */

	public void PutResultInfo (int TypeID)
	{
		try
		{
			Result = MethodIL.DeclareLocal (Globals.ClassTable[ TypeID ].Builder);
			if (DebugMode)
				Result.SetLocalSymInfo (Globals.ResultName);
		}
		catch (Exception error)
		{
			Globals.LogError (error, "With object of type " + Globals.ClassTable [TypeID].Builder);
		}			
	}
	
	public void PutLocalInfo (int TypeID, string Name)
	{
		try
		{
			LocalBuilder NewLocal = MethodIL.DeclareLocal (Globals.ClassTable [TypeID].Builder);
			if (DebugMode)
				NewLocal.SetLocalSymInfo (Name);
			Locals.Add (NewLocal);
		}
		catch (Exception error)
		{
			Globals.LogError (error, "With object of type " + Globals.ClassTable [TypeID].Builder);
		}			
	}

/* Object Creation */

	public void CreateLikeCurrentObject()
	{
		CreateObject (CurrentTypeID);
	}
	
	public void CreateObject (int TypeID)
	{
		try
		{
			MethodIL.Emit (OpCodes.Newobj, Globals.ClassTable [TypeID].DefaultConstructor);
		}
		catch (Exception error)
		{
			Globals.LogError (error, "With object of type " + Globals.ClassTable [TypeID].Builder);
		}
	}

	public void CreateAttributeObject (int TypeID, int FeatureID)
	{
		EiffelMethod f = (EiffelMethod)Globals.ClassTable [TypeID].FeatureIDTable [FeatureID];

		try
		{
			if (f.ReturnTypeID == Globals.NoValue)
				throw new ApplicationException ("Not an attribute or like function");

			if (Globals.ClassTable [f.ReturnTypeID].IsArray)
				MethodIL.Emit (OpCodes.Newarr, Globals.ClassTable [f.ReturnTypeID].ArrayElementType());
			else
				if (! (Globals.ClassTable [f.ReturnTypeID].IsExternal))
					MethodIL.Emit (OpCodes.Newobj, Globals.ClassTable [f.ReturnTypeID].DefaultConstructor);
		}
		catch (Exception error)
		{
			Globals.LogError (error, "With object of type " + Globals.ClassTable [TypeID].Builder);
		}
	}

/* IL stack managment */

	public void DuplicateTop()
	{
		MethodIL.Emit (OpCodes.Dup);
	}

	// Remove top element of IL stack.
	public void Pop()
	{
		MethodIL.Emit (OpCodes.Pop);
	}

/* Variables access */

	// Generate box operation
	public void GenerateMetamorphose (int TypeID)
	{
		MethodIL.Emit (OpCodes.Box, Globals.ClassTable [TypeID].Builder);
	}
	
	// Generate unbox operation followed by load indirect
	public void GenerateUnmetamorphose (int TypeID)
	{
		MethodIL.Emit (OpCodes.Unbox, Globals.ClassTable [TypeID].Builder);
		GenerateLoadFromAddress  (TypeID);
	}

	// Generate Cast
	public void GenerateCheckCast (int SourceTypeID, int TargetTypeID)
	{
		MethodIL.Emit (OpCodes.Castclass, Globals.ClassTable [TargetTypeID].Builder);
	}

	// Generate access to `Current'.
	public void GenerateCurrent()
	{
		MethodIL.Emit (OpCodes.Ldarg_0);
	}

	// Generate result
	public void GenerateResult()
	{
		MethodIL.Emit (OpCodes.Ldloc, Result);
	}

	// Generate attribute
	public void GenerateAttribute (int TypeID, int FeatureID)
	{
		try
		{
			MethodIL.Emit (OpCodes.Ldfld, ((EiffelMethod)Globals.ClassTable [TypeID].FeatureIDTable [FeatureID]).AttributeBuilder);
		}
		catch (Exception error)
		{
			Globals.LogError (error, "In feature with ID " + FeatureID + " (" + ((EiffelMethod)Globals.ClassTable [TypeID].FeatureIDTable [FeatureID]).Name()+ ")of " + Globals.ClassTable [TypeID].Builder);
		}
	}

	// Generate feature access
	public void GenerateFeatureAccess (int TypeID, int FeatureID, bool IsVirtual)
	{
		MethodInfo Feature = null;
		try
		{
			 Feature = (MethodInfo) ((EiffelMethod)Globals.ClassTable [TypeID].FeatureIDTable [FeatureID]).Builder;
			if (IsVirtual)
				MethodIL.Emit (OpCodes.Callvirt, Feature);
			else
				MethodIL.Emit (OpCodes.Call, Feature);
		}
		catch (Exception error)
		{
			Globals.LogError (error, " in class " + ((EiffelClass)Globals.ClassTable [TypeID]).Name + " (TypeID = " + TypeID + ")for method " + ((EiffelMethod)Globals.ClassTable [TypeID].FeatureIDTable [FeatureID]).Name()+ " (FeatureID = " + FeatureID + "): " + Feature);
		}
	}
	
	// Generate access to `n'-th argument of current feature.
	// Cannot be `0', reserved for `Current'.
	public void GenerateArgument (int n)
	{
	   switch (n)
	   {
		  case 1:
			MethodIL.Emit (OpCodes.Ldarg_1);
			break;
		  case 2:
		  	MethodIL.Emit (OpCodes.Ldarg_2);
			break;
		  case 3:
		  	MethodIL.Emit (OpCodes.Ldarg_3);
			break;
		  default:
		  	MethodIL.Emit (OpCodes.Ldarg, n);
			break;
		}
	}
	
	// Generate access to `n'-th local variable of current feature.
	public void GenerateLocal (int n)
	{
		MethodIL.Emit (OpCodes.Ldloc, (LocalBuilder)Locals [n - 1]);
	}

/* Assertions */

	// Check if assertions are already being checked,
	// in that case we need to skip the assertion block.
	public void GenerateInAssertionTest (int EndOfAssertLabel)
	{
		MethodIL.Emit (OpCodes.Ldsfld, in_assertion);
		BranchOnTrue (EndOfAssertLabel);
	}

	// Set `in_assertion' flag to True.
	public void GenerateSetAssertionStatus()
	{
		PutBooleanConstant (true);
		MethodIL.Emit (OpCodes.Stsfld, in_assertion);
	}

	// Set `in_assertion' flag to False.
	public void GenerateRestoreAssertionStatus()
	{
		PutBooleanConstant (false);
		MethodIL.Emit (OpCodes.Stsfld, in_assertion);
	}

	// Raise an assertion violation with `Tag' name when evaluation of
	// assertion yield a False value.
	public void GenerateAssertionCheck (int AssertType, string Tag)
	{
		Label NewLabel = MethodIL.DefineLabel();
		Type ExceptionType = Type.GetType ("System.Exception");
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
	public void GeneratePreconditionCheck (string Tag, int LabelID)
	{
		MethodIL.Emit (OpCodes.Ldstr, Tag);
		MethodIL.Emit (OpCodes.Stsfld, assertion_tag);
		BranchOnFalse (LabelID);
	}

	public void GeneratePreconditionViolation()
	{
		Type ExceptionType = Type.GetType ("System.Exception");
		Type [] ArrayType = new Type [1] {typeof (string)};

		GenerateRestoreAssertionStatus();
		MethodIL.Emit (OpCodes.Ldsfld, assertion_tag);
		MethodIL.Emit (OpCodes.Newobj, ExceptionType.GetConstructor (ArrayType));
		MethodIL.Emit (OpCodes.Throw);
	}

	// Generate call to invariant routine
	public void GenerateInvariantChecking (int TypeID)
	{
		EiffelClass c = Globals.ClassTable[TypeID];
		if (c.InvariantRoutine != null){
			MethodIL.Emit (OpCodes.Call, (MethodInfo)Globals.ClassTable[TypeID].InvariantRoutine.Builder);
		}
	}

/* Exception */

	// Start exception block
	public void GenerateStartExceptionBlock(){
		Label label = MethodIL.BeginExceptionBlock();
	}

	// Start rescue clause and store last exception
	public void GenerateStartRescue(){
		MethodIL.BeginCatchBlock (Type.GetType ("System.Exception"));
		MethodIL.Emit (OpCodes.Stsfld, last_exception);
	}

	// End of rescue clause
	public void GenerateEndExceptionBlock(){
		MethodIL.EndExceptionBlock();
	}

/* Assignments */

	// Generate a check for IsInstance of
	public void GenerateIsInstanceOf (int TypeID)
	{
		MethodIL.Emit (OpCodes.Isinst, Globals.ClassTable [TypeID].Builder);
	}

	// Generate assignment to attribute of `Name' in current class.
	public void GenerateAttributeAssignment (int FeatureID)
	{
		MethodIL.Emit (OpCodes.Stfld, ((EiffelMethod)Globals.ClassTable [CurrentTypeID].FeatureIDTable [FeatureID]).AttributeBuilder);
	}
	
	// Generate assignment to `n'-th local variable of current feature.
	public void GenerateLocalAssignment (int n)
	{
		try
		{
			MethodIL.Emit (OpCodes.Stloc, (LocalBuilder)Locals [n - 1]);
		}
		catch (Exception error)
		{
			Globals.LogError (error);
		}
	}
	
	// Generate assignment to result of current feature.
	public void GenerateResultAssignment()
	{
		MethodIL.Emit (OpCodes.Stloc, Result);
	}

/* Addresses */

	// Generate `ldloca n' instruction
	public void GenerateLocalAddress (int n)
	{
		MethodIL.Emit (OpCodes.Ldloca, (LocalBuilder)Locals [n - 1]);
	}

	// Generate `ldftn f' or `ldvirtftn f' instruction
	public void GenerateRoutineAddress (int TypeID, int FeatureID)
	{
		MethodInfo Method = (MethodInfo) (((EiffelMethod)Globals.ClassTable [TypeID].FeatureIDTable [FeatureID]).Builder);
		DuplicateTop();
		MethodIL.Emit (OpCodes.Ldvirtftn, Method);
	}

	// Generate `ldloca Result' instruction
 	public void GenerateResultAddress()
 	{
		MethodIL.Emit (OpCodes.Ldloca, Result);
	}

	// Generate `ldarga 0' instruction
	public void GenerateCurrentAddress()
	{
		MethodIL.Emit (OpCodes.Ldarga, 0);
	}

	// Generate `ldflda attr' instruction
	public void GenerateAttributeAddress (int TypeID, int FeatureID)
	{
		MethodIL.Emit (OpCodes.Ldflda, ((EiffelMethod)Globals.ClassTable [TypeID].
			FeatureIDTable [FeatureID]).AttributeBuilder);
	}

	// Generate `ldarga n' instruction
	public void GenerateArgumentAddress (int n)
	{
		MethodIL.Emit (OpCodes.Ldarga, n);
	}

	// Generate `ldint.xx' instruction
	public void GenerateLoadFromAddress  (int TypeID)
	{
		if (TypeID == Int32ID)
			MethodIL.Emit (OpCodes.Ldind_I4);
		else if (TypeID == Int64ID)
			MethodIL.Emit (OpCodes.Ldind_I8);
		else if (TypeID == Int16ID)
			MethodIL.Emit (OpCodes.Ldind_I2);
		else if (TypeID == ByteID)
			MethodIL.Emit (OpCodes.Ldind_I1);
		else if (TypeID == CharID)
			MethodIL.Emit (OpCodes.Ldind_I4);
		else if (TypeID == BooleanID)
			MethodIL.Emit (OpCodes.Ldind_I4);
		else if (TypeID == SingleID)
			MethodIL.Emit (OpCodes.Ldind_R4);
		else if (TypeID == DoubleID)
			MethodIL.Emit (OpCodes.Ldind_R8);
		else
			Globals.LogError  (new ApplicationException ("Cannot unmetamorphose non-basic type (TypeID :" + TypeID.ToString()+ ")."));
	}

/* Array Manipulation */

	// Generate call to `item' of ARRAY.
	public void GenerateArrayAccess (int Kind)
	{
		switch (Kind)
		{
			case 30:
				MethodIL.Emit (OpCodes.Ldelem_I1);
				break;
			case 31:
				MethodIL.Emit (OpCodes.Ldelem_I2);
				break;
			case 32:
				MethodIL.Emit (OpCodes.Ldelem_I4);
				break;
			case 33:
				MethodIL.Emit (OpCodes.Ldelem_I8);
				break;
			case 34:
				MethodIL.Emit (OpCodes.Ldelem_R4);
				break;
			case 35:
				MethodIL.Emit (OpCodes.Ldelem_R8);
				break;
			case 36:
				MethodIL.Emit (OpCodes.Ldelem_Ref);
				break;
		}
	}

	// Generate call to `put' of ARRAY.
	public void GenerateArrayWrite (int Kind)
	{
		switch (Kind)
		{
			case 30:
				MethodIL.Emit (OpCodes.Stelem_I1);
				break;
			case 31:
				MethodIL.Emit (OpCodes.Stelem_I2);
				break;
			case 32:
				MethodIL.Emit (OpCodes.Stelem_I4);
				break;
			case 33:
				MethodIL.Emit (OpCodes.Stelem_I8);
				break;
			case 34:
				MethodIL.Emit (OpCodes.Stelem_R4);
				break;
			case 35:
				MethodIL.Emit (OpCodes.Stelem_R8);
				break;
			case 36:
				MethodIL.Emit (OpCodes.Stelem_Ref);
				break;
		}
	}

	// Create a new array.
	public void GenerateArrayCreation (int TypeID)
	{
		MethodIL.Emit (OpCodes.Newarr, Globals.ClassTable [TypeID].Builder);
	}
	
/* Generate return statements */

	public void GenerateReturn()
	{
		MethodIL.Emit (OpCodes.Ret);		
	}
	
	// Generate return statement.
	public void GenerateReturnValue()
	{
		GenerateResult();
		GenerateReturn();
	}

/* Onces */


	public void GenerateOnceDoneInfo (string name)
	{
		FieldAttributes AttributeAttributes;

		AttributeAttributes = FieldAttributes.Private | FieldAttributes.Static;

		DoneBuilder = ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).DefineField (name + "Done", Type.GetType ("System.Boolean"), AttributeAttributes);
	}

	public void GenerateOnceResultInfo (string name, int TypeID)
	{
		FieldAttributes AttributeAttributes;

		AttributeAttributes = FieldAttributes.Private | FieldAttributes.Static;

		ResultBuilder = ((TypeBuilder)Globals.ClassTable [CurrentTypeID].Builder).DefineField (name + "Result", Globals.ClassTable [TypeID].Builder, AttributeAttributes);
	}

	public void GenerateOnceTest()
	{
		MethodIL.Emit (OpCodes.Ldsfld, DoneBuilder);
	}

	public void GenerateOnceResult()
	{
		MethodIL.Emit (OpCodes.Ldsfld, ResultBuilder);
	}

	public void GenerateOnceStoreResult()
	{
		MethodIL.Emit (OpCodes.Stsfld, ResultBuilder);
		PutBooleanConstant (true);
		MethodIL.Emit (OpCodes.Stsfld, DoneBuilder);
	}

/* Arrays */

	public void GenerateArrayLower()
	{
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Call, Globals.GetLowerBound);
	}
	
	public void GenerateArrayUpper()
	{
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Call, Globals.GetUpperBound);
	}
	
	public void GenerateArrayCount()
	{
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Call, Globals.GetLength);
	}
	
/* Constants generation */

	// Put `void' on IL stack.
	public void PutVoid()
	{
		MethodIL.Emit (OpCodes.Ldnull);
	}
	
	// Put `s' on IL stack.
	public void PutManifestString (string s)
	{
		MethodIL.Emit (OpCodes.Ldstr, s);
	}
	
	// Put `i' on IL stack.
	public void PutInteger32Constant (Int32 i )
	{
	  	MethodIL.Emit (OpCodes.Ldc_I4, i);
	}

	// Put `d' on IL stack.
	public void PutDoubleConstant (double d)
	{
		MethodIL.Emit (OpCodes.Ldc_R8, d);
	}

	// Put `c' on IL stack.
	public void PutCharacterConstant (char c)
	{
		MethodIL.Emit (OpCodes.Ldc_I4, c);
	}

	// Put `b' on IL stack.
	public void PutBooleanConstant (bool b)
	{
		if (b)
		  	MethodIL.Emit (OpCodes.Ldc_I4, 1);
		else
		  	MethodIL.Emit (OpCodes.Ldc_I4, 0);
	}

/* Labels and branching */

	// Generate a branch instruction to `label' if top of
	// IL stack  True.
	public void BranchOnTrue (int label)
	{
		MethodIL.Emit (OpCodes.Brtrue, (Label)Labels [label]);
	}
	private void BranchOnTrue ( Label label)
	{
		MethodIL.Emit (OpCodes.Brtrue, label);
	}

	// Generate a branch instruction to `label' if top of
	// IL stack  False.
	public void BranchOnFalse (int label)
	{
		MethodIL.Emit (OpCodes.Brfalse, (Label)Labels [label]);
	}

	// Generate a branch instruction to `label'.
	public void BranchTo (int label)
	{
		MethodIL.Emit (OpCodes.Br, (Label)Labels [label]);
	}

	// Mark a portion of code with `label'.
	public void MarkLabel (int label)
	{
		MethodIL.MarkLabel ((Label)Labels [label]);
	}

/* Binary Operator generation */

	// Generate `<' operator.
	public void GenerateLt()
	{
		MethodIL.Emit (OpCodes.Clt);
	}

	// Generate `<=' operator.
	public void GenerateLe()
	{
		MethodIL.Emit (OpCodes.Cgt);
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}
	
	// Generate `>' operator.
	public void GenerateGt()
	{
		MethodIL.Emit (OpCodes.Cgt);
	}		

	// Generate `>=' operator.
	public void GenerateGe()
	{
		MethodIL.Emit (OpCodes.Clt);
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}
	
	// Generate `*' operator.
	public void GenerateStar()
	{
		MethodIL.Emit (OpCodes.Mul);
	}

	// Generate `/' operator.
	public void GenerateSlash()
	{
		MethodIL.Emit (OpCodes.Div);
	}

	// Generate `^' operator.
	public void GeneratePower()
	{
		if (SystemMath == null)
		{
			SystemMath = Type.GetType ("System.Math");
			PowerInfo = SystemMath.GetMethod ("Pow");
			Type Float64 = Type.GetType ("float64 ");
			PowerArgumentsTypes = new Type[]{ Float64, Float64 };
		}
		MethodIL.EmitCall (OpCodes.Call, PowerInfo, PowerArgumentsTypes);
	}

	// Generate `+' operator.
	public void GeneratePlus()
	{
		MethodIL.Emit (OpCodes.Add);
	}

	// Generate `\\' operator.
	public void GenerateMod()
	{
		MethodIL.Emit (OpCodes.Rem);
	}

	// Generate `-' operator.
	public void GenerateMinus()
	{
		MethodIL.Emit (OpCodes.Sub);
	}

	// Generate `//' operator.
	public void GenerateDiv()
	{
		MethodIL.Emit (OpCodes.Div);
	}

	// Generate `xor' operator.
	public void GenerateXor()
	{
		MethodIL.Emit (OpCodes.Xor);
	}

	// Generate `or' operator.
	public void GenerateOr()
	{
		MethodIL.Emit (OpCodes.Or);
	}

	// Generate `and' operator.
	public void GenerateAnd()
	{
		MethodIL.Emit (OpCodes.And);
	}

	// Generate `implies operator.
	public void GenerateImplies()
	{
	}

	// Generate `=' operator.
	public void GenerateEq()
	{
		MethodIL.Emit (OpCodes.Ceq);
	}

	// Generate `<<' operator.
	public void GenerateShl()
	{
		MethodIL.Emit (OpCodes.Shl);
	}

	// Generate `>>' operator.
	public void GenerateShr()
	{
		MethodIL.Emit (OpCodes.Shr);
	}

	// Generate `/=' operator.
	public void GenerateNe()
	{
		MethodIL.Emit (OpCodes.Ceq);
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}

/* Unary operator generation */


	// Generate '+' operator.
	public void GenerateUPlus()
	{
	}

	// Generate '-' operator.
	public void GenerateUMinus()
	{
		MethodIL.Emit (OpCodes.Neg);
	}

	// Generate 'not' operator.
	public void GenerateNot()
	{
		MethodIL.Emit (OpCodes.Ldc_I4, 0);
		MethodIL.Emit (OpCodes.Ceq);
	}

/* Line info */

	// Generate `n' to enable to find corresponding
	// Eiffel class file in IL code.
	public void PutLineInfo (int n)
	{
		MethodIL.MarkSequencePoint (Globals.ClassTable [CurrentTypeID].Document, n, 0, n, 0);
	}

/* Labels creation */

	// Create a new label and return corresponding index.
	public int CreateLabel()
	{
		Label NewLabel = MethodIL.DefineLabel();
		Labels.Add (NewLabel);
		return Labels.Count - 1;
	}

/* Generate the ISE run-time class */

	private void PrepareISERuntime()
	{
		Type ISE_class;
		AssemblyName name = new AssemblyName();
		Assembly IseRuntimeAssembly;

		name.Name = "ise_runtime";
		name.Version = new Version (5,1,5,1);
		name.SetPublicKeyToken (new byte[8] {0xde, 0xf2, 0x6f, 0x29, 0x6e, 0xfe, 0xf4, 0x69});
		name.CultureInfo = new System.Globalization.CultureInfo ("");
		IseRuntimeAssembly = Assembly.Load (name);
		ExternalAssemblies.Add (IseRuntimeAssembly);

		ISE_class = IseRuntimeAssembly.GetType ("ISE.Runtime.RUN_TIME");
		assertion_tag = ISE_class.GetField ("assertion_tag");
		in_assertion = ISE_class.GetField ("in_assertion");

		ISE_class = IseRuntimeAssembly.GetType ("ISE.Runtime.EXCEPTION_MANAGER");
		last_exception = ISE_class.GetField ("last_exception");
	}

/* Perform Type lookup */

	protected Type TypeFromName (string TypeName)
	{
		Type ExternalType = Type.GetType (TypeName, false, false);
		if (ExternalType != null)
			return ExternalType;
		ExternalType = module.GetType (TypeName, false, false);
		if (ExternalType != null)
			return ExternalType;
		foreach (Assembly assembly in ExternalAssemblies)
		{
			ExternalType = assembly.GetType (TypeName);
			if (ExternalType != null)
				return ExternalType;
		}
		return null;
	}

/* Private */
	
	// Custom attributes factory
	private CustomAttributesFactory CAFactory;
	
	// Referenced assemblies
	private System.Collections.ArrayList ExternalAssemblies;

	// Built assembly
	private AssemblyBuilder assembly;
	
	// Built module
	private ModuleBuilder module;
	
	// Current Method IL Generator
	private ILGenerator MethodIL;
	
	// Labels used in current method
	private System.Collections.ArrayList Labels;
	
	// Current mapped class
	private int CurrentTypeID;
	
	// Currently built method table indexed by feature ID
	private System.Collections.Hashtable CurrentFeatureIDTable;
	
	// Currently built method table indexed by Routine ID
	private System.Collections.Hashtable CurrentRoutIDTable;
	
	// Currently build method
	private EiffelMethod CurrentMethod;

	// List of local variables builders
	private System.Collections.ArrayList Locals;
	
	// Currently generated feature result
	private LocalBuilder Result;
	
	// System.Math type for power operation
	private Type SystemMath;
	
	// MethodInfo for Power of System.Math
	private MethodInfo PowerInfo;
	
	// FileName for generated exe
	private string FileName;
	
	// Signature of Power
	private Type[] PowerArgumentsTypes;
	
	// Are we in debug mode?
	private bool DebugMode;

	// ISE Runtime class
	private FieldInfo assertion_tag;
	private FieldInfo in_assertion;
	private FieldInfo last_exception;

	// ISE Once function management
	private FieldInfo DoneBuilder;
	private FieldInfo ResultBuilder;

	// Key pair filename extension
	private string Key_filename_extension = ".snk";
	
	// Is generated application a console application, a window application or a dll?
	private PEFileKinds ApplicationKind;
}
