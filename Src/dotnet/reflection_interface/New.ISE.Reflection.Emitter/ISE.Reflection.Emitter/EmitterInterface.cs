using System;
using System.Collections;	// only for implementation, not for interface
using System.Reflection; 	// only for implementation, not for interface
using System.IO; 		// only for implementation, not for interface
using System.Runtime.InteropServices;

[ClassInterfaceAttribute( ClassInterfaceType.AutoDual )]

public class EmitterInterface: Globals
{
	public EmitterInterface()
	{
		Done = new ArrayList();
	}

// Features to analyze assertion
	
	// Initialize class attributes
	public void Initialize( String FileName, String GenerationPath )
	{
		Name = FileName;
		Path = GenerationPath;
		Emitter emitter = new Emitter();
		Emitter.NameFormatter.EiffelFormatting = true;
		emitter.Emit( Name, Path );
	}
	
	// Get class ID from class name
	// Return NoValue if `className' has not been found
	public int GetClassIDFromName( String className )
	{
		foreach( int key in ClassTable.Keys )
		{
			if(( ( ( EiffelClassFactory )ClassTable [key] ).Name.ToLower() ) == className.ToLower() )
				return key;
		}
		return NoValue;
	}	

	// Get attributes which can be used in assertions for class corresponding to `classID'.
	public String [] GetAttributes( int classID )
	{
		EiffelClassFactory classFactory;
		String [] attributes;
		int index;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null ) 
		{
			if( !( classFactory.GenerationPrepared ) )
				throw new Exception( "Class not ready." );
			
			if( classFactory.AttributesNames.Values.Count > 0 )
			{
				attributes = new String [classFactory.AttributesNames.Values.Count];
				index = 0;
				
				foreach( String value in classFactory.AttributesNames.Values )
				{
					attributes [index] = value;
					index++;
				}	
			}
			else
			{
				#if DEBUG
					Log( "No attributes for assertions in class corresponding to classID: " + classID );
				#endif
				attributes = new String [1];
				attributes [0] = NoFeature;
			}			
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for classID " + classID );
			#endif
			attributes = new String [1];
			attributes [0] = NoFeature;
		}
		return attributes;
	}

	// Get parameters names of routine having routineID as unique identifier in class corresponding to classID
	public String [] GetParametersNames( int classID, int routineID )
	{
		EiffelClassFactory classFactory;
		String [] parametersNames;
		EiffelMethodFactory methodFactory;
		ParameterInfo [] parametersInfo;
		String argumentName;
		int i, j;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );
			
			if( ContainsRoutineID( classFactory, routineID ) )
			{
				methodFactory = FoundMethodFactory;
				if( methodFactory != null )
				{
					parametersInfo = methodFactory.Info.GetParameters();
					if( ( parametersInfo != null ) && ( parametersInfo.Length > 0 ) )
					{
						#if DEBUG
							Log( "parametersInfo.Length: " + parametersInfo.Length );
						#endif
						parametersNames = new String [parametersInfo.Length];
						for( i = 0; i < parametersInfo.Length; i++ )
				 		{
							// Some argument names are empty!!
							if( (( ParameterInfo )parametersInfo [i]).Name == null )
								argumentName = "arg_" + i;		
							else
								argumentName = NameFormatter.FormatVariableName( (( ParameterInfo )parametersInfo [i]).Name );

							j = 2;
							while( classFactory.NameClash( argumentName ))
							{
								argumentName = argumentName.TrimEnd( classFactory.Digits );
								argumentName += j;
								j++;
							}	
							parametersNames [i] = argumentName;
						}
					}
					else
					{
						if( parametersInfo == null )
						{
							#if DEBUG
								Log( "ParameterInfo [] is null for method corresponding to routine ID: " + routineID + " in class corresponding to class ID : " + classID );
							#endif
							parametersNames = new String [1];
							parametersNames [0] = NoFeature;
						}
						else if( parametersInfo.Length == 0 )
						{
							#if DEBUG
								Log( "No parameters for method corresponding to routine ID: " + routineID + " in class corresponding to class ID : " + classID );
							#endif
							parametersNames = new String [1];
							parametersNames [0] = NoFeature;
						}
						else
						{
							parametersNames = new String [1];
							parametersNames [0] = NoFeature;
						}
					}
				}
				else
				{
					#if DEBUG
						Log( "EiffelMethodFactory is null for routine corresponding to routineID: " + routineID + " in class corresponding to class ID: " + classID );
					#endif
					parametersNames = new String [1];
					parametersNames [0] = NoFeature;
				}
			}
			else
			{
				#if DEBUG
					Log( "Routine corresponding to ID: " + routineID + " has not been found in class corresponding to class ID: " + classID );
				#endif
				parametersNames = new String [1];
				parametersNames [0] = NoFeature;
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			parametersNames = new String [1];
			parametersNames [0] = NoFeature;
		}
		return parametersNames;
	}

	// Get parameters types ids of routine having routineID as unique identifier in class corresponding to classID
	public int [] GetParametersTypes( int classID, int routineID )
	{
		EiffelClassFactory classFactory;
		int [] parametersTypes;
		EiffelMethodFactory methodFactory;
		ParameterInfo [] parametersInfo;
		int i;
		Type parameterType;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );
			
			if( ContainsRoutineID( classFactory, routineID ) )
			{
				methodFactory = FoundMethodFactory;
				if( methodFactory != null )
				{
					parametersInfo = methodFactory.Info.GetParameters();
					if( ( parametersInfo != null ) && ( parametersInfo.Length > 0 ) )
					{
						#if DEBUG
							Log( "parametersInfo.Length: " + parametersInfo.Length );
						#endif
						parametersTypes = new int [parametersInfo.Length];
						for( i = 0; i < parametersInfo.Length; i++ )
						{
							parameterType = (( ParameterInfo )parametersInfo [i]).ParameterType;
							if( parameterType != null )
							{
								if( ClassIDTable.ContainsKey( (( ParameterInfo )parametersInfo [i]).ParameterType ) )
									parametersTypes [i] = ( int )ClassIDTable [(( ParameterInfo )parametersInfo [i]).ParameterType];
								else
									parametersTypes [i] = NoValue;
							}
							else
							{
								parametersTypes = new int [1];
								parametersTypes [0] = NoValue;
							}
						}
					}
					else
					{
						if( parametersInfo == null )
						{
							#if DEBUG
								Log( "ParameterInfo [] is null for method corresponding to routine ID: " + routineID + " in class corresponding to class ID : " + classID );
							#endif
							parametersTypes = new int [1];
							parametersTypes [0] = NoValue;
						}
						else if( parametersInfo.Length == 0 )
						{
							#if DEBUG
								Log( "No parameters for method corresponding to routine ID: " + routineID + " in class corresponding to class ID : " + classID );
							#endif
							parametersTypes = new int [1];
							parametersTypes [0] = NoValue;
						}
						else
						{
							parametersTypes = new int [1];
							parametersTypes [0] = NoValue;
						}
					}
				}
				else
				{
					#if DEBUG
						Log( "EiffelMethodFactory is null for routine corresponding to routineID: " + routineID + " in class corresponding to class ID: " + classID );
					#endif
					parametersTypes = new int [1];
					parametersTypes [0] = NoValue;
				}
			}
			else
			{
				#if DEBUG
					Log( "Routine corresponding to ID: " + routineID + " has not been found in class corresponding to class ID: " + classID );
				#endif
				parametersTypes = new int [1];
				parametersTypes [0] = NoValue;
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			parametersTypes = new int [1];
			parametersTypes [0] = NoValue;
		}
		#if DEBUG
		for( int j = 0; j < parametersTypes.Length; j++ )
			Log( "parametersTypes [" + j + "]: " + parametersTypes [j] );
		#endif	
		
		return parametersTypes;
	}
	
	// Get return type ID of routine corresponding to `routineID' in class corresponding to `classID'.
	public int GetReturnTypeID( int classID, int routineID )
	{
		EiffelClassFactory classFactory;
		EiffelMethodFactory methodFactory;

		#if DEBUG
			Log( "GetReturnTypeID( " + classID + ", " + routineID + " )" );
		#endif
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null ) 
		{
			if( !( classFactory.GenerationPrepared ) )
				throw new Exception( "Class not ready." );		

			if( ContainsRoutineID( classFactory, routineID ) )
			{
				methodFactory = FoundMethodFactory;
				if( methodFactory != null )
				{					
					if( ClassIDTable.ContainsKey( methodFactory.Info.ReturnType ) )
						return ( int )ClassIDTable [methodFactory.Info.ReturnType];
					else
						return NoValue;
				}
				else
				{
					#if DEBUG
						Log( "Return type id, EiffelMethodFactory is null for routine corresponding to routineID: " + routineID + " in class corresponding to class ID: " + classID );
					#endif
					return NoValue;
				}
			}
			else
			{
				#if DEBUG
					Log( "Return type id, Routine corresponding to ID: " + routineID + " has not been found in class corresponding to class ID: " + classID );
				#endif
				return NoValue;
			}		
		}
		else
		{
			#if DEBUG
				Log( "Return type id, EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			return NoValue;
		}		
	}
	
	// Get attribute return type id from `attributeName' in class corresponding to `classID'.
	public int GetAttributeReturnTypeID( int classID, String attributeName )
	{
		EiffelClassFactory classFactory;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null ) 
		{
			if( !( classFactory.GenerationPrepared ) )
				throw new Exception( "Class not ready." );
			if( classFactory.AttributesNames.ContainsValue( attributeName ) )
			{
				foreach( FieldInfo key in classFactory.AttributesNames.Keys )
				{
					if( ( String )classFactory.AttributesNames [key] == attributeName )
					{
						if( ClassIDTable.ContainsKey( key.FieldType ) )
							return ( int )ClassIDTable [key.FieldType];
						else
							return NoValue;
					}
				}
				return NoValue;
			}
			else
			{
				#if DEBUG
					Log( "Class corresponding to class ID: " + classID + " has no attribute called " + attributeName );
				#endif
				return NoValue;
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			return NoValue;
		}	
	}

