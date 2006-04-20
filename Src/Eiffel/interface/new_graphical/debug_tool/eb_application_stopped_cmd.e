indexing
	description	: "Command for stopped applications."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_APPLICATION_STOPPED_COMMAND

inherit
	E_CMD
	SHARED_APPLICATION_EXECUTION
	EB_SHARED_INTERFACE_TOOLS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status: APPLICATION_STATUS
			call_stack_elem: CALL_STACK_ELEMENT
		do
			status := Application.status
			if Application.is_stopped and then status /= Void then
					-- Application has stopped 
					-- after receiving and updating stack info

				--| FIXME ARNAUD: Update the object tool here

					-- Display the callstack, the current object & the current stop point.
				Application.set_current_execution_stack (1)
				call_stack_elem := status.current_stack_element
				if call_stack_elem /= Void then
--|					debug_tool.show_current_stoppoint
--|					debug_tool.show_current_object
--|					debug_tool.display_exception_stack
				end
					-- Display the callstack arrow in all opened windows.
--|				window_manager.synchronize_with_callstack
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_APPLICATION_STOPPED_COMMAND
