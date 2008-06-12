indexing
	description: "[
		Base interface for all session data object structures
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	CELL_SESSION_DATA [G -> DEBUGGER_STORABLE_DATA_I]

inherit
	SESSION_DATA_I
		export
			{ANY} notify_session_of_value_change
		end

create
	put

feature {NONE} -- Initialization

	put (a_item: like item) is
			-- Make Current with `a_item'
		do
			replace (a_item)
		end

feature -- Access

	item: G
			-- Stored data

	prepare_for_storage is
		do
			notify_session_of_value_change
			if item /= Void then
				item.prepare_for_storage
			end
		end

feature -- Change

	replace (a_item: like item) is
			-- Set `item' to `a_item'
		do
			item := a_item
			if item /= a_item then
				notify_session_of_value_change
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
