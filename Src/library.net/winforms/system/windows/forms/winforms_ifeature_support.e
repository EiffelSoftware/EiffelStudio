indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IFeatureSupport"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IFEATURE_SUPPORT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_version_present (feature_: SYSTEM_OBJECT): VERSION is
		external
			"IL deferred signature (System.Object): System.Version use System.Windows.Forms.IFeatureSupport"
		alias
			"GetVersionPresent"
		end

	is_present (feature_: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Windows.Forms.IFeatureSupport"
		alias
			"IsPresent"
		end

	is_present_object_version (feature_: SYSTEM_OBJECT; minimum_version: VERSION): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.Version): System.Boolean use System.Windows.Forms.IFeatureSupport"
		alias
			"IsPresent"
		end

end -- class WINFORMS_IFEATURE_SUPPORT
