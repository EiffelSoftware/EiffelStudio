indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.InterfaceMapping"

frozen expanded external class
	SYSTEM_REFLECTION_INTERFACEMAPPING

inherit
	VALUE_TYPE

feature -- Access

	frozen target_type: SYSTEM_TYPE is
		external
			"IL field signature :System.Type use System.Reflection.InterfaceMapping"
		alias
			"TargetType"
		end

	frozen interface_type: SYSTEM_TYPE is
		external
			"IL field signature :System.Type use System.Reflection.InterfaceMapping"
		alias
			"InterfaceType"
		end

	frozen target_methods: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL field signature :System.Reflection.MethodInfo[] use System.Reflection.InterfaceMapping"
		alias
			"TargetMethods"
		end

	frozen interface_methods: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL field signature :System.Reflection.MethodInfo[] use System.Reflection.InterfaceMapping"
		alias
			"InterfaceMethods"
		end

end -- class SYSTEM_REFLECTION_INTERFACEMAPPING
