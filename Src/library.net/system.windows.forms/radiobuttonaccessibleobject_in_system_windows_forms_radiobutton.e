indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.RadioButton+RadioButtonAccessibleObject"

external class
	RADIOBUTTONACCESSIBLEOBJECT_IN_SYSTEM_WINDOWS_FORMS_RADIOBUTTON

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
			do_default_action,
			get_state,
			get_role,
			get_default_action
		end

create
	make_radiobuttonaccessibleobject

feature {NONE} -- Initialization

	frozen make_radiobuttonaccessibleobject (owner: SYSTEM_WINDOWS_FORMS_RADIOBUTTON) is
		external
			"IL creator signature (System.Windows.Forms.RadioButton) use System.Windows.Forms.RadioButton+RadioButtonAccessibleObject"
		end

feature -- Access

	get_default_action: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.RadioButton+RadioButtonAccessibleObject"
		alias
			"get_DefaultAction"
		end

	get_state: SYSTEM_WINDOWS_FORMS_ACCESSIBLESTATES is
		external
			"IL signature (): System.Windows.Forms.AccessibleStates use System.Windows.Forms.RadioButton+RadioButtonAccessibleObject"
		alias
			"get_State"
		end

	get_role: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.RadioButton+RadioButtonAccessibleObject"
		alias
			"get_Role"
		end

feature -- Basic Operations

	do_default_action is
		external
			"IL signature (): System.Void use System.Windows.Forms.RadioButton+RadioButtonAccessibleObject"
		alias
			"DoDefaultAction"
		end

end -- class RADIOBUTTONACCESSIBLEOBJECT_IN_SYSTEM_WINDOWS_FORMS_RADIOBUTTON
