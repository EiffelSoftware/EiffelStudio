indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.BindingMemberInfo"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_BINDINGMEMBERINFO

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal
		end



feature -- Initialization

	frozen make_bindingmemberinfo (data_member: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.BindingMemberInfo"
		end

feature -- Access

	frozen get_binding_member: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingMemberInfo"
		alias
			"get_BindingMember"
		end

	frozen get_binding_field: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingMemberInfo"
		alias
			"get_BindingField"
		end

	frozen get_binding_path: STRING is
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

	is_equal (other_object: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.BindingMemberInfo"
		alias
			"Equals"
		end

end -- class SYSTEM_WINDOWS_FORMS_BINDINGMEMBERINFO
