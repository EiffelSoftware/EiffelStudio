note
	description: "Progress events IDs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_EVENT_ID

feature -- Access

	Step: INTEGER = 1
			-- Increment progress by one
	
	Set_range: INTEGER = 2
			-- Set progress range
	
	Start: INTEGER = 4
			-- Start progress update

	Finish: INTEGER = 5
			-- Finish progress update

	Title: INTEGER = 6
			-- Set total progress title

feature -- Status Report

	is_valid_progress_event_id (a_id: INTEGER): BOOLEAN
			-- Is `a_id' a valid progress event id?
		do
			Result := a_id = Step or a_id = Set_range or
				a_id = Start or a_id = Finish or
				a_id = Title
		ensure
			definition: Result = (a_id = Step or a_id = Set_range or
				a_id = Start or a_id = Finish or
				a_id = Title)
		end

invariant
	step_is_valid: is_valid_progress_event_id (Step)
	set_range_is_valid: is_valid_progress_event_id (Set_range)
	start_is_valid: is_valid_progress_event_id (Start)
	finish_is_valid: is_valid_progress_event_id (Finish)
	title_is_valid: is_valid_progress_event_id (Title)

note
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
end -- class WIZARD_PROGRESS_EVENT_ID

