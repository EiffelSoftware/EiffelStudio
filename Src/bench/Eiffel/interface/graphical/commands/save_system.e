
class SAVE_SYSTEM

inherit
	
	SHARED_WORKBENCH;	
	PROJECT_CONTEXT;
	SAVE_FILE
		redefine
			work
		end;

creation

	make
	
feature {NONE}

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
			if text_window.file_name /= Void then
				file_name := text_window.file_name;
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
				warner (text_window).gotcha_call (w_Not_a_plain_file (new_file.name))
			elseif
				new_file.exists and then (not new_file.is_writable)
			then
				aok := False;
				warner (text_window).gotcha_call (w_Not_writable (new_file.name))
			elseif
				(not new_file.exists) and then (not new_file.is_creatable)
			then
				aok := False;
				warner (text_window).gotcha_call (w_Not_creatable (new_file.name))
			end;

			if aok then
				new_file.open_write;
				to_write := text_window.text; 
				new_file.putstring (to_write);
				char := to_write.item (to_write.count);
				if char /= '%N' and then char /= '%R' then
						-- Add a carriage return like vi if there's none at the end 
					new_file.new_line
				end; 
				new_file.close;
				show_text ?= text_window.last_format;
				if show_text /= Void then
					--| Only set the file name if it is an Ace file
					--| (and not the show_clusters file name).
					Lace.set_file_name (file_name);
				end;
				text_window.clear_clickable;
				text_window.set_changed (false)
			end
		end;

	
end
