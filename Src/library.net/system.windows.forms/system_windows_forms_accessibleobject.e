indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AccessibleObject"

external class
	SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT

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
	SYSTEM_MARSHALBYREFOBJECT

create
	make_accessibleobject

feature {NONE} -- Initialization

	frozen make_accessibleobject is
		external
			"IL creator use System.Windows.Forms.AccessibleObject"
		end

feature -- Access

	get_value: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Value"
		end

	get_role: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.AccessibleObject"
		alias
			"get_Role"
		end

	get_keyboard_shortcut: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_KeyboardShortcut"
		end

	get_parent: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"get_Parent"
		end

	get_state: SYSTEM_WINDOWS_FORMS_ACCESSIBLESTATES is
		external
			"IL signature (): System.Windows.Forms.AccessibleStates use System.Windows.Forms.AccessibleObject"
		alias
			"get_State"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Name"
		end

	get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.AccessibleObject"
		alias
			"get_Bounds"
		end

	get_default_action: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_DefaultAction"
		end

	get_description: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Description"
		end

	get_help: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"get_Help"
		end

feature -- Element Change

	set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"set_Name"
		end

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"set_Value"
		end

feature -- Basic Operations

	navigate (navdir: SYSTEM_WINDOWS_FORMS_ACCESSIBLENAVIGATION): SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (System.Windows.Forms.AccessibleNavigation): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"Navigate"
		end

	hit_test (x: INTEGER; y: INTEGER): SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
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

	get_selected: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"GetSelected"
		end

	get_child (index: INTEGER): SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
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

	Select_ (flags: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION) is
		external
			"IL signature (System.Windows.Forms.AccessibleSelection): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Select"
		end

	get_help_topic (file_name: STRING): INTEGER is
		external
			"IL signature (System.String&): System.Int32 use System.Windows.Forms.AccessibleObject"
		alias
			"GetHelpTopic"
		end

	get_focused: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.AccessibleObject"
		alias
			"GetFocused"
		end

feature {NONE} -- Implementation

	frozen accessibility_iaccessible_get_acc_help (child_id: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accHelp"
		end

	frozen accessibility_iaccessible_get_acc_name (child_id: ANY): STRING is
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

	frozen accessibility_iaccessible_acc_select (flags_select: INTEGER; child_id: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accSelect"
		end

	frozen accessibility_iaccessible_set_acc_name (child_id: ANY; new_name: STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.set_accName"
		end

	frozen accessibility_iaccessible_get_acc_default_action (child_id: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accDefaultAction"
		end

	frozen system_reflection_ireflect_get_properties (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetProperties"
		end

	frozen system_reflection_ireflect_get_member (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMember"
		end

	frozen accessibility_iaccessible_get_acc_role (child_id: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accRole"
		end

	frozen accessibility_iaccessible_set_acc_value (child_id: ANY; new_value: STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.set_accValue"
		end

	frozen system_reflection_ireflect_get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.get_UnderlyingSystemType"
		end

	frozen accessibility_iaccessible_acc_do_default_action (child_id: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accDoDefaultAction"
		end

	frozen system_reflection_ireflect_get_method (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMethod"
		end

	frozen get_property_string_binding_flags_binder (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetProperty"
		end

	frozen system_reflection_ireflect_get_field (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_FIELDINFO is
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

	frozen accessibility_iaccessible_get_acc_focus: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accFocus"
		end

	frozen system_reflection_ireflect_get_fields (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetFields"
		end

	frozen accessibility_iaccessible_get_acc_selection: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accSelection"
		end

	frozen accessibility_iaccessible_get_acc_description (child_id: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accDescription"
		end

	frozen get_method_string_binding_flags_binder (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMethod"
		end

	frozen accessibility_iaccessible_get_acc_child (child_id: ANY): ANY is
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

	frozen accessibility_iaccessible_get_acc_help_topic (psz_help_file: STRING; child_id: ANY): INTEGER is
		external
			"IL signature (System.String&, System.Object): System.Int32 use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accHelpTopic"
		end

	frozen accessibility_iaccessible_get_acc_state (child_id: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accState"
		end

	frozen system_reflection_ireflect_invoke_member (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; named_parameters: ARRAY [STRING]): ANY is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.InvokeMember"
		end

	frozen accessibility_iaccessible_get_acc_parent: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accParent"
		end

	frozen accessibility_iaccessible_acc_navigate (nav_dir: INTEGER; child_id: ANY): ANY is
		external
			"IL signature (System.Int32, System.Object): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accNavigate"
		end

	frozen accessibility_iaccessible_get_acc_value (child_id: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accValue"
		end

	frozen system_reflection_ireflect_get_property (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetProperty"
		end

	frozen system_reflection_ireflect_get_methods (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMethods"
		end

	frozen accessibility_iaccessible_acc_location (px_left: INTEGER; py_top: INTEGER; pcx_width: INTEGER; pcy_height: INTEGER; child_id: ANY) is
		external
			"IL signature (System.Int32&, System.Int32&, System.Int32&, System.Int32&, System.Object): System.Void use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accLocation"
		end

	frozen accessibility_iaccessible_acc_hit_test (x_left: INTEGER; y_top: INTEGER): ANY is
		external
			"IL signature (System.Int32, System.Int32): System.Object use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.accHitTest"
		end

	frozen accessibility_iaccessible_get_acc_keyboard_shortcut (child_id: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.AccessibleObject"
		alias
			"Accessibility.IAccessible.get_accKeyboardShortcut"
		end

	frozen system_reflection_ireflect_get_members (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Windows.Forms.AccessibleObject"
		alias
			"System.Reflection.IReflect.GetMembers"
		end

end -- class SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT
