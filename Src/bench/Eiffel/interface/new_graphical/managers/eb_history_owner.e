indexing
	description: "Container for an history manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_HISTORY_OWNER

inherit
	EB_STONABLE

	EB_RECYCLABLE

	EB_RECYCLER
		rename
			destroy as recycle
		redefine
			recycle
		end

feature -- Access

	window: EV_WINDOW is
			-- A window that can receive warnings and other dialogs.
		deferred
		end

	history_manager: EB_HISTORY_MANAGER
			-- Manager for history. It encapsulates the history.

feature -- Removal

	recycle is
			-- Free references to `Current'.
		do
			Precursor {EB_RECYCLER}
			history_manager.recycle
		end

feature -- Status setting

	advanced_set_stone (a_stone: STONE) is
			-- 'Special' set_stone, which may do more than a basic `set_stone'.
		do
			set_stone (a_stone)
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

end -- class EB_HISTORY_OWNER
