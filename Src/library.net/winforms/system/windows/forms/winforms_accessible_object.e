indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AccessibleObject"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_ACCESSIBLE_OBJECT

inherit
	MARSHAL_BY_REF_OBJECT
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
	make_winforms_accessible_object

feature {NONE} -- Initialization

	frozen make_winforms_accessible_object is
		external
			"IL creator use System.Windows.Forms.AccessibleObject"
		end

feature -- Access

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Value"
		end

	get_role: WINFORMS_ACCESSIBLE_ROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.AccessibleObject"
		alias
			"get_Role"
		end

	get_keyboard_shortcut: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_KeyboardShortcut"
		end

	get_parent: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"get_Parent"
		end

	get_state: WINFORMS_ACCESSIBLE_STATES is
		external
			"IL signature (): System.Windows.Forms.AccessibleStates use System.Windows.Forms.AccessibleObject"
		alias
			"get_State"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Name"
		end

	get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.AccessibleObject"
		alias
			"get_Bounds"
		end

	get_default_action: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_DefaultAction"
		end

	get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Description"
		end

	get_help: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Help"
		end

feature -- Element Change

	set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"set_Name"
		end

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"set_Value"
		end

feature -- Basic Operations

	navigate (navdir: WINFORMS_ACCESSIBLE_NAVIGATION): WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (System.Windows.Forms.AccessibleNavigation): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"Navigate"
		end

	hit_test (x: INTEGER; y: INTEGER): WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"HitTest"
		end

	do_default_action is
		external
			"IL signature (): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"DoDefaultAction"
		end

	get_selected: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"GetSelected"
		end

	get_child (index: INTEGER): WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (System.Int32): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"GetChild"
		end

	get_child_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.AccessibleObject"
		alias
			"GetChildCount"
		end

	select_ (flags: WINFORMS_ACCESSIBLE_SELECTION) is
		external
			"IL signature (System.Windows.Forms.AccessibleSelection): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Select"
		end

	get_help_topic (file_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String&): System.Int32 use System.Windows.Forms.AccessibleObject"
		alias
			"GetHelpTopic"
		end

	get_focused: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"GetFocused"
		end

feature {NONE} -- Implementation

	frozen accessibility_iaccessible_get_acc_help (child_id: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accHelp"
		end

	frozen accessibility_iaccessible_get_acc_name (child_id: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accName"
		end

	frozen use_std_accessible_objects (handle: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"UseStdAccessibleObjects"
		end

	frozen accessibility_iaccessible_acc_select (flags_select: INTEGER; child_id: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accSelect"
		end

	frozen accessibility_iaccessible_set_acc_name (child_id: SYSTEM_OBJECT; new_name: SYSTEM_STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.set_accName"
		end

	frozen accessibility_iaccessible_get_acc_default_action (child_id: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accDefaultAction"
		end

	frozen system_reflection_ireflect_get_properties (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetProperties"
		end

	frozen system_reflection_ireflect_get_member (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMember"
		end

	frozen accessibility_iaccessible_get_acc_role (child_id: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accRole"
		end

	frozen accessibility_iaccessible_set_acc_value (child_id: SYSTEM_OBJECT; new_value: SYSTEM_STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.set_accValue"
		end

	frozen system_reflection_ireflect_get_underlying_system_type: TYPE is
		external
			"IL signature (): System.Type use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.get_UnderlyingSystemType"
		end

	frozen accessibility_iaccessible_acc_do_default_action (child_id: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accDoDefaultAction"
		end

	frozen system_reflection_ireflect_get_method (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMethod"
		end

	frozen get_property_string_binding_flags_binder (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetProperty"
		end

	frozen system_reflection_ireflect_get_field (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetField"
		end

	frozen use_std_accessible_objects_int_ptr_int32 (handle: POINTER; objid: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"UseStdAccessibleObjects"
		end

	frozen accessibility_iaccessible_get_acc_focus: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accFocus"
		end

	frozen system_reflection_ireflect_get_fields (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetFields"
		end

	frozen accessibility_iaccessible_get_acc_selection: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accSelection"
		end

	frozen accessibility_iaccessible_get_acc_description (child_id: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accDescription"
		end

	frozen get_method_string_binding_flags_binder (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMethod"
		end

	frozen accessibility_iaccessible_get_acc_child (child_id: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accChild"
		end

	frozen accessibility_iaccessible_get_acc_child_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accChildCount"
		end

	frozen accessibility_iaccessible_get_acc_help_topic (psz_help_file: SYSTEM_STRING; child_id: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.String&, System.Object): System.Int32 use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accHelpTopic"
		end

	frozen accessibility_iaccessible_get_acc_state (child_id: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accState"
		end

	frozen system_reflection_ireflect_invoke_member (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; named_parameters: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.InvokeMember"
		end

	frozen accessibility_iaccessible_get_acc_parent: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accParent"
		end

	frozen accessibility_iaccessible_acc_navigate (nav_dir: INTEGER; child_id: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32, System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accNavigate"
		end

	frozen accessibility_iaccessible_get_acc_value (child_id: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accValue"
		end

	frozen system_reflection_ireflect_get_property (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetProperty"
		end

	frozen system_reflection_ireflect_get_methods (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMethods"
		end

	frozen accessibility_iaccessible_acc_location (px_left: INTEGER; py_top: INTEGER; pcx_width: INTEGER; pcy_height: INTEGER; child_id: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32&, System.Int32&, System.Int32&, System.Int32&, System.Object): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accLocation"
		end

	frozen accessibility_iaccessible_acc_hit_test (x_left: INTEGER; y_top: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32, System.Int32): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accHitTest"
		end

	frozen accessibility_iaccessible_get_acc_keyboard_shortcut (child_id: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accKeyboardShortcut"
		end

	frozen system_reflection_ireflect_get_members (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMembers"
		end

end -- class WINFORMS_ACCESSIBLE_OBJECT
