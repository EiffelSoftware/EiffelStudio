indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Binder"

deferred external class
	SYSTEM_REFLECTION_BINDER

feature -- Basic Operations

	select_property (binding_attr: INTEGER; match: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO]; returnType: SYSTEM_TYPE; indexes: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
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
			"IL deferred signature (enum System.Reflection.BindingFlags, System.Reflection.PropertyInfo[], System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Binder"
		alias
			"SelectProperty"
		end

	select_method (binding_attr: INTEGER; match: ARRAY [SYSTEM_REFLECTION_METHODBASE]; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODBASE is
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
			"IL deferred signature (enum System.Reflection.BindingFlags, System.Reflection.MethodBase[], System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodBase use System.Reflection.Binder"
		alias
			"SelectMethod"
		end

	change_type (value: ANY; type: SYSTEM_TYPE; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL deferred signature (System.Object, System.Type, System.Globalization.CultureInfo): System.Object use System.Reflection.Binder"
		alias
			"ChangeType"
		end

	bind_to_field (binding_attr: INTEGER; match: ARRAY [SYSTEM_REFLECTION_FIELDINFO]; value: ANY; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_REFLECTION_FIELDINFO is
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
			"IL deferred signature (enum System.Reflection.BindingFlags, System.Reflection.FieldInfo[], System.Object, System.Globalization.CultureInfo): System.Reflection.FieldInfo use System.Reflection.Binder"
		alias
			"BindToField"
		end

	bind_to_method (binding_attr: INTEGER; match: ARRAY [SYSTEM_REFLECTION_METHODBASE]; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; names: ARRAY [STRING]; state: ANY): SYSTEM_REFLECTION_METHODBASE is
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
			"IL deferred signature (enum System.Reflection.BindingFlags, System.Reflection.MethodBase[], System.Object[]&, System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[], System.Object&): System.Reflection.MethodBase use System.Reflection.Binder"
		alias
			"BindToMethod"
		end

	reorder_argument_array (args: ARRAY [ANY]; state: ANY) is
		external
			"IL deferred signature (System.Object[]&, System.Object): System.Void use System.Reflection.Binder"
		alias
			"ReorderArgumentArray"
		end

end -- class SYSTEM_REFLECTION_BINDER
