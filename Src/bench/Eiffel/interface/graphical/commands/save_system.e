indexing

	description:	
		"Command to savethe save the ace file.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_SYSTEM

inherit

	SHARED_EIFFEL_PROJECT;	
	PROJECT_CONTEXT;
	SAVE_FILE
		redefine
			work
		end;

creation

	make

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			new_file: PLAIN_TEXT_FILE;
			to_write: STRING;
			file_name: STRING;
			aok: BOOLEAN;
			show_text: SHOW_TEXT;
			char: CHARACTER;
			default_name: FILE_NAME
		do
			if tool.file_name /= Void then
				file_name := tool.file_name;
			else
				!! default_name.make_from_string (Project_directory);
				default_name.set_file_name ("Ace");
				default_name.add_extension ("ace");
				file_name := default_name
			end;
			!!new_file.make (file_name);

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
				new_file.putstring (to_write);
				char := to_write.item (to_write.count);
				if Platform_constants.is_unix and then char /= '%N' and then char /= '%R' then
						-- Add a carriage return like vi if there's none at the end 
					new_file.new_line
				end; 
				new_file.close;
				show_text ?= tool.last_format.associated_command;
				if show_text /= Void then
					--| Only set the file name if it is an Ace file
					--| (and not the show_clusters file name).
					Eiffel_ace.set_file_name (file_name);
				end;
				text_window.disable_clicking;
				tool.update_save_symbol;
			end
		end;

end -- class SAVE_SYSTEM
