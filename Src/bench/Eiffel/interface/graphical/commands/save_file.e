indexing

	description:	
		"Command to save a file.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_FILE 

inherit

	EB_CONSTANTS;
	SYSTEM_CONSTANTS;
	TWO_STATE_CMD
		rename
			init as make,
			true_state_symbol as unmodified_pixmap,
			false_state_symbol as modified_pixmap
		redefine
			license_checked, modified_pixmap
		end

creation

	make
	
feature -- Properties

	unmodified_pixmap: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Save 
		end;

	modified_pixmap: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Dark_save
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			--new_file: PLAIN_TEXT_FILE; 
			new_file: RAW_FILE; -- Because of windows
			to_write: STRING;
			aok: BOOLEAN;
			temp: STRING;
			char: CHARACTER;
			save_as_cmd: SAVE_AS_FILE
		do
			if tool.file_name = Void then
				!! save_as_cmd.make (tool);
				save_as_cmd.execute (tool)
			else
				!!new_file.make (tool.file_name);
				aok := True;
				if
					(new_file.exists) and then (not new_file.is_plain)
				then
					aok := False;
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_a_plain_file (new_file.name))
				elseif
					new_file.exists and then (not new_file.is_writable)
				then
					aok := False;
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_writable (new_file.name))
				elseif
					 (not new_file.exists) and then (not new_file.is_creatable)
				then
					aok := False;
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_creatable (new_file.name))
				end;

				if aok then
					new_file.open_write;
					to_write := text_window.text; 
					if not to_write.empty then
						new_file.putstring (to_write);
						char := to_write.item (to_write.count);
						if Platform_constants.is_unix and then char /= '%N' and then char /= '%R' then 
							-- Add a carriage return like vi if there's none at the end 
							new_file.new_line
						end; 
					end;
					new_file.close;
					text_window.disable_clicking;
					if tool.stone /= Void and then Class_resources.parse_class_after_saving.actual_value then
						tool.parse_file
					end;
					tool.update_save_symbol;
				end
			end
		end;

 
	
feature {NONE} -- Attributes

	license_checked: BOOLEAN is True;
			-- Is the license checked?

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := Pixmaps.bm_Dark_save
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Save
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Save
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Save
		end;

end -- class SAVE_FILE
