indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DomainUpDown+DomainUpDownAccessibleObject"

external class
	DOMAINUPDOWNACCESSIBLEOBJECT_IN_SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN

inherit
	SYSTEM_REFLECTION_IREFLECT
		rename
			get_underlying_system_type as system_reflection_ireflect_get_underlying_system_type,
			invoke_member as system_reflection_ireflect_invoke_member,
			get_members as system_reflection_ireflect_get_members,
			get_member as system_reflection_ireflect_get_member,
			get_properties as system_reflection_ireflect_get_properties,
			get_property as system_reflection_ireflect_get_property,
			get_fields as system_reflection_ireflect_get_fields,
			get_field as system_reflection_ireflect_get_field,
			get_methods as system_reflection_ireflect_get_methods,
			get_method as system_reflection_ireflect_get_method
		end
	ACCESSIBILITY_IACCESSIBLE
		rename
			set_acc_value as accessibility_iaccessible_set_acc_value,
			set_acc_name as accessibility_iaccessible_set_acc_name,
			get_acc_value as accessibility_iaccessible_get_acc_value,
			get_acc_state as accessibility_iaccessible_get_acc_state,
			get_acc_selection as accessibility_iaccessible_get_acc_selection,
			get_acc_role as accessibility_iaccessible_get_acc_role,
			get_acc_parent as accessibility_iaccessible_get_acc_parent,
			get_acc_name as accessibility_iaccessible_get_acc_name,
			get_acc_keyboard_shortcut as accessibility_iaccessible_get_acc_keyboard_shortcut,
			get_acc_help_topic as accessibility_iaccessible_get_acc_help_topic,
			get_acc_help as accessibility_iaccessible_get_acc_help,
			get_acc_focus as accessibility_iaccessible_get_acc_focus,
			get_acc_description as accessibility_iaccessible_get_acc_description,
			get_acc_default_action as accessibility_iaccessible_get_acc_default_action,
			get_acc_child_count as accessibility_iaccessible_get_acc_child_count,
			get_acc_child as accessibility_iaccessible_get_acc_child,
			acc_select as accessibility_iaccessible_acc_select,
			acc_navigate as accessibility_iaccessible_acc_navigate,
			acc_location as accessibility_iaccessible_acc_location,
			acc_hit_test as accessibility_iaccessible_acc_hit_test,
			acc_do_default_action as accessibility_iaccessible_acc_do_default_action
		end
	CONTROLACCESSIBLEOBJECT_IN_SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			get_child_count,
			get_child,
			get_role
		end

create
	make_domainupdownaccessibleobject

feature {NONE} -- Initialization

	frozen make_domainupdownaccessibleobject (owner: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.Control) use System.Windows.Forms.DomainUpDown+DomainUpDownAccessibleObject"
		end

feature -- Access

	get_role: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.DomainUpDown+DomainUpDownAccessibleObject"
		alias
			"get_Role"
		end

feature -- Basic Operations

	get_child_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DomainUpDown+DomainUpDownAccessibleObject"
		alias
			"GetChildCount"
		end

	get_child (index: INTEGER): SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (System.Int32): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DomainUpDown+DomainUpDownAccessibleObject"
		alias
			"GetChild"
		end

end -- class DOMAINUPDOWNACCESSIBLEOBJECT_IN_SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN
