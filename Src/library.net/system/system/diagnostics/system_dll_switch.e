indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.Switch"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_SWITCH

inherit
	SYSTEM_OBJECT

feature -- Access

	frozen get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.Switch"
		alias
			"get_Description"
		end

	frozen get_display_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.Switch"
		alias
			"get_DisplayName"
		end

feature {NONE} -- Implementation

	on_switch_setting_changed is
		external
			"IL signature (): System.Void use System.Diagnostics.Switch"
		alias
			"OnSwitchSettingChanged"
		end

	frozen set_switch_setting (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Diagnostics.Switch"
		alias
			"set_SwitchSetting"
		end

	frozen get_switch_setting: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.Switch"
		alias
			"get_SwitchSetting"
		end

end -- class SYSTEM_DLL_SWITCH
