indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Resources.MissingManifestResourceException"

external class
	SYSTEM_RESOURCES_MISSINGMANIFESTRESOURCEEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_missingmanifestresourceexception,
	make_missingmanifestresourceexception_1,
	make_missingmanifestresourceexception_2

feature {NONE} -- Initialization

	frozen make_missingmanifestresourceexception is
		external
			"IL creator use System.Resources.MissingManifestResourceException"
		end

	frozen make_missingmanifestresourceexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.MissingManifestResourceException"
		end

	frozen make_missingmanifestresourceexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Resources.MissingManifestResourceException"
		end

end -- class SYSTEM_RESOURCES_MISSINGMANIFESTRESOURCEEXCEPTION
