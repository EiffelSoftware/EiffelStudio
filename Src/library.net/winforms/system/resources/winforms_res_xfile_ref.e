indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResXFileRef"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_RES_XFILE_REF

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (file_name: SYSTEM_STRING; type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Resources.ResXFileRef"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.ResXFileRef"
		alias
			"ToString"
		end

end -- class WINFORMS_RES_XFILE_REF
