indexing
	description: "Screen cursors."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class CURSORS

inherit
	CONSTANTS

feature {NONE} -- Initialization

	default_create is
		do
			create cursor_codes.make
		end

	cursor_codes: EV_CURSOR_CODE

feature -- Pick and Drop cursors

--	Application_cursor: EV_CURSOR is
--		once
--			Result := cursor_file_content ("applictn.cur")
--		end

	Behavior_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("behavior.cur")
		end

	Color_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("color.cur")
		end

	Command_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("command.cur")
		end

	Command_instance_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("cmd_inst.cur")
		end

	Context_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("context.cur")
		end

	Event_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("event.cur")
		end

	Label_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("label.cur")
		end

	State_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("state.cur")
		end

	Transition_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("transitn.cur")
		end

	Type_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("type.cur")
		end

	Window_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("window.cur")
		end

feature -- Context Cursors

	arrow_cursor: EV_CURSOR is
			-- The standard arrow cursor shape
		once
			create Result.make_by_code (cursor_codes.standard)
		end
	
	move_cursor: EV_CURSOR is
			-- Cross cursor shape (move mode)
		once
			create Result.make_by_code (cursor_codes.sizeall)
		end

	top_left_corner_cursor: EV_CURSOR is
			-- Top left corner cursor (resize mode)
		once
			create Result.make --(Top_left_corner)
		end

	top_right_corner_cursor: EV_CURSOR is
			-- Top right corner cursor (resize mode)
		once
			create Result.make --(Top_right_corner)
		end

	bottom_left_corner_cursor: EV_CURSOR is
			-- Bottom left corner cursor (resize mode)
		once
			create Result.make --(Bottom_left_corner)
		end

	bottom_right_corner_cursor: EV_CURSOR is
			-- Bottom right corner cursor (resize mode)
		once
			create Result.make --(Bottom_right_corner)
		end

	question_arrow_cursor: EV_CURSOR is
			-- Question arrow cursor
		once
			create Result.make_by_code (cursor_codes.help)
		end

	cross_cursor: EV_CURSOR is
			-- Cross cursor
		once
			create Result.make_by_code (cursor_codes.crosshair)
		end


feature -- Watch Cursor

	watch_cursor: EV_CURSOR is
			-- Watch cursor
		once
			create Result.make_by_code (cursor_codes.busy)
		end

feature {NONE} 

	cursor_file_content (fn: STRING): EV_CURSOR is
		local
--			p: PIXMAP
			full_name: FILE_NAME
		do
			create full_name.make_from_string (Environment.bitmaps_directory)
			full_name.set_file_name (fn)
--			!! p.make
--			p.read_from_file (full_name)
--			!! Result.make
			if full_name.is_valid then
--				if p.is_valid then
--					Result.set_pixmap (p, p)
--				else
--					io.error.putstring ("EiffelBuild: Can not read bitmap file%N")
--					io.error.putstring (full_name)
--					io.error.putstring (".%N")
--				end
				create Result.make_by_filename (full_name)
			else
				io.error.putstring ("Warning: ")
				io.error.putstring (full_name)
				io.error.putstring (" is an invalid file name.")
				io.error.new_line
			end
		end

end -- class CURSORS

