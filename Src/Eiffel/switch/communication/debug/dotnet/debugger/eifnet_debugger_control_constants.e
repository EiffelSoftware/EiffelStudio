indexing
	description: "Constants used in stepping contexte"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_CONTROL_CONSTANTS

feature {NONE} -- Value

--	Cst_step_range_next: INTEGER is 1
--	Cst_step_range_into: INTEGER is 2
	
	Cst_control_continue: INTEGER is 1
	Cst_control_stop: INTEGER is 2
	Cst_control_kill: INTEGER is 3
	Cst_control_step_next: INTEGER is 5
	Cst_control_step_into: INTEGER is 6
	Cst_control_step_out: INTEGER is 7
	Cst_control_nothing: INTEGER is 9

feature {NONE} -- stepping name

	control_mode_to_string (a_mode: INTEGER): STRING is
		do
			inspect a_mode 
--			when Cst_step_range_next then Result := "RangeNext"
--			when Cst_step_range_into then Result := "RangeInto"
			when Cst_control_continue then Result := "Continue"
			when Cst_control_stop then Result := "Stop"
			when Cst_control_kill then Result := "Kill"
			when Cst_control_step_next then Result := "Next"
			when Cst_control_step_into then Result := "Into"
			when Cst_control_step_out then Result := "Out"
			when Cst_control_nothing then Result := "Nothing"
				
			else Result := "Unknown stepping mode !"
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

end -- class EIFNET_DEBUGGER_CONTROL_CONSTANTS
