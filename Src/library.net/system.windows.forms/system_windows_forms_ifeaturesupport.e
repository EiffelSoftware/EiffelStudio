indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IFeatureSupport"

deferred external class
	SYSTEM_WINDOWS_FORMS_IFEATURESUPPORT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_version_present (feature_: ANY): SYSTEM_VERSION is
		external
			"IL deferred signature (System.Object): System.Version use System.Windows.Forms.IFeatureSupport"
		alias
			"GetVersionPresent"
		end

	is_present (feature_: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Windows.Forms.IFeatureSupport"
		alias
			"IsPresent"
		end

	is_present_object_version (feature_: ANY; minimum_version: SYSTEM_VERSION): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.Version): System.Boolean use System.Windows.Forms.IFeatureSupport"
		alias
			"IsPresent"
		end

end -- class SYSTEM_WINDOWS_FORMS_IFEATURESUPPORT
