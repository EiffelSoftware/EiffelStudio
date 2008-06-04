indexing
	description	: "Mechanism to call an action when a file/pipe is changed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_IO_WATCHER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_action

feature {NONE} -- Initialization

	default_create is
			-- Create a default IO-listener. No action is associated, and
			-- therefore nothing will happen when the file/pipe is changed.
		do
			create implementation
		end

	make_with_action (an_action: like action) is
			-- Create an IO-listener with `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			default_create
			set_action (an_action)
		end

feature -- Access

	is_destroyed: BOOLEAN is
			-- Is `Current' destroyed?
		do
			Result := implementation.is_destroyed
		end

	destroy is
			-- Destroy `Current' and clean up.
		do
			implementation.destroy
		ensure
			is_destroyed: is_destroyed
		end

	action: PROCEDURE [ANY, TUPLE] is
			-- Callback feature called with the file/pipe is changed.
		do
			Result := implementation.action
		end

feature -- Element change

	set_action (an_action: like action) is
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
			not_destroyed: not is_destroyed
		do
			implementation.set_action (an_action)
		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_action
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	implementation: EB_IO_WATCHER_IMP;
			-- Platform dependent implementation.

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

end -- EB_IO_WATCHER

