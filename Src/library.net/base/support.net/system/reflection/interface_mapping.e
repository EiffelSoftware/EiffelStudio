indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.InterfaceMapping"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTERFACE_MAPPING

inherit
	VALUE_TYPE

feature -- Access

	frozen target_type: TYPE is
		external
			"IL field signature :System.Type use System.Reflection.InterfaceMapping"
		alias
			"TargetType"
		end

	frozen interface_type: TYPE is
		external
			"IL field signature :System.Type use System.Reflection.InterfaceMapping"
		alias
			"InterfaceType"
		end

	frozen target_methods: NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL field signature :System.Reflection.MethodInfo[] use System.Reflection.InterfaceMapping"
		alias
			"TargetMethods"
		end

	frozen interface_methods: NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL field signature :System.Reflection.MethodInfo[] use System.Reflection.InterfaceMapping"
		alias
			"InterfaceMethods"
		end

end -- class INTERFACE_MAPPING
