indexing

	description:
		"Menu entry for Bench with a tick.";
	date: "$Date$";
	revision: "$Revision$"

class EB_TICKABLE_MENU_ENTRY

inherit
	TOGGLE_B
		rename
			make as button_make
		end;
	ISE_MENU_ENTRY
		redefine
			associated_command
		end;
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
			-- Initializes the button part.
		local
			act: STRING;
			m_name: STRING;
			p_tool: PROJECT_W;
			pos: INTEGER
		do
			m_name := a_cmd.menu_name;
			if is_windows then
				p_tool ?= a_parent.top;
				if p_tool = Void then
					pos := m_name.index_of ('%T', 1);
					if pos > 0 and then m_name.count > 1 then
						m_name := m_name.substring (1, pos - 1);
					end 
				end
			end;
			button_make (m_name, a_parent);
			act := a_cmd.accelerator;
			if act /= Void and then (not is_windows or else p_tool /= Void) then
				set_accelerator_action (act)
			end;
			add_activate_action (a_cmd, a_cmd.tool)
		end;

feature -- Properties

	associated_command: TOOL_COMMAND is
			-- The associated_command
		do	
		end;

feature -- Status setting

	set_selected (b:BOOLEAN) is
			-- Set the tick or un set it, according to `b'.
		do
			if b then
				set_toggle_on
			else
				set_toggle_off
			end
		end;

feature {NONE} -- Implementation

	is_windows: BOOLEAN is
			-- Is the current platform windows?
		once
			Result := Platform_constants.is_windows
		end;

end -- class EB_TICKABLE_MENU_ENTRY
