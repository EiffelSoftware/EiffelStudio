indexing

	description:	
		"Command to save a file under a different name.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_AS_FILE 

inherit

	ICONED_COMMAND
		redefine
			licence_checked
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_it
		end

creation

	make
	
feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (a_text_window)
		end;

feature -- Callbacks

	execute_warner_help is
			-- Useless here
		do
			-- Do Nothing
		end;

	save_it (argument: ANY) is
			-- Save a file with a chosen name.
		local
			fn: STRING;
			new_file: PLAIN_TEXT_FILE;
			to_write: STRING;
			aok: BOOLEAN;
			char: CHARACTER;
			temp: STRING
		do
			fn := clone (last_name_chooser.selected_file);
			if not fn.empty then
				!!new_file.make (fn);
				aok := True;
				if
					(new_file.exists) and then (not new_file.is_plain)
				then
					aok := False;
					warner (text_window).gotcha_call 
						(w_Not_a_plain_file (fn))
				elseif 
					argument = last_name_chooser and then 
					(new_file.exists and then new_file.is_writable)
				then
					aok := False;
					warner (text_window).custom_call (Current, 
						w_File_exists (fn), 
						"Overwrite", Void, "Cancel");
				elseif
					new_file.exists and then (not new_file.is_writable)
				then
					aok := False;
					warner (text_window).gotcha_call 
						(w_Not_writable (fn))
				elseif
					not new_file.is_creatable
				then
					aok := False;
					warner (text_window).gotcha_call 
						(w_Not_creatable (fn))
				end
			else
				aok := False;
				warner (text_window).gotcha_call 
					(w_Not_a_plain_file (fn))
			end;
			if aok then
				new_file.open_write;
				to_write := text_window.text;
				if not to_write.empty then
					new_file.putstring (to_write);
					char := to_write.item (to_write.count);
					if char /= '%N' and then char /= '%R' then
							-- Add a carriage return like vi 
							-- if there's none at the end
						new_file.new_line
					end;
				end;
				new_file.close;
				if text_window.changed then 
					text_window.clear_clickable
				end;
				text_window.set_changed (false);
				if text_window.file_name = Void then
					text_window.set_file_name (new_file.name);
					text_window.display_header (new_file.name);
					update_more;
				end;
			end;
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Save_as 
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		do
			if argument /= Void and then argument = last_name_chooser then
				save_it (argument)
			elseif argument = text_window then
				name_chooser (text_window).set_window (text_window);
				last_name_chooser.call (Current)
			end
		end;

	update_more is
			-- Useless here.
		do
			-- Do nothing.
		end;

feature {NONE}

	licence_checked: BOOLEAN is True;
			-- Is the licence checked?

	name: STRING is
			-- Name of the command.
		do
			Result := l_Save_as
		end

end -- class SAVE_AS_FILE
