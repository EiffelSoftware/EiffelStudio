indexing

	description:	
		"Command to quit editing a file.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_FILE 

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end;

	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_changes,
			execute_warner_help as loose_changes
		end

creation

	make
	
feature -- Callbacks

	loose_changes is
			-- The user has been warned that he will lose his stuff
		do
			window_manager.close (tool);
		end;

	save_changes (argument: ANY) is
		do
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end

			loose_changes
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Quit 
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously a file.
		do
			if last_warner /= Void and argument = last_warner then
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					loose_changes
				end
			end
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Exit;
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exit;
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

end -- class QUIT_FILE
