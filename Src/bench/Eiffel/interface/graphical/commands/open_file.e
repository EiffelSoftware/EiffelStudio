indexing

	description:	
		"Command to open a file";
	date: "$Date$";
	revision: "$Revision$"


class OPEN_FILE 

inherit

	PIXMAP_COMMAND;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as loose_changes
		end

creation

	make
	
feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialization of the command.
		do
			init (a_text_window)
		end;

feature -- Callbacks

	execute_warner_help is
			-- Useless here
		do
			-- Do Nothing
		end;

	loose_changes (argument: ANY) is
			-- The user has eventually been warned that he will lose his stuff
		local
			chooser: NAME_CHOOSER_W
		do
			chooser := name_chooser (popup_parent);
			chooser.call (Current) 
		end;
	
feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Open
		end;

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
					elseif f.exists and then not f.is_plain then
						warner (popup_parent).custom_call (Current, 
							w_Not_a_file_retry (fn), l_Ok, Void, l_Cancel);
					else
						warner (popup_parent).custom_call (Current, 
						w_Cannot_read_file_retry (fn), l_Ok, Void, l_Cancel);
					end
				else
					warner (popup_parent).custom_call (Current, 
						w_Not_a_file_retry (fn), l_Ok, Void, l_Cancel);
				end
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).call (Current, l_File_changed)
				else
					chooser := name_chooser (popup_parent);
					chooser.call (Current) 
				end
			end
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := l_Open
		end

end -- class OPEN_FILE
