indexing
	description	: "Command to display text. No warning or watch cursor."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TEXT_FORMATTER

inherit
	EB_FORMATTER
		rename
--			init as make,
--			class_name as exception_class_name
		redefine
			format, display_header, file_name, display_temp_header,
			tool
		end

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_FORMAT_TABLES

creation
	make

feature -- Properties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showtext 
		end

	tool: EB_EDIT_TOOL
	
feature {EB_FEATURE_TOOL_LIST} -- Displaying

	display_header (stone: STONE) is
		local
			new_title: STRING
			fs: FEATURE_STONE
		do
			create new_title.make (0)
			new_title.append (stone.header)
			fs ?= stone
			if
				(fs /= Void) and then
				Application.has_breakpoint_set (fs.e_feature) 
			then
				new_title.append ("   (stop)")		
			end
		end

feature -- Formatting

	format is
			-- Show text of the tool stone in `text_area'
		local
			stone_text, class_name: STRING
			filed_stone: FILED_STONE
			classc_stone: CLASSC_STONE
			e_class: CLASS_C
			class_tool: EB_DEVELOPMENT_TOOL
			modified_class: BOOLEAN
			retried: BOOLEAN
--			same_stone: BOOLEAN
			error: BOOLEAN
--			mp: MOUSE_PTR
--			cur: CURSOR
			routine_w: EB_FEATURE_TOOL
			st: STRUCTURED_TEXT
			wd: EV_WARNING_DIALOG
		do
			if not retried then
				classc_stone ?= tool.stone
				if classc_stone /= Void and then classc_stone.is_valid then
					e_class := classc_stone.e_class
					modified_class := not e_class.is_precompiled and then
						e_class.lace_class.date_has_changed and then not e_class.has_syntax_error
				end
				if
					do_format or filtered or modified_class or else
					(tool.last_format /= Current)
--|					or stone /= Void and then not stone.same_as (tool.stone))
--| FIXME
--| Christophe, 5 nov 1999
--| How do we know that `tool.stone' has just changed?
				then
					if tool.stone /= Void and then tool.stone.is_valid then
--|						same_stone := stone.same_as (tool.stone)
						display_temp_header (tool.stone)
--|						create mp.set_watch_cursor
						stone_text := tool.stone.origin_text
						if stone_text = Void then
							stone_text := ""
							filed_stone ?= tool.stone
							if filed_stone /= Void then
								if filed_stone.file_name /= Void then
									error := true
									create wd.make_with_text (Warning_messages.w_Cannot_read_file (filed_stone.file_name))
									wd.show_modal
								else
									error := true
									create wd.make_with_text (Warning_messages.w_No_associated_file)
									wd.show_modal
								end
							end			
						end
						class_tool ?= tool
--						if 
--							class_tool /= Void and then (
--							(tool.last_format = class_tool.showclick_frmt_holder) or
--							(do_format and tool.last_format = Current))
--						then
--							cur := tool.text_area.cursor
--						end
						tool.text_area.clear_window
--						tool.set_stone (stone)
		--| FIXME
		--| Christophe, 18 oct 1999
		--| Watch for last saving date.
						routine_w ?= tool
						if 	
							routine_w /= Void and then
							routine_w.stone.e_feature.written_class.lace_class.hide_implementation
						then
							st := rout_flat_context_text (routine_w.stone)
							tool.text_area.process_text (st)
							tool.text_area.display
						else	
							tool.text_area.set_text (stone_text)
						end
--						tool.update_save_symbol
						tool.enable_editable
--						tool.show_editable_text
						if tool.stone.clickable then
							if modified_class then
								if not error and not do_format then
										-- Do not display the warning message
										-- if the format has been changed
										-- internally (resynchronization, ...)
									class_name := classc_stone.e_class.name
									error := true
									create wd.make_with_text (Warning_messages.w_Class_modified (class_name))
									wd.show_modal
								end
							elseif st = Void then
								tool.text_area.update_clickable_from_stone (tool.stone)
							end
						end
--						if cur /= Void then
--							tool.text_area.go_to (cur)
--						end
						tool.set_last_format (Current)
						display_header (tool.stone)
--						mp.restore
					end
					filtered := false
				end
			else
--				create mp.do_nothing
--				mp.restore
				create wd.make_with_text (Warning_messages.w_Cannot_retrieve_info)
				wd.show_modal
			end
		rescue
--			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true
				retry
--			end
		end
--| FIXME
--| Christophe, 5 nov 1999
--| This feature is to be remade.

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
		end

	display_info (d: STONE) is do end
			-- Useless here

feature {NONE} -- Properties

	file_name: STRING is
		do
			Result := tool.stone.file_name
		end

	name: STRING is
		do
			Result := Interface_names.f_Showtext
		end

	title_part: STRING is
		do
			Result := ""
		end

	post_fix: STRING is "txt"

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showtext
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Showtext
		end

end -- class EB_TEXT_FORMATTER
