using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.InteropServices;

#if BETA2
[ClassInterfaceAttribute (ClassInterfaceType.None)]
#endif
internal class EiffelMethod : Globals
{
	// Set `ParentTypeId' with `TypeID'.
	public EiffelMethod( int ID, int arg_count)
	{
		TypeID = ID;
		MethodBuilderCreated = false;
		ParameterNames = new string [arg_count];
		ParameterTypeIDs = new int [arg_count];
		RoutineID = NoValue;
		FeatureID = NoValue;
		ReturnTypeID = NoValue;
		IsProtected = false;
		IsAttribute = false;
		IsDeferred = false;
		IsRedefined = false;
	}

	// Initialize fields from `other'.
	public EiffelMethod( EiffelMethod other, int aFeatureID, int aRoutineID )
	{
		if( !other.MethodBuilderCreated )
			throw new ApplicationException( "EiffelMethod: other builder not created" );
		copy (other);
		MethodBuilderCreated = true;
		RoutineID = aRoutineID;
		FeatureID = aFeatureID;
	}

	// Initialize fields from `other'.
	public EiffelMethod( EiffelMethod other, string aName, int aFeatureID , int aRoutineID)
	{
		if( !other.MethodBuilderCreated )
			throw new ApplicationException( "EiffelMethod: other builder not created" );
		copy (other);
		MethodBuilderCreated = true;
		RoutineID = aRoutineID;
		FeatureID = aFeatureID;
		EiffelName = aName;
	}

	// Initialize fields from `other', `aName' and `atypeID'.
	// Since TypeIDs are different, `MethodBuilderCreated' is set to `false'.
	public EiffelMethod( EiffelMethod other, string aName, int aTypeID )
	{
		copy (other);
		TypeID = aTypeID;
		MethodBuilderCreated = false;
		EiffelName = aName;
	}

	// Copy content of `other' in Current
	private void copy (EiffelMethod other) {
		MethodBuilderCreated = other.MethodBuilderCreated;
		TypeID = other.TypeID;
		ParameterNames = other.ParameterNames;
		ParameterTypeIDs = other.ParameterTypeIDs;
		RoutineID = other.RoutineID;
		FeatureID = other.FeatureID;
		IsProtected = other.IsProtected;
		IsDeferred = other.IsDeferred;
		IsRedefined = other.IsRedefined;
		IsFrozen = other.IsFrozen;
		IsAttribute = other.IsAttribute;
		RoutineBuilder = other.RoutineBuilder;
		PropertyBuilder = other.PropertyBuilder;
		AttributeBuilder = other.AttributeBuilder;
		RealName = other.RealName;
		EiffelName = other.EiffelName;
		ReturnTypeID = other.ReturnTypeID;
	}

	// TypeID of containing class
	protected int TypeID;
	
	// .NET Name if any
	public string RealName;

	// Eiffel Name always set
	public string EiffelName;

	// Final name of method
	public string Name() {
		if (RealName == null)
			return EiffelName;
		else
			return RealName;
	}

	// Is feature protected?
	public bool IsProtected;
	
	// Is feature deferred?
	public bool IsDeferred;
	
	// Is feature redefined/implemented from parent?
	public bool IsRedefined;

	// Is feature an attribute?
	public bool IsAttribute;
	
	// Is feature frozen?
	public bool IsFrozen;

	// Is feature an invariant?
	public bool IsInvariant;

	// Is feature a creation routine?
	public bool IsCreationRoutine;

	// Return Type identifier in class
	public int ReturnTypeID;
	
	// Feature identifier in class
	public int FeatureID;
	
	// System wide routine identifier
	public int RoutineID;
	
	// Associated MethodBuilder to current feature
	public MethodBase Builder {
		get {
			if (IsAttribute) {
				return PropertyBuilder.GetGetMethod ();
			} else {
				return RoutineBuilder;
			}
		}
	}

	// Associated Method builder to a routine
	internal MethodBase RoutineBuilder;

	// Associated MethodBuilder to property associated with an attribute
	internal PropertyBuilder PropertyBuilder;

	// Associated constructor method builder
	// Can be a MethodBuilder or a MethodInfo
	private MethodBase InternalConstructorBuilder;
	public MethodBase ConstructorBuilder {
		get {
			return InternalConstructorBuilder;
		}
	}

