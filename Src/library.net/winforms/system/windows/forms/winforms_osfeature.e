indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.OSFeature"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_OSFEATURE

inherit
	WINFORMS_FEATURE_SUPPORT
	WINFORMS_IFEATURE_SUPPORT

create {NONE}

feature -- Access

	frozen get_feature: WINFORMS_OSFEATURE is
		external
			"IL static signature (): System.Windows.Forms.OSFeature use System.Windows.Forms.OSFeature"
		alias
			"get_Feature"
		end

	frozen layered_windows: SYSTEM_OBJECT is
		external
			"IL static_field signature :System.Object use System.Windows.Forms.OSFeature"
		alias
			"LayeredWindows"
		end

	frozen themes: SYSTEM_OBJECT is
		external
			"IL static_field signature :System.Object use System.Windows.Forms.OSFeature"
		alias
			"Themes"
		end

feature -- Basic Operations

	get_version_present (feature_: SYSTEM_OBJECT): VERSION is
		external
			"IL signature (System.Object): System.Version use System.Windows.Forms.OSFeature"
		alias
			"GetVersionPresent"
		end

end -- class WINFORMS_OSFEATURE
