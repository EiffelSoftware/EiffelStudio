indexing

	description:	
		"Command to save a file.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_FILE 

inherit

	ICONED_COMMAND
		redefine
			dark_symbol, licence_checked
		end

creation

	make
	
feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Save 
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			new_file: PLAIN_TEXT_FILE;
			to_write: STRING;
			aok: BOOLEAN;
			temp: STRING;
			char: CHARACTER
		do
			if tool.file_name /= Void then
				!!new_file.make (tool.file_name);
				aok := True;
				if
					(new_file.exists) and then (not new_file.is_plain)
				then
					aok := False;
					warner (popup_parent).gotcha_call (w_Not_a_plain_file (new_file.name))
				elseif
					new_file.exists and then (not new_file.is_writable)
				then
					aok := False;
					warner (popup_parent).gotcha_call (w_Not_writable (new_file.name))
				elseif
					 (not new_file.exists) and then (not new_file.is_creatable)
				then
					aok := False;
					warner (popup_parent).gotcha_call (w_Not_creatable (new_file.name))
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
					tool.update_save_symbol;
				end
			end
		end;

 
	
feature {NONE} -- Attributes

	licence_checked: BOOLEAN is True;
			-- Is the licence checked?

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := bm_Dark_save
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := l_Save
		end

end -- class SAVE_FILE
