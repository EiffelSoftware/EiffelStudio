indexing
	description:	"Command to display text. No warning or watch cursor.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_TEXT 

inherit
	FORMATTER
		rename
			init as make,
			class_name as exception_class_name
		redefine
			format, display_header, file_name, display_temp_header
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_FORMAT_TABLES

creation

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showtext 
		end;
	
feature {ROUTINE_WIN_MGR} -- Displaying

	display_header (stone: STONE) is
		local
			new_title: STRING;
		do
			!!new_title.make (0);
			new_title.append (stone.header);
			tool.set_title (new_title);
		end;

feature -- Formatting

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text, class_name: STRING;
			filed_stone: FILED_STONE;
			classc_stone: CLASSC_STONE;
			e_class: CLASS_C;
			class_tool: CLASS_W;
			modified_class: BOOLEAN;
			retried: BOOLEAN;
			same_stone, error: BOOLEAN;
			mp: MOUSE_PTR;
			cur: CURSOR;
			routine_w: ROUTINE_W;
			st: STRUCTURED_TEXT
		do
			if not retried then
				classc_stone ?= stone;
				if classc_stone /= Void and then classc_stone.is_valid then
					e_class := classc_stone.e_class;
					modified_class := not e_class.is_precompiled and then
						e_class.lace_class.date_has_changed and then not e_class.has_syntax_error
				end
				if
					do_format or filtered or modified_class or else
					(tool.last_format.associated_command /= Current or
					stone /= Void and then not stone.same_as (tool.stone))
				then
					if stone /= Void and then stone.is_valid then
						same_stone := stone.same_as (tool.stone);
						display_temp_header (stone);
						!! mp.set_watch_cursor;
						stone_text := stone.origin_text;
						if stone_text = Void then
							stone_text := "";
							filed_stone ?= stone;
							if filed_stone /= Void then
								if filed_stone.file_name /= Void then
									error := true;
									warner (popup_parent).gotcha_call 	
									(Warning_messages.w_Cannot_read_file (filed_stone.file_name))
								else
									error := true;
									warner (popup_parent).gotcha_call 
										(Warning_messages.w_No_associated_file)
								end;
							end			
						end;
						class_tool ?= tool;
						if 
							class_tool /= Void and then (
							(same_stone and tool.last_format = class_tool.showclick_frmt_holder) or
							(do_format and tool.last_format.associated_command = Current))
						then
							cur := text_window.cursor;
						end;
						text_window.clear_window;
						tool.set_editable_text;
						filed_stone ?= stone;
						if filed_stone = Void then
							tool.set_file_name (Void);
						else
							tool.set_file_name (file_name (filed_stone));
						end;
						tool.set_stone (stone);
						routine_w ?= tool;
						if 	
							routine_w /= Void and then
							routine_w.stone.e_feature.written_class.lace_class.hide_implementation
						then
							st := rout_flat_context_text (routine_w.stone);
							text_window.process_text (st);
							text_window.display
						else	
							text_window.set_text (stone_text)
						end;
						tool.update_save_symbol;
						tool.set_mode_for_editing;
						tool.show_editable_text;
						if stone.clickable then
							if modified_class then
								if not error and not do_format then
										-- Do not display the warning message
										-- if the format has been changed
										-- internally (resynchronization, ...)
									class_name := classc_stone.e_class.name;
									error := true;
									warner (popup_parent).gotcha_call 
										(Warning_messages.w_Class_modified (class_name))
								end
							elseif st = Void then
								text_window.update_clickable_from_stone (stone)
							end
						end;
						if cur /= Void then
							text_window.go_to (cur)
						end;
						tool.set_last_format (holder);
						display_header (stone);
						mp.restore
					end;
					filtered := false
				end
			else
				!! mp.do_nothing;
				mp.restore
				warner (popup_parent).gotcha_call (Warning_messages.w_Cannot_retrieve_info);
			end
		rescue
			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true;
				retry
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if tool.last_format.associated_command = Current then
				tool.set_title ("Producing text format...")
			else
				tool.set_title ("Switching to text format...")
			end
		end;

	display_info (d: STONE) is do end
			-- Useless here

feature {NONE} -- Properties

	file_name (s: FILED_STONE): STRING is
		do
			Result := s.file_name
		end;

	name: STRING is
		do
			Result := Interface_names.f_Showtext
		end;

	title_part: STRING is
		do
			Result := ""
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showtext
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Showtext
		end

end -- SHOW_TEXT
