indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.IResourceWriter"

deferred external class
	SYSTEM_RESOURCES_IRESOURCEWRITER

inherit
	SYSTEM_IDISPOSABLE

feature -- Basic Operations

	add_resource (name: STRING; value: STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Resources.IResourceWriter"
		alias
			"AddResource"
		end

	add_resource_string_array_byte (name: STRING; value: ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.String, System.Byte[]): System.Void use System.Resources.IResourceWriter"
		alias
			"AddResource"
		end

	generate is
		external
			"IL deferred signature (): System.Void use System.Resources.IResourceWriter"
		alias
			"Generate"
		end

	add_resource_string_object (name: STRING; value: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Resources.IResourceWriter"
		alias
			"AddResource"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Resources.IResourceWriter"
		alias
			"Close"
		end

end -- class SYSTEM_RESOURCES_IRESOURCEWRITER
