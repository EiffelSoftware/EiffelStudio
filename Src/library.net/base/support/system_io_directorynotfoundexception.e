indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.DirectoryNotFoundException"

external class
	SYSTEM_IO_DIRECTORYNOTFOUNDEXCEPTION

inherit
	SYSTEM_IO_IOEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_directorynotfoundexception,
	make_directorynotfoundexception_1,
	make_directorynotfoundexception_2

feature {NONE} -- Initialization

	frozen make_directorynotfoundexception is
		external
			"IL creator use System.IO.DirectoryNotFoundException"
		end

	frozen make_directorynotfoundexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.DirectoryNotFoundException"
		end

	frozen make_directorynotfoundexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.DirectoryNotFoundException"
		end

end -- class SYSTEM_IO_DIRECTORYNOTFOUNDEXCEPTION
