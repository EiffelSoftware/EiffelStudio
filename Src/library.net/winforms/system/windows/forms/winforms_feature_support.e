indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.FeatureSupport"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_FEATURE_SUPPORT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WINFORMS_IFEATURE_SUPPORT

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.FeatureSupport"
		alias
			"ToString"
		end

	is_present_object_version (feature_: SYSTEM_OBJECT; minimum_version: VERSION): BOOLEAN is
		external
			"IL signature (System.Object, System.Version): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

	frozen get_version_present_string (feature_class_name: SYSTEM_STRING; feature_const_name: SYSTEM_STRING): VERSION is
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

	is_present (feature_: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

	frozen is_present_string_string_version (feature_class_name: SYSTEM_STRING; feature_const_name: SYSTEM_STRING; minimum_version: VERSION): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.Version): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"IsPresent"
		end

	get_version_present (feature_: SYSTEM_OBJECT): VERSION is
		external
			"IL deferred signature (System.Object): System.Version use System.Windows.Forms.FeatureSupport"
		alias
			"GetVersionPresent"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.FeatureSupport"
		alias
			"Equals"
		end

	frozen is_present_string_string (feature_class_name: SYSTEM_STRING; feature_const_name: SYSTEM_STRING): BOOLEAN is
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

end -- class WINFORMS_FEATURE_SUPPORT
