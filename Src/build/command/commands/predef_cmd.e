indexing
	description: "Predefined command i.e. uneditable command."
	Id: "$Id$" 
	Date: "$Date$"
	Revision: "$Revision$"

deferred class PREDEF_CMD 

inherit
	CMD
		redefine
			comment
		end

	SHARED_STORAGE_INFO

	PREDEF_CMD_IDENTIFIERS

	ERROR_POPUPER

feature {NONE} -- Initialization 

	make is
		do
			predefined_command_table.put (Current, - identifier)
		end

feature -- Access

	label: STRING is
		deferred
		end

	comment: STRING is
		do
			Result := "predefined command"
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.predef_command_pixmap
		end

	help_file_name: STRING is
		do
			Result := Help_const.pred_command_help_fn
		end

	eiffel_text: STRING is
		local
			full_path: FILE_NAME	
			fn: STRING
			f: PLAIN_TEXT_FILE
		do
			create full_path.make_from_string (Environment.predefined_commands_directory)
				fn := clone (eiffel_type)
				fn.to_lower
			full_path.set_file_name (fn)
			full_path.add_extension ("e")
			create f.make (full_path)
			if f.exists and then f.is_readable then
				f.open_read
				f.readstream (f.count)
				Result := f.laststring
				f.close
			else
				error_dialog.popup (Current, Messages.Cannot_read_file_er,
					full_path)		
				Result := ""
			end
		rescue
			if not (f = Void or else f.is_closed) then
				f.close
			end
		end

	remove_class is do end

	recreate_class is do end

end -- class PREDEF_CMD

