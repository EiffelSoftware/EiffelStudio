indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResourceWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	RESOURCE_WRITER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IRESOURCE_WRITER
	IDISPOSABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResourceWriter"
		end

	frozen make_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResourceWriter"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.ResourceWriter"
		alias
			"ToString"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Resources.ResourceWriter"
		alias
			"Close"
		end

	frozen add_resource (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Resources.ResourceWriter"
		alias
			"AddResource"
		end

	frozen generate is
		external
			"IL signature (): System.Void use System.Resources.ResourceWriter"
		alias
			"Generate"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResourceWriter"
		alias
			"Equals"
		end

	frozen add_resource_string_array_byte (name: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Resources.ResourceWriter"
		alias
			"AddResource"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Resources.ResourceWriter"
		alias
			"Dispose"
		end

	frozen add_resource_string_object (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Resources.ResourceWriter"
		alias
			"AddResource"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResourceWriter"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Resources.ResourceWriter"
		alias
			"Finalize"
		end

end -- class RESOURCE_WRITER
