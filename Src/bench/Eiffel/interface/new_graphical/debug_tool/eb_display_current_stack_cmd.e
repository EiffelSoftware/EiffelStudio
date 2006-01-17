indexing
	description: "Command for to go and down an exception stack trace."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DISPLAY_CURRENT_STACK_CMD

inherit
	EB_TOOL_COMMAND
	SHARED_APPLICATION_EXECUTION
	EB_SHARED_INTERFACE_TOOLS

create
	make

feature -- Access

	go_up_one_level: BOOLEAN
			-- Go up one level in the stack

	go_up: EV_ARGUMENT1 [ANY] is
			-- Go up one level in the stack
		once
			create Result.make (Void)
		end

	go_down: EV_ARGUMENT1 [ANY] is
			-- go one level down
		once
			create Result.make (Void)
		end

--	name: STRING is
--			-- Name of command
--		do
--			if go_up_one_level then
--				Result := Interface_names.f_Up_stack
--			else
--				Result := Interface_names.f_Down_stack
--			end
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			if go_up_one_level then
--				Result := Interface_names.m_Up_stack
--			else
--				Result := Interface_names.m_Down_stack
--			end
--		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

--	symbol: EV_PIXMAP is
--			-- Symbol of command
--		do
--			if go_up_one_level then
--				Result := Pixmaps.bm_Up_stack
--			else
--				Result := Pixmaps.bm_Down_stack
--			end
--		end

feature -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
--			mp: MOUSE_PTR
			stack_num: INTEGER
			app_cmd: EB_APPLICATION_STOPPED_CMD
				--oops! to be redefined: app_cmd uses old features.
		do
			if Application.is_running and then Application.is_stopped then
				stack_num := Application.current_execution_stack_number
				if arg = go_up then
					stack_num := stack_num - 1
				else
					stack_num := stack_num + 1
				end
				if stack_num >= 1 and then 
					stack_num <= Application.number_of_stack_elements 
				then
					Application.set_current_execution_stack (stack_num)
					create app_cmd
					app_cmd.execute
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_DISPLAY_CURRENT_STACK_CMD
