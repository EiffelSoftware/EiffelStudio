indexing

	description:	
		"Command to open a new ace file.";
	date: "$Date$";
	revision: "$Revision$"

class OPEN_SYSTEM 

inherit

	SHARED_EIFFEL_PROJECT;
	OPEN_FILE
		redefine
			work
		end;

creation

	make
	
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Open a file.
		local
			fn: STRING;
			f: PLAIN_TEXT_FILE;
			temp: STRING;	
			chooser: NAME_CHOOSER_W
		do
			if argument /= Void and then argument = last_name_chooser then
				fn := clone (last_name_chooser.selected_file);
				if not fn.empty then
					!! f.make (fn);
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						tool.show_file (f);
						Eiffel_ace.set_file_name (fn)
					elseif f.exists and then not f.is_plain then
						warner (popup_parent).custom_call (Current,
							w_Not_a_file_retry (fn), l_Ok, Void, l_Cancel)
					else
						warner (popup_parent).custom_call (Current, 
						w_Cannot_read_file_retry (fn), l_Ok, Void, l_Cancel);
					end
				else
					warner (popup_parent).custom_call (Current,
						w_Not_a_file_retry (fn), l_Ok, Void, l_Cancel)
				end
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).call (Current, l_File_changed)
				else
					chooser := name_chooser (popup_parent);
					last_name_chooser.call (Current) 
				end
			end
		end;

end -- class OPEN_SYSTEM
