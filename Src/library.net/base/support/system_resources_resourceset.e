indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResourceSet"

external class
	SYSTEM_RESOURCES_RESOURCESET

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (reader: SYSTEM_RESOURCES_IRESOURCEREADER) is
		external
			"IL creator signature (System.Resources.IResourceReader) use System.Resources.ResourceSet"
		end

	frozen make (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResourceSet"
		end

	frozen make_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResourceSet"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Resources.ResourceSet"
		alias
			"ToString"
		end

	get_object_string_boolean (name: STRING; ignore_case: BOOLEAN): ANY is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Resources.ResourceSet"
		alias
			"GetObject"
		end

	get_string_string_boolean (name: STRING; ignore_case: BOOLEAN): STRING is
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

	get_default_writer: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResourceSet"
		alias
			"GetDefaultWriter"
		end

	get_object (name: STRING): ANY is
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

	get_default_reader: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResourceSet"
		alias
			"GetDefaultReader"
		end

	is_equal (obj: ANY): BOOLEAN is
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

	get_string (name: STRING): STRING is
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

end -- class SYSTEM_RESOURCES_RESOURCESET