// Features for Contract Tool interface

	// Get IDs of each class of assembly (check not to include types from other assemblies)
	public int [] GetClassesIDs()
	{
		Type [] types;
		Assembly assembly;
		Module [] modules;
		int i, j;
		int [] classesIDs;
		int index;
		int classesCount;
		EiffelClassFactory classFactory;

		classesCount = 0;
		
		// Get IDs only of classes part of the given assembly.
		assembly = Assembly.LoadFrom( Name );
		modules = assembly.GetModules();
		for( i = 0; i < modules.Length; i++ )
		{
			types = modules [i].GetTypes();
			for( j = 0; j < types.Length; j++ )
			{
				if( ClassIDTable [types [j]] != null )
				//{
				//	classFactory = ( EiffelClassFactory )ClassTable [( int )ClassIDTable [types [j]]];
				//	if( !( classFactory.CreationRoutines.Count == 0 )&&( !classFactory.IsDeferred ) )
						classesCount++;
				//}
			}
		}
		classesIDs = new int [classesCount];
		index = 0;		
		for( i = 0; i < modules.Length; i++ )
		{
			types = modules [i].GetTypes();
			for( j = 0; j < types.Length; j++ )
			{
				if( ClassIDTable [types [j]] != null )
				{
					classFactory = ( EiffelClassFactory )ClassTable [( int )ClassIDTable [types [j]]];
					//if( !( classFactory.CreationRoutines.Count == 0 )&&( !classFactory.IsDeferred ) )
					//{
						classesIDs [index] = classFactory.ID;
						index ++;	
					//}
				}
			}
		}
		#if DEBUG
			for( int k = 0; k < classesIDs.Length; k++ )
				Log( "classesIDs [" + k + "]: " + classesIDs [k]);
		#endif
			
		return classesIDs;			
	}

	// Get .NET class name corresponding to classID
	public String GetDotNetClassName( int classID )
	{
		if( (( EiffelClassFactory )ClassTable [classID] ) != null )
		{
			if( !(( EiffelClassFactory )ClassTable [classID] ).GenerationPrepared )
				throw new Exception( "Class not ready." );

			return (( EiffelClassFactory )ClassTable [classID] ).TypeName;
		}
		else
			return NoFeature;
	}

	// Get Eiffel name for class corresponding to classID
	public String GetClassName( int classID )
	{
		String className;
		
		if( (( EiffelClassFactory )ClassTable [classID] ) != null )
		{
			if( !(( EiffelClassFactory )ClassTable [classID] ).GenerationPrepared )
				throw new Exception( "Class not ready." );

			className = (( EiffelClassFactory )ClassTable [classID] ).Name;
			if (!( className.Equals( "SYSTEM_VOID" ) ))
				return className;
			else
				return NoFeature;
		}
		else
			return NoFeature;
	}
	
	// Get access features IDs of class corresponding to classID
	public int [] GetAccessFeatures( int classID ) 
	{
		EiffelClassFactory classFactory;
		int [] featuresIDs;
		ICollection keys;
		int index;
		EiffelMethodFactory methodFactory;

		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );

			keys = classFactory.AccessFeatures.Keys;

			if( ( keys != null ) && ( keys.Count != 0 ) )
			{
				#if DEBUG
					Log( "There are AccessFeatures in class corresponding to class ID " + classID );
				#endif
				featuresIDs = new int [keys.Count];
				index = 0;
				foreach( String key in keys )
				{
					#if DEBUG
						Log( "type: " + classFactory.AccessFeatures [key].GetType().ToString() );
					#endif
					if( classFactory.AccessFeatures [key].GetType().ToString() != "System.Reflection.RuntimeFieldInfo" )
					{
						methodFactory = ( EiffelMethodFactory )classFactory.AccessFeatures [key];
						if( methodFactory != null )
						{
							featuresIDs [index] = methodFactory.PolymorphIDs [0];
							index++;
						}
						else
						{
							#if DEBUG
								Log( "EiffelMethodFactory is null for accessFeatures in class corresponding to class ID " + classID );
							#endif
						}
					}
					else
					{
						#if DEBUG
							Log( "This feature is an attribute." );
						#endif
					}
				}
				if( ( featuresIDs.Length == 1 ) && ( featuresIDs [0] == 0 ) )
					featuresIDs [0] = NoValue;
			}
			else
			{	
				if( keys == null )
				{ 
					#if DEBUG
						Log( "AccessFeatures keys are null in class corresponding to class ID " + classID );
					#endif
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;
				}
				else 
				{
					if( keys.Count == 0 )
					{
						#if DEBUG
							Log( "There is no key in AccessFeatures in class corresponding to class ID " + classID );
						#endif
						featuresIDs = new int [1];
						featuresIDs [0] = NoValue;						
					}
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;					
				}
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			featuresIDs = new int [1];
			featuresIDs [0] = NoValue;
		}
		
		#if DEBUG
			Log( "access" );
			for( int i = 0; i < featuresIDs.Length; i++ )
			{
				Log( "featuresIDs [" + i + "]: " + featuresIDs [i]);
			}
		#endif	
		return featuresIDs;
	}

	// Get basic operations features IDs of class corresponding to classID
	public int [] GetBasicOperationsFeatures( int classID ) 
	{
		EiffelClassFactory classFactory;
		int [] featuresIDs;
		ICollection keys;
		int index;
		EiffelMethodFactory methodFactory;

		#if DEBUG
			Log( "GetBasicOperationsFeatures( " + classID + " )" );
		#endif
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
			{
				throw new Exception( "Class not ready." );
			}
			keys = classFactory.BasicOperations.Keys;

			if( keys != null )
			{
				if( keys.Count != 0 ) 
				{
					#if DEBUG
						Log( "There are basic operations in class corresponding to class ID " + classID );
					#endif
					featuresIDs = new int [keys.Count];
					index = 0;
					foreach( String key in keys )
					{
						#if DEBUG
							Log( "type: " + classFactory.BasicOperations [key].GetType().ToString() );
						#endif
						if( classFactory.BasicOperations [key].GetType().ToString() != "System.Reflection.RuntimeFieldInfo" )
						{
							methodFactory = ( EiffelMethodFactory )classFactory.BasicOperations [key];
							if( methodFactory != null )
							{
								if( classFactory.IsGeneratedInCurrent( methodFactory ) )
								{
									featuresIDs [index] = methodFactory.PolymorphIDs [0];
									index++;
								}
							}
							else
							{
								#if DEBUG
									Log( "EiffelMethodFactory is null for basic operations in class corresponding to class ID " + classID );
								#endif
							}
						}
						else
						{
							#if DEBUG
								Log( "This feature is an attribute (basic op)." );
							#endif
						}
					}
					if( ( featuresIDs.Length == 1 ) && ( featuresIDs [0] == 0 ) )
						featuresIDs [0] = NoValue;
				}
				else
				{
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;
				}
			}
			else
			{	
				if( keys == null )
				{ 
					#if DEBUG
						Log( "basic operations keys are null in class corresponding to class ID " + classID );
					#endif
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;
				}
				else 
				{
					if( keys.Count == 0 )
					{
						#if DEBUG
							Log( "There is no key in basic operations in class corresponding to class ID " + classID );
						#endif
						featuresIDs = new int [1];
						featuresIDs [0] = NoValue;						
					}
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;					
				}
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			featuresIDs = new int [1];
			featuresIDs [0] = NoValue;
		}
		
		#if DEBUG
		Log( "basic" );
			for( int i = 0; i < featuresIDs.Length; i++ )
				Log( "featuresIDs [" + i + "]: " + featuresIDs [i]);
		#endif	
		return featuresIDs;
	}
	
	// Get unary operators features IDs of class corresponding to classID
	public int [] GetUnaryOperatorsFeatures( int classID ) 
	{
		EiffelClassFactory classFactory;
		int [] featuresIDs;
		ICollection keys;
		int index;
		EiffelMethodFactory methodFactory;

		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );

			keys = classFactory.UnaryOperatorsFeatures.Keys;

			if( ( keys != null ) && ( keys.Count != 0 ) )
			{
				#if DEBUG
					Log( "There are unary operators in class corresponding to class ID " + classID );
				#endif
				featuresIDs = new int [keys.Count];
				index = 0;
				foreach( String key in keys )
				{
					#if DEBUG
						Log( "type: " + classFactory.UnaryOperatorsFeatures [key].GetType().ToString() );
					#endif
					if( classFactory.UnaryOperatorsFeatures [key].GetType().ToString() != "System.Reflection.RuntimeFieldInfo" )
					{
						methodFactory = ( EiffelMethodFactory )classFactory.UnaryOperatorsFeatures [key];
						if( methodFactory != null )
						{
							featuresIDs [index] = methodFactory.PolymorphIDs [0];
							index++;
						}
						else
						{
							#if DEBUG
								Log( "EiffelMethodFactory is null for unary operators in class corresponding to class ID " + classID );
							#endif
						}
					}
					else
					{
						#if DEBUG
							Log( "This feature is an attribute." );
						#endif
					}
				}
				if( ( featuresIDs.Length == 1 ) && ( featuresIDs [0] == 0 ) )
					featuresIDs [0] = NoValue;
			}
			else
			{	
				if( keys == null )
				{ 
					#if DEBUG
						Log( "unary operators keys are null in class corresponding to class ID " + classID );
					#endif
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;
				}
				else 
				{
					if( keys.Count == 0 )
					{
						#if DEBUG
							Log( "There is no key in unary operators in class corresponding to class ID " + classID );
						#endif
						featuresIDs = new int [1];
						featuresIDs [0] = NoValue;						
					}
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;					
				}
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			featuresIDs = new int [1];
			featuresIDs [0] = NoValue;
		}
		
		#if DEBUG
			Log( "unary" );
			for( int i = 0; i < featuresIDs.Length; i++ )
			{
				Log( "featuresIDs [" + i + "]: " + featuresIDs [i]);
			}
		#endif	
		return featuresIDs;
	}

	// Get binary operators features IDs of class corresponding to classID
	public int [] GetBinaryOperatorsFeatures( int classID ) 
	{
		EiffelClassFactory classFactory;
		int [] featuresIDs;
		ICollection keys;
		int index;
		EiffelMethodFactory methodFactory;

		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );

			keys = classFactory.BinaryOperatorsFeatures.Keys;

			if( ( keys != null ) && ( keys.Count != 0 ) )
			{
				#if DEBUG
					Log( "There are binary operators in class corresponding to class ID " + classID );
				#endif
				featuresIDs = new int [keys.Count];
				index = 0;
				foreach( String key in keys )
				{
					#if DEBUG
						Log( "type: " + classFactory.BinaryOperatorsFeatures [key].GetType().ToString() );
					#endif
					if( classFactory.BinaryOperatorsFeatures [key].GetType().ToString() != "System.Reflection.RuntimeFieldInfo" )
					{
						methodFactory = ( EiffelMethodFactory )classFactory.BinaryOperatorsFeatures [key];
						if( methodFactory != null )
						{
							featuresIDs [index] = methodFactory.PolymorphIDs [0];
							index++;
						}
						else
						{
							#if DEBUG
								Log( "EiffelMethodFactory is null for binary operators in class corresponding to class ID " + classID );
							#endif
						}
					}
					else
					{
						#if DEBUG
							Log( "This feature is an attribute." );
						#endif
					}
				}
				if( ( featuresIDs.Length == 1 ) && ( featuresIDs [0] == 0 ) )
					featuresIDs [0] = NoValue;
			}
			else
			{	
				if( keys == null )
				{ 
					#if DEBUG
						Log( "binary operators keys are null in class corresponding to class ID " + classID );
					#endif
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;
				}
				else 
				{
					if( keys.Count == 0 )
					{
						#if DEBUG
							Log( "There is no key in binary operators in class corresponding to class ID " + classID );
						#endif
						featuresIDs = new int [1];
						featuresIDs [0] = NoValue;						
					}
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;					
				}
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			featuresIDs = new int [1];
			featuresIDs [0] = NoValue;
		}
		
		#if DEBUG
			Log( "binary: " );
			for( int i = 0; i < featuresIDs.Length; i++ )
			{
				Log( "featuresIDs [" + i + "]: " + featuresIDs [i]);
			}
		#endif	
		return featuresIDs;
	}

	// Get element change features IDs of class corresponding to classID
	public int [] GetElementChangeFeatures( int classID ) 
	{
		EiffelClassFactory classFactory;
		int [] featuresIDs;
		ICollection keys;
		int index;
		EiffelMethodFactory methodFactory;

		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );

			keys = classFactory.ElementChangeFeatures.Keys;

			if( ( keys != null ) && ( keys.Count != 0 ) )
			{
				#if DEBUG
					Log( "There are element change features in class corresponding to class ID " + classID );
				#endif
				featuresIDs = new int [keys.Count];
				index = 0;
				foreach( String key in keys )
				{
					#if DEBUG
						Log( "type: " + classFactory.ElementChangeFeatures [key].GetType().ToString() );
					#endif
					if( classFactory.ElementChangeFeatures [key].GetType().ToString() != "System.Reflection.RuntimeFieldInfo" )
					{
						methodFactory = ( EiffelMethodFactory )classFactory.ElementChangeFeatures [key];
						if( methodFactory != null )
						{
							featuresIDs [index] = methodFactory.PolymorphIDs [0];
							index++;
						}
						else
						{
							#if DEBUG
								Log( "EiffelMethodFactory is null for element change features in class corresponding to class ID " + classID );
							#endif
						}
					}
					else
					{
						#if DEBUG
							Log( "This feature is an attribute." );
						#endif
					}
				}
				if( ( featuresIDs.Length == 1 ) && ( featuresIDs [0] == 0 ) )
					featuresIDs [0] = NoValue;
			}
			else
			{	
				if( keys == null )
				{ 
					#if DEBUG
						Log( "element change features keys are null in class corresponding to class ID " + classID );
					#endif
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;
				}
				else 
				{
					if( keys.Count == 0 )
					{
						#if DEBUG
							Log( "There is no key in element change features in class corresponding to class ID " + classID );
						#endif
						featuresIDs = new int [1];
						featuresIDs [0] = NoValue;						
					}
					featuresIDs = new int [1];
					featuresIDs [0] = NoValue;					
				}
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			featuresIDs = new int [1];
			featuresIDs [0] = NoValue;
		}
		
		#if DEBUG
			Log( "Elt change: " );
			for( int i = 0; i < featuresIDs.Length; i++ )
			{
				Log( "featuresIDs [" + i + "]: " + featuresIDs [i]);
			}
		#endif	
		return featuresIDs;
	}

	// Get routine name from `routineID' and `classID'.
	public String GetRoutineNameFromID( int classID, int routineID )
	{
		EiffelClassFactory classFactory;
		EiffelMethodFactory methodFactory;
		
		if( routineID == 0 )
			return NoFeature;
		else
		{
			classFactory = ( EiffelClassFactory )ClassTable [classID];
			if( classFactory != null ) 
			{
				if( !( classFactory.GenerationPrepared ) )
					throw new Exception( "Class not ready." );

				methodFactory = MethodFactoryFromID( classFactory, routineID );
				if( methodFactory != null )
					return( methodFactory.Name() );
				else
					return NoFeature;
			}
			else
				return NoFeature;
		}
	}
	
	// Get ancestors IDs from `classID'.
	public int [] GetAncestorsIDs( int classID ) 	
	{
		int [] ancestorsIDs;
		IList ancestors;
		int index;
		int i;
		
		if( ( ( EiffelClassFactory )ClassTable [classID] ) != null ) 
		{
			if( !(( EiffelClassFactory )ClassTable [classID] ).GenerationPrepared )
				throw new Exception( "Class not ready." );
				
			ancestors = ( ( EiffelClassFactory )ClassTable [classID] ).Parents;
			if( ( ancestors != null) && (ancestors.Count > 0 ) )
			{
				ancestorsIDs = new int [ancestors.Count];
				index = 0;
				for( i = 0; i < ancestors.Count; i++ )
				{
					ancestorsIDs [index] = ( int )ancestors [i];
					index++;
				}
			}
			else
			{
				ancestorsIDs = new int [1];
				ancestorsIDs [0] = NoValue;
			}			
		}
		else
		{
			ancestorsIDs = new int [1];
			ancestorsIDs [0] = NoValue;
		}

		return ancestorsIDs;
	}
	
	// Is feature corresponding to `feature_id' in class corresponding to `class_id' inherited?
	public bool IsInheritedFeature( int classID, int featureID )
	{
		EiffelClassFactory classFactory;
		EiffelMethodFactory methodFactory;
		IList parents;
		int i;
		EiffelClassFactory CurrentParent;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];	
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );
			
			if( ContainsRoutineID( classFactory, featureID ) )
			{
				methodFactory = FoundMethodFactory;
				if( methodFactory != null )
				{
					parents = classFactory.Parents;
					for( i = 0; i < parents.Count; i++ )
					{
						CurrentParent =( ( EiffelClassFactory )ClassTable [( int )parents [i]]);
						foreach( EiffelMethodFactory ParentMethod in CurrentParent.Routines )
						{
							if( ParentMethod.HasPolymorphID(methodFactory ))
								return true;
						}
					}
					return false;
				}
				else
					return false;			
			}
			else
				return false;
		}
		else
			return false;
	}
	
	// Is class corresponding to `classID' external?
	public bool IsExternal( int classID )
	{
		EiffelClassFactory classFactory;
		ArrayList NotIsExternalType;
		Type [] types;
		Assembly assembly;
		Module [] modules;
		int i, j;
		
		NotIsExternalType = new ArrayList();
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null ) 
		{
			if( !( classFactory.GenerationPrepared ) )
				throw new Exception( "Class not ready." );

			assembly = Assembly.LoadFrom( Name );

			modules = assembly.GetModules();
			for( i = 0; i < modules.Length; i++ )
			{
				types = modules [i].GetTypes();
				for( j = 0; j < types.Length; j++ )
				{
					if( ClassIDTable [types [j]] != null )
						NotIsExternalType.Add( (( EiffelClassFactory )ClassTable [( int )ClassIDTable [types [j]]] ).ID );
				}
			}
			return ( !( NotIsExternalType.Contains( classID ) ) );
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			return true;
		}
	}

	// Get .Net feature name from `routineID' and `classID'.
	public String GetDotNetFeatureName( int classID, int routineID )
	{
		EiffelClassFactory classFactory;
		EiffelMethodFactory methodFactory;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );
			
			if( ContainsRoutineID( classFactory, routineID ) )
			{
				methodFactory = FoundMethodFactory;
				if( methodFactory != null )
					return methodFactory.Info.Name;
				else
				{
					#if DEBUG
						Log( "EiffelMethodFactory is null for routine corresponding to routineID: " + routineID + " in class corresponding to class ID: " + classID );
					#endif
					return NoFeature;
				}
			}
			else
			{
				#if DEBUG
					Log( "Routine corresponding to ID: " + routineID + " has not been found in class corresponding to class ID: " + classID );
				#endif
				return NoFeature;
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			return NoFeature;
		}		
	}
	
	// Get parameters names of routine having routineID as unique identifier in class corresponding to classID
	public String [] GetDotNetParametersNames( int classID, int routineID )
	{
		EiffelClassFactory classFactory;
		String [] parametersNames;
		EiffelMethodFactory methodFactory;
		ParameterInfo [] parametersInfo;
		String argumentName;
		int i, j;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null )
		{
			if( !classFactory.GenerationPrepared )
				throw new Exception( "Class not ready." );
			
			if( ContainsRoutineID( classFactory, routineID ) )
			{
				methodFactory = FoundMethodFactory;
				if( methodFactory != null )
				{
					parametersInfo = methodFactory.Info.GetParameters();
					if( ( parametersInfo != null ) && ( parametersInfo.Length > 0 ) )
					{
						#if DEBUG
							Log( "parametersInfo.Length: " + parametersInfo.Length );
						#endif
						parametersNames = new String [parametersInfo.Length];
						for( i = 0; i < parametersInfo.Length; i++ )
				 		{
							// Some argument names are empty!!
							if( (( ParameterInfo )parametersInfo [i]).Name == null )
								argumentName = "Arg" + i;		
							else
								argumentName = (( ParameterInfo )parametersInfo [i]).Name;

							j = 2;
							while( classFactory.NameClash( argumentName ))
							{
								argumentName = argumentName.TrimEnd( classFactory.Digits );
								argumentName += j;
								j++;
							}	
							parametersNames [i] = argumentName;
						}
					}
					else
					{
						if( parametersInfo == null )
						{
							#if DEBUG
								Log( "ParameterInfo [] is null for method corresponding to routine ID: " + routineID + " in class corresponding to class ID : " + classID );
							#endif
							parametersNames = new String [1];
							parametersNames [0] = NoFeature;
						}
						else if( parametersInfo.Length == 0 )
						{
							#if DEBUG
								Log( "No parameters for method corresponding to routine ID: " + routineID + " in class corresponding to class ID : " + classID );
							#endif
							parametersNames = new String [1];
							parametersNames [0] = NoFeature;
						}
						else
						{
							parametersNames = new String [1];
							parametersNames [0] = NoFeature;
						}
					}
				}
				else
				{
					#if DEBUG
						Log( "EiffelMethodFactory is null for routine corresponding to routineID: " + routineID + " in class corresponding to class ID: " + classID );
					#endif
					parametersNames = new String [1];
					parametersNames [0] = NoFeature;
				}
			}
			else
			{
				#if DEBUG
					Log( "Routine corresponding to ID: " + routineID + " has not been found in class corresponding to class ID: " + classID );
				#endif
				parametersNames = new String [1];
				parametersNames [0] = NoFeature;
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			parametersNames = new String [1];
			parametersNames [0] = NoFeature;
		}
		return parametersNames;
	}

	// Get dot net attributes names which can be used in assertions for class corresponding to `classID'.
	public String GetDotNetAttributeName( int classID, String attributeName )
	{
		EiffelClassFactory classFactory;
		
		classFactory = ( EiffelClassFactory )ClassTable [classID];
		if( classFactory != null ) 
		{
			if( !( classFactory.GenerationPrepared ) )
				throw new Exception( "Class not ready." );
			if( classFactory.AttributesNames.ContainsValue( attributeName ) )
			{
				foreach( FieldInfo key in classFactory.AttributesNames.Keys )
				{
					if( ( String )classFactory.AttributesNames [key] == attributeName )
						return key.Name;
				}
				return NoFeature;
			}
			else
			{
				#if DEBUG
					Log( "Class corresponding to class ID: " + classID + " has no attribute called " + attributeName );
				#endif
				return NoFeature;
			}
		}
		else
		{
			#if DEBUG
				Log( "EiffelClassFactory is null for class corresponding to class ID: " + classID );
			#endif
			return NoFeature;
		}	
	}


