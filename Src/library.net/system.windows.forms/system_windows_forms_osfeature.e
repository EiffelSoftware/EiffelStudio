indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.OSFeature"

external class
	SYSTEM_WINDOWS_FORMS_OSFEATURE

inherit
	SYSTEM_WINDOWS_FORMS_FEATURESUPPORT
		rename
			get_version_present as get_version_present_object
		end
	SYSTEM_WINDOWS_FORMS_IFEATURESUPPORT
		rename
			get_version_present as get_version_present_object
		end

create {NONE}

feature -- Access

	frozen get_feature: SYSTEM_WINDOWS_FORMS_OSFEATURE is
		external
			"IL static signature (): System.Windows.Forms.OSFeature use System.Windows.Forms.OSFeature"
		alias
			"get_Feature"
		end

	frozen layered_windows: ANY is
		external
			"IL static_field signature :System.Object use System.Windows.Forms.OSFeature"
		alias
			"LayeredWindows"
		end

	frozen themes: ANY is
		external
			"IL static_field signature :System.Object use System.Windows.Forms.OSFeature"
		alias
			"Themes"
		end

feature -- Basic Operations

	get_version_present_object (feature_: ANY): SYSTEM_VERSION is
		external
			"IL signature (System.Object): System.Version use System.Windows.Forms.OSFeature"
		alias
			"GetVersionPresent"
		end

end -- class SYSTEM_WINDOWS_FORMS_OSFEATURE
