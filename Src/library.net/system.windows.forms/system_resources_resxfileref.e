indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResXFileRef"

external class
	SYSTEM_RESOURCES_RESXFILEREF

inherit
	ANY
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (file_name: STRING; type_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Resources.ResXFileRef"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Resources.ResXFileRef"
		alias
			"ToString"
		end

end -- class SYSTEM_RESOURCES_RESXFILEREF
