indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.MissingManifestResourceException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MISSING_MANIFEST_RESOURCE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_missing_manifest_resource_exception_1,
	make_missing_manifest_resource_exception_2,
	make_missing_manifest_resource_exception

feature {NONE} -- Initialization

	frozen make_missing_manifest_resource_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.MissingManifestResourceException"
		end

	frozen make_missing_manifest_resource_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Resources.MissingManifestResourceException"
		end

	frozen make_missing_manifest_resource_exception is
		external
			"IL creator use System.Resources.MissingManifestResourceException"
		end

end -- class MISSING_MANIFEST_RESOURCE_EXCEPTION
