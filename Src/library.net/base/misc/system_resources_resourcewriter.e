indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Resources.ResourceWriter"

frozen external class
	SYSTEM_RESOURCES_RESOURCEWRITER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RESOURCES_IRESOURCEWRITER
	SYSTEM_IDISPOSABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResourceWriter"
		end

	frozen make_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResourceWriter"
		end

feature -- Basic Operations

	to_string: STRING is
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

	frozen add_resource (name: STRING; value: STRING) is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResourceWriter"
		alias
			"Equals"
		end

	frozen add_resource_string_array_byte (name: STRING; value: ARRAY [INTEGER_8]) is
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

	frozen add_resource_string_object (name: STRING; value: ANY) is
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

end -- class SYSTEM_RESOURCES_RESOURCEWRITER
