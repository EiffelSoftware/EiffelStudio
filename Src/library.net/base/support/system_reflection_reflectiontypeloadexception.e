indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ReflectionTypeLoadException"

frozen external class
	SYSTEM_REFLECTION_REFLECTIONTYPELOADEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_reflectiontypeloadexception,
	make_reflectiontypeloadexception_1

feature {NONE} -- Initialization

	frozen make_reflectiontypeloadexception (classes: ARRAY [SYSTEM_TYPE]; exceptions: ARRAY [SYSTEM_EXCEPTION]) is
		external
			"IL creator signature (System.Type[], System.Exception[]) use System.Reflection.ReflectionTypeLoadException"
		end

	frozen make_reflectiontypeloadexception_1 (classes: ARRAY [SYSTEM_TYPE]; exceptions: ARRAY [SYSTEM_EXCEPTION]; message: STRING) is
		external
			"IL creator signature (System.Type[], System.Exception[], System.String) use System.Reflection.ReflectionTypeLoadException"
		end

feature -- Access

	frozen get_loader_exceptions: ARRAY [SYSTEM_EXCEPTION] is
		external
			"IL signature (): System.Exception[] use System.Reflection.ReflectionTypeLoadException"
		alias
			"get_LoaderExceptions"
		end

	frozen get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.ReflectionTypeLoadException"
		alias
			"get_Types"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.ReflectionTypeLoadException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_REFLECTION_REFLECTIONTYPELOADEXCEPTION
