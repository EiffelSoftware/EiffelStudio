indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Activator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ACTIVATOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen create_instance_type_array_object (type: TYPE; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_string_string_array_object (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_type_binding_flags_binder_array_object_culture_info_array_object (type: TYPE; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance (type: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_type_binding_flags_binder_array_object_culture_info (type: TYPE; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_from_string_string_boolean (assembly_file: SYSTEM_STRING; type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]; security_info: EVIDENCE): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_type_boolean (type: TYPE; non_public: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Boolean): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_string_string (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstance"
		end

	frozen get_object (type: TYPE; url: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Activator"
		alias
			"GetObject"
		end

	frozen create_instance_from_string_string_array_object (assembly_file: SYSTEM_STRING; type_name: SYSTEM_STRING; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_from (assembly_file: SYSTEM_STRING; type_name: SYSTEM_STRING): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_type_array_object_array_object (type: TYPE; args: NATIVE_ARRAY [SYSTEM_OBJECT]; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Object[], System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_string_string_boolean (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]; security_info: EVIDENCE): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstance"
		end

	frozen get_object_type_string_object (type: TYPE; url: SYSTEM_STRING; state: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String, System.Object): System.Object use System.Activator"
		alias
			"GetObject"
		end

	frozen create_com_instance_from (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): OBJECT_HANDLE is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateComInstanceFrom"
		end

end -- class ACTIVATOR
