indexing

	description:	
		"Command to print a text window";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_COMMAND 

inherit

	TOOL_COMMAND
		rename
			init as make
		end

creation
	make

feature -- Access

	print_window: PRINT_DIALOG;	
			-- Print dialog

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Print
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Print
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

feature -- Execution

	work (argument: ANY) is
			-- Popup the print dialog.
		do
			if Project_tool.initialized then
				if print_window = Void then
					!! print_window;
				end;
				print_window.popup (Current)
			end
		end;

feature -- Close window

	close_print_window is
			-- Close the print window.
		do
			if print_window /= Void then
				print_window.close
			end
		end;

end -- class PRINT_COMMAND
