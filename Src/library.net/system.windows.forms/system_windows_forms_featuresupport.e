indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.FeatureSupport"

deferred external class
	SYSTEM_WINDOWS_FORMS_FEATURESUPPORT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IFEATURESUPPORT

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FeatureSupport"
		alias
			"ToString"
		end

	is_present_object_version (feature_: ANY; minimum_version: SYSTEM_VERSION): BOOLEAN is
		external
			"IL signature (System.Object, System.Version): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

	frozen get_version_present_string (feature_class_name: STRING; feature_const_name: STRING): SYSTEM_VERSION is
		external
			"IL static signature (System.String, System.String): System.Version use System.Windows.Forms.FeatureSupport"
		alias
			"GetVersionPresent"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.FeatureSupport"
		alias
			"GetHashCode"
		end

	is_present (feature_: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

	frozen is_present_string_string_version (feature_class_name: STRING; feature_const_name: STRING; minimum_version: SYSTEM_VERSION): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.Version): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

	get_version_present (feature_: ANY): SYSTEM_VERSION is
		external
			"IL deferred signature (System.Object): System.Version use System.Windows.Forms.FeatureSupport"
		alias
			"GetVersionPresent"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"Equals"
		end

	frozen is_present_string_string (feature_class_name: STRING; feature_const_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.FeatureSupport"
		alias
			"Finalize"
		end

end -- class SYSTEM_WINDOWS_FORMS_FEATURESUPPORT
