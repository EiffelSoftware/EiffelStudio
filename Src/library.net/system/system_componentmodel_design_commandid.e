indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.CommandID"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (menu_group: SYSTEM_GUID; command_id: INTEGER) is
		external
			"IL creator signature (System.Guid, System.Int32) use System.ComponentModel.Design.CommandID"
		end

feature -- Access

	get_guid: SYSTEM_GUID is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.CommandID"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.CommandID"
		alias
			"ToString"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID
