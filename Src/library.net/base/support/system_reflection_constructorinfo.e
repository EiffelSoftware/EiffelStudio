indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.ConstructorInfo"

deferred external class
	SYSTEM_REFLECTION_CONSTRUCTORINFO

inherit
	SYSTEM_REFLECTION_METHODBASE
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	frozen type_constructor_name: STRING is
		external
			"IL static_field signature :System.String use System.Reflection.ConstructorInfo"
		alias
			"TypeConstructorName"
		end

	get_member_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.MemberTypes use System.Reflection.ConstructorInfo"
		alias
			"get_MemberType"
		end

	frozen constructor_name: STRING is
		external
			"IL static_field signature :System.String use System.Reflection.ConstructorInfo"
		alias
			"ConstructorName"
		end

feature -- Basic Operations

	invoke_for_constructor_with_binder (invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; parameters: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
			-- Valid values for `invoke_attr' are a combination of the following values:
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
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & invoke_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.ConstructorInfo"
		alias
			"Invoke"
		end

	frozen invoke_with_arguments_and_constraints (parameters: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object[]): System.Object use System.Reflection.ConstructorInfo"
		alias
			"Invoke"
		end

end -- class SYSTEM_REFLECTION_CONSTRUCTORINFO
