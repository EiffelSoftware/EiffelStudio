indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ReflectionTypeLoadException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REFLECTION_TYPE_LOAD_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_reflection_type_load_exception_1,
	make_reflection_type_load_exception

feature {NONE} -- Initialization

	frozen make_reflection_type_load_exception_1 (classes: NATIVE_ARRAY [TYPE]; exceptions: NATIVE_ARRAY [EXCEPTION]; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type[], System.Exception[], System.String) use System.Reflection.ReflectionTypeLoadException"
		end

	frozen make_reflection_type_load_exception (classes: NATIVE_ARRAY [TYPE]; exceptions: NATIVE_ARRAY [EXCEPTION]) is
		external
			"IL creator signature (System.Type[], System.Exception[]) use System.Reflection.ReflectionTypeLoadException"
		end

feature -- Access

	frozen get_loader_exceptions: NATIVE_ARRAY [EXCEPTION] is
		external
			"IL signature (): System.Exception[] use System.Reflection.ReflectionTypeLoadException"
		alias
			"get_LoaderExceptions"
		end

	frozen get_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.ReflectionTypeLoadException"
		alias
			"get_Types"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.ReflectionTypeLoadException"
		alias
			"GetObjectData"
		end

end -- class REFLECTION_TYPE_LOAD_EXCEPTION
