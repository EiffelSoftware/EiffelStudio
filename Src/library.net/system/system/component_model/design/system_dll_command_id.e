indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.CommandID"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMMAND_ID

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (menu_group: GUID; command_id: INTEGER) is
		external
			"IL creator signature (System.Guid, System.Int32) use System.ComponentModel.Design.CommandID"
		end

feature -- Access

	get_guid: GUID is
		external
			"IL signature (): System.Guid use System.ComponentModel.Design.CommandID"
		alias
			"get_Guid"
		end

	get_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.CommandID"
		alias
			"get_ID"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.CommandID"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.CommandID"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.CommandID"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_COMMAND_ID
