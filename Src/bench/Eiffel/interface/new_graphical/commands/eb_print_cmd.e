indexing
	description: "Command to print a formatted text"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINT_CMD

inherit
	EB_TEXT_TOOL_CMD
	EB_SHARED_INTERFACE_TOOLS

creation
	make

feature -- Access

--	print_window: PRINT_DIALOG	
			-- Print dialog

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Print
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Print
--		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature -- Execution

	execute is
			-- Popup the print dialog.
		local
			print_window: EB_PRINT_DIALOG	
		do
			if Eiffel_project.initialized then
				create print_window.make_default (tool)
				print_window.show
			end
		end

end -- class EB_PRINT_CMD
