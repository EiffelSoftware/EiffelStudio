indexing

	description:
		"Command to show the profile tool."
	date: "$Date$"
	revision: "$Revision$"

class EB_SHOW_PROFILE_TOOL

inherit

	EB_CONSTANTS
	ISE_COMMAND
	WINDOWS

feature {NONE} -- Execution

	work (arg: ANY) is
		local
			mp: MOUSE_PTR
--			p_tool: like profile_tool
			p_win: EB_PROFILE_WINDOW

			gtk_kernel: EB_KERNEL2
	do
			if Project_tool.initialized then
				!! mp.set_watch_cursor
				if profile_tool = Void then
--					!! p_tool.make (Current)
					create gtk_kernel.make
--					profile_tool_cell.put (p_tool)
--					profile_tool_cell.put (p_win.tool)
				end	
--				profile_tool.display
				mp.restore
			end
		end

feature -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Profile_tool
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Profile_tool
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {EB_PROFILE_TOOL} -- Implementation

	done_profiling is
			-- The profile has been closed.
		do
			profile_tool.hide
		end

end -- class EB_SHOW_PROFILE_TOOL
