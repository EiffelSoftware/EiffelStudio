indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Accessibility.IAccessible"

deferred external class
	ACCESSIBILITY_IACCESSIBLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_acc_description (var_child: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accDescription"
		end

	get_acc_child (var_child: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use Accessibility.IAccessible"
		alias
			"get_accChild"
		end

	get_acc_focus: ANY is
		external
			"IL deferred signature (): System.Object use Accessibility.IAccessible"
		alias
			"get_accFocus"
		end

	get_acc_selection: ANY is
		external
			"IL deferred signature (): System.Object use Accessibility.IAccessible"
		alias
			"get_accSelection"
		end

	get_acc_help (var_child: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accHelp"
		end

	get_acc_keyboard_shortcut (var_child: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accKeyboardShortcut"
		end

	get_acc_default_action (var_child: ANY): STRING is
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

	get_acc_name (var_child: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accName"
		end

	get_acc_state (var_child: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use Accessibility.IAccessible"
		alias
			"get_accState"
		end

	get_acc_value (var_child: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use Accessibility.IAccessible"
		alias
			"get_accValue"
		end

	get_acc_role (var_child: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use Accessibility.IAccessible"
		alias
			"get_accRole"
		end

	get_acc_parent: ANY is
		external
			"IL deferred signature (): System.Object use Accessibility.IAccessible"
		alias
			"get_accParent"
		end

	get_acc_help_topic (psz_help_file: STRING; var_child: ANY): INTEGER is
		external
			"IL deferred signature (System.String&, System.Object): System.Int32 use Accessibility.IAccessible"
		alias
			"get_accHelpTopic"
		end

feature -- Element Change

	set_acc_name (var_child: ANY; psz_name: STRING) is
		external
			"IL deferred signature (System.Object, System.String): System.Void use Accessibility.IAccessible"
		alias
			"set_accName"
		end

	set_acc_value (var_child: ANY; psz_value: STRING) is
		external
			"IL deferred signature (System.Object, System.String): System.Void use Accessibility.IAccessible"
		alias
			"set_accValue"
		end

feature -- Basic Operations

	acc_select (flags_select: INTEGER; var_child: ANY) is
		external
			"IL deferred signature (System.Int32, System.Object): System.Void use Accessibility.IAccessible"
		alias
			"accSelect"
		end

	acc_navigate (nav_dir: INTEGER; var_start: ANY): ANY is
		external
			"IL deferred signature (System.Int32, System.Object): System.Object use Accessibility.IAccessible"
		alias
			"accNavigate"
		end

	acc_hit_test (x_left: INTEGER; y_top: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Object use Accessibility.IAccessible"
		alias
			"accHitTest"
		end

	acc_do_default_action (var_child: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use Accessibility.IAccessible"
		alias
			"accDoDefaultAction"
		end

	acc_location (px_left: INTEGER; py_top: INTEGER; pcx_width: INTEGER; pcy_height: INTEGER; var_child: ANY) is
		external
			"IL deferred signature (System.Int32&, System.Int32&, System.Int32&, System.Int32&, System.Object): System.Void use Accessibility.IAccessible"
		alias
			"accLocation"
		end

end -- class ACCESSIBILITY_IACCESSIBLE
