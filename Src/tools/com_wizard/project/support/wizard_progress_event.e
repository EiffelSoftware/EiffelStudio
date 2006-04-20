indexing
	description: "Progress event raised by manager, handled by GUI"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_EVENT

inherit
	EV_THREAD_EVENT
		rename
			make as thread_make
		end

	WIZARD_PROGRESS_EVENT_ID

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_value: ANY) is
			-- Initialize instance.
		require
			valid_id: is_valid_progress_event_id (a_id)
		do
			thread_make (a_id, severity_from_id (a_id), a_value)
		ensure
			id_set: id = a_id
			value_set: data = a_value
		end

feature -- Access

	value: INTEGER is
			-- Associated value if any
		local
			l_ref: INTEGER_REF
		do
			l_ref ?= data
			if l_ref /= Void then
				Result := l_ref.item
			end
		end

	text_value: STRING is
			-- Associated text value if any
		do
			Result ?= data
		end

feature {NONE} -- Implementation

	severity_from_id (a_id: INTEGER): INTEGER is
			-- Event severity
		do
			if a_id = Finish then
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Stop
			else
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Information
			end
		end
		
invariant
	valid_id: is_valid_progress_event_id (id)

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
end -- class WIZARD_PROGRESS_EVENT

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
