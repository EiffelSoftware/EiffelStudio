indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen create_instance_type_binding_flags_binder_array_object_culture_info_array_object (type: SYSTEM_TYPE; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]): ANY is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL static signature (System.Type, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[]): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance (type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Type): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_type_binding_flags_binder_array_object_culture_info (type: SYSTEM_TYPE; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL static signature (System.Type, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Activator"
		alias
			"CreateInstance"
		end

	frozen create_instance_from_string_string_boolean (assembly_file: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL static signature (System.String, System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.Activator"
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

	frozen create_instance_string_string_boolean (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL static signature (System.String, System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.Activator"
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
