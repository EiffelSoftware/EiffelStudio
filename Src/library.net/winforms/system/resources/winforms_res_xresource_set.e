indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResXResourceSet"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_RES_XRESOURCE_SET

inherit
	RESOURCE_SET
		redefine
			get_default_writer,
			get_default_reader
		end
	IDISPOSABLE

create
	make_winforms_res_xresource_set,
	make_winforms_res_xresource_set_1

feature {NONE} -- Initialization

	frozen make_winforms_res_xresource_set (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResXResourceSet"
		end

	frozen make_winforms_res_xresource_set_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResXResourceSet"
		end

feature -- Basic Operations

	get_default_reader: TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResXResourceSet"
		alias
			"GetDefaultReader"
		end

	get_default_writer: TYPE is
		external
			"IL signature (): System.Type use System.Resources.ResXResourceSet"
		alias
			"GetDefaultWriter"
		end

end -- class WINFORMS_RES_XRESOURCE_SET
