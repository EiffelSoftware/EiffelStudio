indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ReflectionPermissionFlag"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	REFLECTION_PERMISSION_FLAG

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen type_information: REFLECTION_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionFlag"
		alias
			"1"
		end

	frozen member_access: REFLECTION_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionFlag"
		alias
			"2"
		end

	frozen no_flags: REFLECTION_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionFlag"
		alias
			"0"
		end

	frozen reflection_emit: REFLECTION_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionFlag"
		alias
			"4"
		end

	frozen all_flags: REFLECTION_PERMISSION_FLAG is
		external
			"IL enum signature :System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermissionFlag"
		alias
			"7"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class REFLECTION_PERMISSION_FLAG
