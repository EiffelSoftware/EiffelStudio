note
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
		redefine
			internal_detach_entities
		end

feature -- Access

	window: EV_WINDOW
			-- A window that can receive warnings and other dialogs.
		deferred
		end

	history_manager: EB_HISTORY_MANAGER
			-- Manager for history. It encapsulates the history.

feature {NONE} -- Clean up

	internal_recycle
			-- Free references to `Current'.
		do
			if history_manager /= Void then
				history_manager.recycle
			end
		end

	internal_detach_entities
			-- Detaches objects from their container
		do
			history_manager := Void

			Precursor {EB_RECYCLABLE}
		end

feature -- Status setting

	advanced_set_stone (a_stone: STONE)
			-- 'Special' set_stone, which may do more than a basic `set_stone'.
		do
			set_stone (a_stone)
		end

	set_history_moving_cancelled (a_cancel: BOOLEAN)
			-- Set `history_moving_cancelled' with `a_cancel'.
		do
			history_moving_cancelled := a_cancel
		ensure
			set: history_moving_cancelled = a_cancel
		end

feature -- Status report

	history_moving_cancelled: BOOLEAN;
			-- Is history moving cancelled?
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

end -- class EB_HISTORY_OWNER
