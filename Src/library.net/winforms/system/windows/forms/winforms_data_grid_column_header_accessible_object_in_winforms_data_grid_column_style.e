indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_GRID_COLUMN_HEADER_ACCESSIBLE_OBJECT_IN_WINFORMS_DATA_GRID_COLUMN_STYLE

inherit
	WINFORMS_ACCESSIBLE_OBJECT
		redefine
			navigate,
			get_role,
			get_parent,
			get_name,
			get_bounds
		end
	IREFLECT
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
	ACCESS_IACCESSIBLE
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

create
	make_winforms_data_grid_column_header_accessible_object_in_winforms_data_grid_column_style

feature {NONE} -- Initialization

	frozen make_winforms_data_grid_column_header_accessible_object_in_winforms_data_grid_column_style (owner: WINFORMS_DATA_GRID_COLUMN_STYLE) is
		external
			"IL creator signature (System.Windows.Forms.DataGridColumnStyle) use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		end

feature -- Access

	get_parent: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		alias
			"get_Parent"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		alias
			"get_Name"
		end

	get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		alias
			"get_Bounds"
		end

	get_role: WINFORMS_ACCESSIBLE_ROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		alias
			"get_Role"
		end

feature -- Basic Operations

	navigate (navdir: WINFORMS_ACCESSIBLE_NAVIGATION): WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (System.Windows.Forms.AccessibleNavigation): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		alias
			"Navigate"
		end

feature {NONE} -- Implementation

	frozen get_owner: WINFORMS_DATA_GRID_COLUMN_STYLE is
		external
			"IL signature (): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.DataGridColumnStyle+DataGridColumnHeaderAccessibleObject"
		alias
			"get_Owner"
		end

end -- class WINFORMS_DATA_GRID_COLUMN_HEADER_ACCESSIBLE_OBJECT_IN_WINFORMS_DATA_GRID_COLUMN_STYLE
