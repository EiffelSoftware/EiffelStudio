indexing

	description:
		"Put your description here."
	date: "$Date$"
	revision: "$Revision$"

class EB_SHOW_PREFERENCE_TOOL

inherit
	EB_SHARED_INTERFACE_TOOLS
	EV_COMMAND

	INTERFACE_NAMES

creation
	make

feature {NONE} -- Initialization

	make is
		do
		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [EV_CONTAINER]; data: EV_EVENT_DATA) is
		local
			p_win: EB_PREFERENCE_WINDOW
		do
			if
				not preference_tool_is_valid
			then
				create p_win.make_top_level
				set_preference_tool (p_win.tool)
			end
			preference_tool.show
				-- should be `raise'
		end

feature -- Properties

	name: STRING is 
		do
			Result := f_Preferences
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := m_Preferences
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

end -- class EB_SHOW_PREFERENCE_TOOL
