indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResourceSet"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RESOURCE_SET

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (reader: IRESOURCE_READER) is
		external
			"IL creator signature (System.Resources.IResourceReader) use System.Resources.ResourceSet"
		end

	frozen make (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResourceSet"
		end

	frozen make_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResourceSet"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.ResourceSet"
		alias
			"ToString"
		end

	get_object_string_boolean (name: SYSTEM_STRING; ignore_case: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Resources.ResourceSet"
		alias
			"GetObject"
		end

	get_string_string_boolean (name: SYSTEM_STRING; ignore_case: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Boolean): System.String use System.Resources.ResourceSet"
		alias
			"GetString"
		end

	close is
		external
			"IL signature (): System.Void use System.Resources.ResourceSet"
		alias
			"Close"
		end

	get_default_writer: TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResourceSet"
		alias
			"GetDefaultWriter"
		end

	get_object (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Resources.ResourceSet"
		alias
			"GetObject"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResourceSet"
		alias
			"GetHashCode"
		end

	get_default_reader: TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResourceSet"
		alias
			"GetDefaultReader"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResourceSet"
		alias
			"Equals"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Resources.ResourceSet"
		alias
			"Dispose"
		end

	get_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Resources.ResourceSet"
		alias
			"GetString"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Resources.ResourceSet"
		alias
			"Dispose"
		end

	read_resources is
		external
			"IL signature (): System.Void use System.Resources.ResourceSet"
		alias
			"ReadResources"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Resources.ResourceSet"
		alias
			"Finalize"
		end

end -- class RESOURCE_SET
