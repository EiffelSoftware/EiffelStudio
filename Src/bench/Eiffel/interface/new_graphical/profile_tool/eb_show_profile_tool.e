indexing

	description:
		"Command to show the profile tool."
	date: "$Date$"
	revision: "$Revision$"

class EB_SHOW_PROFILE_TOOL

inherit

--	EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS
	EV_COMMAND

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [EV_CONTAINER]; data: EV_EVENT_DATA) is
		local
--			mp: MOUSE_PTR
			p_win: EB_PROFILE_WINDOW
	do
			if
				not profile_tool_is_valid
			then
				create p_win.make_top_level
				set_profile_tool (p_win.tool)
			end
			profile_tool.show
				-- should be `raise'
--			mp.restore
		end

feature -- Properties

--	name: STRING is
--		do
--			Result := Interface_names.f_Profile_tool
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Profile_tool
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

end -- class EB_SHOW_PROFILE_TOOL
