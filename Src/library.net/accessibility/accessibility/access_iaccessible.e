indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Accessibility.IAccessible"
	assembly: "Accessibility", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ACCESS_IACCESSIBLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_acc_description (var_child: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accDescription"
		end

	get_acc_child (var_child: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use Accessibility.IAccessible"
		alias
			"get_accChild"
		end

	get_acc_focus: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use Accessibility.IAccessible"
		alias
			"get_accFocus"
		end

	get_acc_selection: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use Accessibility.IAccessible"
		alias
			"get_accSelection"
		end

	get_acc_help (var_child: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accHelp"
		end

	get_acc_keyboard_shortcut (var_child: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accKeyboardShortcut"
		end

	get_acc_default_action (var_child: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accDefaultAction"
		end

	get_acc_child_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use Accessibility.IAccessible"
		alias
			"get_accChildCount"
		end

	get_acc_name (var_child: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accName"
		end

	get_acc_state (var_child: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use Accessibility.IAccessible"
		alias
			"get_accState"
		end

	get_acc_value (var_child: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accValue"
		end

	get_acc_role (var_child: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use Accessibility.IAccessible"
		alias
			"get_accRole"
		end

	get_acc_parent: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use Accessibility.IAccessible"
		alias
			"get_accParent"
		end

	get_acc_help_topic (psz_help_file: SYSTEM_STRING; var_child: SYSTEM_OBJECT): INTEGER is
		external
			"IL deferred signature (System.String&, System.Object): System.Int32 use Accessibility.IAccessible"
		alias
			"get_accHelpTopic"
		end

feature -- Element Change

	set_acc_name (var_child: SYSTEM_OBJECT; psz_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Object, System.String): System.Void use Accessibility.IAccessible"
		alias
			"set_accName"
		end

	set_acc_value (var_child: SYSTEM_OBJECT; psz_value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Object, System.String): System.Void use Accessibility.IAccessible"
		alias
			"set_accValue"
		end

feature -- Basic Operations

	acc_select (flags_select: INTEGER; var_child: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Int32, System.Object): System.Void use Accessibility.IAccessible"
		alias
			"accSelect"
		end

	acc_navigate (nav_dir: INTEGER; var_start: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32, System.Object): System.Object use Accessibility.IAccessible"
		alias
			"accNavigate"
		end

	acc_hit_test (x_left: INTEGER; y_top: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Object use Accessibility.IAccessible"
		alias
			"accHitTest"
		end

	acc_do_default_action (var_child: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use Accessibility.IAccessible"
		alias
			"accDoDefaultAction"
		end

	acc_location (px_left: INTEGER; py_top: INTEGER; pcx_width: INTEGER; pcy_height: INTEGER; var_child: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Int32&, System.Int32&, System.Int32&, System.Int32&, System.Object): System.Void use Accessibility.IAccessible"
		alias
			"accLocation"
		end

end -- class ACCESS_IACCESSIBLE