/*
 * Feature used to generate the project settings (Ace file)
 */

	// Dependencies of local assemblies with filename `Filename'
	public String [] AssemblyDependencies( String Filename )
	{
		Assembly assembly, aDependency;;
		ArrayList dependencies;
		String [] assemblyDependencies, NameAndDependencies;
		int i, j;
		String aLocation, aFullName;
		
		try
		{
			assembly = Assembly.LoadFrom( Filename );
			if( assembly != null )
			{
				dependencies = InternAssemblyDependencies( assembly );
				if( dependencies != null )
				{
					assemblyDependencies = new String [dependencies.Count];
					for( i = 0; i < dependencies.Count; i++ )
						assemblyDependencies [i] = ( ( Assembly )dependencies [i] ).Location;

					NameAndDependencies = new String [2 * assemblyDependencies.Length];
					j = 0;
					for( i = 0; i < assemblyDependencies.Length; i++ )
					{
						aLocation = ( String )assemblyDependencies [i];
						aDependency = Assembly.LoadFrom( aLocation );
						aFullName = aDependency.FullName;
						aFullName = aFullName.Substring( 0, aFullName.IndexOf( "Version" ) );
						aFullName = aFullName.TrimEnd();
						aFullName = aFullName.Replace( ",", "" );
						NameAndDependencies [j] = aFullName;

						NameAndDependencies [j + 1] = aLocation;
						j = j + 2;
					}
					return NameAndDependencies;
				}
				else
					return null;
			}
			else
				return null;
		}
		catch
		{
			return null;
		}
	}
	
	
/*
 * Implementation
 *
 */
	// Does `classFactory' contain a feature with ID `routineID'?
	protected bool ContainsRoutineID( EiffelClassFactory classFactory, int routineID )
	{
		if( InternalContainsRoutineID( classFactory.AccessFeatures, routineID ) )
			return true;
		else
		{
			if( InternalContainsRoutineID( classFactory.BasicOperations, routineID ) )
				return true;
			else
			{
				if( InternalContainsRoutineID( classFactory.UnaryOperatorsFeatures, routineID ) )
					return true;
				else
				{
					if( InternalContainsRoutineID( classFactory.BinaryOperatorsFeatures, routineID ) )
						return true;
					else
					{
						if( InternalContainsRoutineID( classFactory.SpecialFeatures, routineID ) )
							return true;
						else
						{
							if( InternalContainsRoutineID( classFactory.ImplementationFeatures, routineID ) )
								return true;
							else
								return ( InternalContainsRoutineID( classFactory.ElementChangeFeatures, routineID ) );
						}
					}
				}
			}
		}
	}
	
	// Does `classFactory' contain a feature with ID `routineID'?
	protected bool InternalContainsRoutineID( Hashtable Features, int routineID )
	{
		IEnumerator ValuesEnumerator;
		Object CurrentValue;
		EiffelMethodFactory MethodFactory;
		
		ValuesEnumerator = Features.Values.GetEnumerator();		
		while( ValuesEnumerator.MoveNext() )
		{
			CurrentValue = ValuesEnumerator.Current;
			if( CurrentValue.GetType().ToString() != "System.Reflection.RuntimeFieldInfo" )
			{
				MethodFactory = ( EiffelMethodFactory )CurrentValue;
				if( MethodFactory.PolymorphIDs [0] == routineID )
				{
					FoundMethodFactory = MethodFactory;
					return true;
				}
			}
		}
		return false;
	}
	
	// If `InternalContainsRoutineID' returns true, corresponding `EiffelMethodFactory'
	protected EiffelMethodFactory FoundMethodFactory;
	
	// `EiffelMethodFactory' corresponding to `routineID' in class corresponding to `classFactory'
	protected EiffelMethodFactory MethodFactoryFromID( EiffelClassFactory classFactory, int routineID )
	{
		if( ContainsRoutineID( classFactory, routineID ) )
		{
			if( FoundMethodFactory != null )
				return FoundMethodFactory;
			else
				throw new Exception( "routineID found but null MethodFactory" );
		}
		else
			return null;			
	}

	// Internal implementation of `LocalAssemblyDependencies'
	protected ArrayList InternAssemblyDependencies( Assembly assembly )
	{
		ArrayList dependencies;
		AssemblyName [] references;
		int i, Added;
		AssemblyName aDependency;
		Assembly newAssembly;
		
		dependencies = new ArrayList();
		references = assembly.GetReferencedAssemblies();
		if( references != null )
		{			
			for( i = 0; i < references.Length; i ++ )
			{
				aDependency = references [i];
				if( !( Done.Contains( aDependency.FullName ) )&& !( aDependency.FullName.Equals( "Microsoft.VisualC, Version=7.0.9249.59748, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" ) ) )
				{
					newAssembly = Assembly.Load( aDependency );
					Added = Done.Add( aDependency.FullName );
					dependencies.AddRange( InternAssemblyDependencies( newAssembly ) );
					Added = dependencies.Add( newAssembly );
				}
			}
		}
		return dependencies;
	}
	
	// Loaded assemblies, used in `InternAssemblyDependencies'
	protected ArrayList Done;
	
	// Used in GetClassIDFromName, GetRoutineID, GetTypeIDFromName and GetAttributeReturnTypeID in case name is not found.
	static private int NoValue = -1;
	
	// Used in GetDotNetClassName and GetAccessFeatureForAssertionsNameFromID in case ID is not found .
	static private String NoFeature = "";

	// Prefix used to build attributes setters
	//static private String PropertySetPrefix = "set_";
	
	// .Net assembly name (with absolute path)
	private String Name;
	
	//  Path to folder where generated code will be stored
	private String Path;
	
	#if DEBUG
		// Log debug information
		protected void Log( String text )
		{
			FileStream fs = new FileStream("c:\\log.txt", FileMode.Append, FileAccess.Write);
			StreamWriter s = new StreamWriter( fs );
			s.WriteLine(text);
			s.Close();
		}	
	#endif
}
