indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.BindingMemberInfo"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	WINFORMS_BINDING_MEMBER_INFO

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Initialization

	frozen make_winforms_binding_member_info (data_member: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.BindingMemberInfo"
		end

feature -- Access

	frozen get_binding_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingMemberInfo"
		alias
			"get_BindingMember"
		end

	frozen get_binding_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingMemberInfo"
		alias
			"get_BindingField"
		end

	frozen get_binding_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingMemberInfo"
		alias
			"get_BindingPath"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.BindingMemberInfo"
		alias
			"GetHashCode"
		end

	equals (other_object: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.BindingMemberInfo"
		alias
			"Equals"
		end

end -- class WINFORMS_BINDING_MEMBER_INFO
