indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResXResourceSet"

external class
	SYSTEM_RESOURCES_RESXRESOURCESET

inherit
	SYSTEM_IDISPOSABLE
	SYSTEM_RESOURCES_RESOURCESET
		redefine
			get_default_writer,
			get_default_reader
		end

create
	make_resxresourceset_1,
	make_resxresourceset

feature {NONE} -- Initialization

	frozen make_resxresourceset_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResXResourceSet"
		end

	frozen make_resxresourceset (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResXResourceSet"
		end

feature -- Basic Operations

	get_default_reader: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResXResourceSet"
		alias
			"GetDefaultReader"
		end

	get_default_writer: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResXResourceSet"
		alias
			"GetDefaultWriter"
		end

end -- class SYSTEM_RESOURCES_RESXRESOURCESET
