indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.IResourceWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IRESOURCE_WRITER

inherit
	IDISPOSABLE

feature -- Basic Operations

	add_resource (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Resources.IResourceWriter"
		alias
			"AddResource"
		end

	add_resource_string_array_byte (name: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
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

	add_resource_string_object (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
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

end -- class IRESOURCE_WRITER
