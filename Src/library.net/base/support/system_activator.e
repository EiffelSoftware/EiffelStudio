indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Activator"

frozen external class
	SYSTEM_ACTIVATOR

create {NONE}

feature -- Basic Operations

	frozen create_instance_type_array_object (type: SYSTEM_TYPE; args: ARRAY [ANY]): ANY is
		external
			"IL static signature (System.Type, System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_string_string_array_object (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_type_binding_flags_binder_array_object_culture_info_array_object (type: SYSTEM_TYPE; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL static signature (System.Type, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance (type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Type): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_type_binding_flags_binder_array_object_culture_info (type: SYSTEM_TYPE; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL static signature (System.Type, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_from_string_string_boolean (assembly_file: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_string_string (assembly_name: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstance"
		end

	frozen get_object (type: SYSTEM_TYPE; url: STRING): ANY is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Activator"
		alias
			"GetObject"
		end

	frozen create_instance_from_string_string_array_object (assembly_file: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_from (assembly_file: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_type_array_object_array_object (type: SYSTEM_TYPE; args: ARRAY [ANY]; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL static signature (System.Type, System.Object[], System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_string_string_boolean (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateInstance"
		end

	frozen get_object_type_string_object (type: SYSTEM_TYPE; url: STRING; state: ANY): ANY is
		external
			"IL static signature (System.Type, System.String, System.Object): System.Object use System.Activator"
		alias
			"GetObject"
		end

	frozen create_com_instance_from (assembly_name: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.Activator"
		alias
			"CreateComInstanceFrom"
		end

end -- class SYSTEM_ACTIVATOR