	// Associated attribute builder
	// Can be a FieldBuilder or a FieldInfo
	public FieldInfo AttributeBuilder;

	// Parameter Names
	public string[] ParameterNames;
	
	// Parameter TypeIDs
	public int[] ParameterTypeIDs;

	// Set `RealName' with `FeatureName'.
	public void SetRealName( string FeatureName )
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetRealName: Method builder already created" );
		RealName = FeatureName;
	}

	// Set `EiffelName' with `FeatureName'.
	public void SetEiffelName( string FeatureName )
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetEiffelName: Method builder already created" );
		EiffelName = FeatureName;
	}

	// Set `RoutineID' with `ID'.
	public void SetRoutineID( int ID )
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetRoutineID: Method builder already created" );
		RoutineID = ID;
	}

	// Set `FeatureID' with `ID'.
	public void SetFeatureID( int ID )
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetFeatureID: Method builder already created" );
		FeatureID = ID;
	}

	// Set `ReturnTypeID' with `TypeID'.
	public void SetReturnType( int TypeID )
	{
		ReturnTypeID = TypeID;
	}

	// Add a new argument to method
	public void AddArgument( string a_name, int TypeID ,int pos)
	{
		ParameterNames [pos] = a_name;
		ParameterTypeIDs [pos] = TypeID;
	}

	// Set `IsProtected' with `true'.
	public void SetProtected()
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetProtected: Method builder already created" );
		IsProtected = true;
	}
	
	// Set `IsDeferred' with `true'.
	public void SetDeferred()
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetDeferred: Method builder already created" );
		if( IsFrozen )
			throw new ApplicationException( "SetDeferred: Frozen feature cannot be deferred" );
		IsDeferred = true;
	}

	// Set `IsRedefined' with `true'.
	public void SetRedefined()
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetRedefined: Method builder already created" );
		IsRedefined = true;
	}
	
	public void SetFrozen()
	{
		if( MethodBuilderCreated )
			throw new ApplicationException( "SetFrozen: Method builder already created" );
		if( IsDeferred )
			throw new ApplicationException( "SetFrozen: Deferred feature cannot be frozen" );
		IsFrozen = true;
	}

	// Set `IsInvariant' with `true'.
	public void SetIsInvariant()
	{
		IsInvariant = true;
	}

	// Set `IsCreationRoutine' with `true'.
	public void SetIsCreationRoutine()
	{
		IsCreationRoutine = true;
		CreateConstructorBuilder();
	}
	
	// Set `IsAttribute' with `true'.
	public void SetIsAttribute()
	{
		IsAttribute = true;
	}

	// Set `Builder' with `methodBuilder'
	// Used for external features
	public void SetMethodBuilder( MethodBase methodBuilder )
	{
		RoutineBuilder = methodBuilder;
		MethodBuilderCreated = true;
	}
	
	// Set `AttributeBuilder' with `fieldBuilder'
	// Used for external features
	public void SetAttributeBuilder( FieldInfo fieldBuilder )
	{
		AttributeBuilder = fieldBuilder;
		MethodBuilderCreated = true;
	}
	
	// Create associated method builder
	public void CreateMethodBuilder()
	{
		MethodAttributes Attributes;
		FieldAttributes AttributeAttributes = 0;
		Type[] ParameterTypes;
		MethodBuilder method;
		string att_name	= "_internal_" + Name();
		ILGenerator generator;
		int i;
		
		try
		{
#if DEBUG
			if( MethodBuilderCreated && !(IsAttribute && IsRedefined))
				throw new ApplicationException( "CreateMethodBuilder: Already done" );
			if( RoutineID == NoValue )
				throw new ApplicationException( "CreateMethodBuilder: No Routine ID" );
			if( FeatureID == NoValue )
				throw new ApplicationException( "CreateMethodBuilder: No Feature ID" );
#endif

			if( IsInvariant ) {
				Attributes = MethodAttributes.Static | MethodAttributes.Public;
				ParameterTypes = new Type[1];
				ParameterTypes [0] = ClassTable [TypeID].Builder;
			} else {
				if( IsFrozen )
					Attributes = MethodAttributes.Final | MethodAttributes.Virtual;
				else
					Attributes = MethodAttributes.Virtual;
				if( IsProtected )
				{
					Attributes = Attributes | MethodAttributes.Family;
					AttributeAttributes = FieldAttributes.Family;
				}
				else
				{
					Attributes = Attributes | MethodAttributes.Public;
					AttributeAttributes = FieldAttributes.Public;
				}
				if( IsDeferred ) {
					if (ClassTable [TypeID].IsInterface)
						Attributes = Attributes | MethodAttributes.Virtual | MethodAttributes.Abstract;
					else
						Attributes = Attributes | MethodAttributes.Abstract;
				}

				ParameterTypes = new Type[ ParameterTypeIDs.Length ];
				for(i = 0; i < ParameterTypeIDs.Length; i++ )
					ParameterTypes [i] = ClassTable [ParameterTypeIDs [i]].Builder;
			}

			if( IsAttribute) {

				if (!IsRedefined)
					AttributeBuilder =(( TypeBuilder )ClassTable [TypeID].Builder )
						.DefineField( att_name, ClassTable [ReturnTypeID].Builder, AttributeAttributes );

				PropertyBuilder = ((TypeBuilder) ClassTable [TypeID].Builder)
					.DefineProperty (Name(), PropertyAttributes.None , ClassTable [ReturnTypeID].Builder, null);
				

					// Generate Get method
				method = (( TypeBuilder )ClassTable [TypeID].Builder )
					.DefineMethod ("get_" + Name(), Attributes | MethodAttributes.SpecialName , ClassTable [ReturnTypeID].Builder, null);
				generator = method.GetILGenerator();
				generator.Emit( OpCodes.Ldarg_0 );
				generator.Emit( OpCodes.Ldfld, AttributeBuilder );
				if (IsRedefined)
					generator.Emit(	OpCodes.Castclass, ClassTable [ReturnTypeID].Builder);
				generator.Emit( OpCodes.Ret );		
				PropertyBuilder.SetGetMethod (method);

			} else {
				if( ReturnTypeID == NoValue )
					RoutineBuilder =(( TypeBuilder )ClassTable [TypeID].Builder ).DefineMethod( Name(), Attributes, VoidType, ParameterTypes );
				else
					RoutineBuilder =(( TypeBuilder )ClassTable [TypeID].Builder ).DefineMethod( Name(), Attributes, ClassTable [ReturnTypeID].Builder, ParameterTypes );

				if (IsInvariant) {
					(( MethodBuilder )RoutineBuilder ).DefineParameter( 1, ParameterAttributes.In, "Current_object");
				} else {
					for( i = 0; i < ParameterNames.Length; i++ )
						(( MethodBuilder )RoutineBuilder ).DefineParameter( i + 1, ParameterAttributes.In, ParameterNames [i]);
					(( MethodBuilder )RoutineBuilder ).InitLocals = true;
				}

			}
			if( RoutineBuilder == null && AttributeBuilder == null )
				throw new ApplicationException( "CreateMethodBuilder: Builder null after call for " + Name());
			MethodBuilderCreated = true;
		}
		catch( Exception error )
		{
			LogError( error );
		}
	}
	
	// Create associated method builder
	public void CreateConstructorBuilder()
	{
		MethodAttributes Attributes;
		Type[] ParameterTypes;
		int i;
		
		try
		{
			Attributes = MethodAttributes.Final | MethodAttributes.Public
				| MethodAttributes.RTSpecialName | MethodAttributes.SpecialName ;

			ParameterTypes = new Type[ ParameterTypeIDs.Length ];
			for(i = 0; i < ParameterTypeIDs.Length; i++ )
				ParameterTypes [i] = ClassTable [ParameterTypeIDs [i]].Builder;

			InternalConstructorBuilder =(( TypeBuilder )ClassTable [TypeID].Builder ).DefineMethod( Name(), Attributes, VoidType, ParameterTypes );
			for( i = 0; i < ParameterNames.Length; i++ )
				(( MethodBuilder )InternalConstructorBuilder ).DefineParameter( i + 1, ParameterAttributes.In, ParameterNames [i]);
			(( MethodBuilder )InternalConstructorBuilder ).InitLocals = true;
			
			if( InternalConstructorBuilder == null)
				throw new ApplicationException( "CreateMethodBuilder: Builder null after call for " + Name());
		}
		catch( Exception error )
		{
			LogError( error );
		}
	}
	
	// Was `CreateMethodBuilder' called?
	protected bool MethodBuilderCreated;
	
}
