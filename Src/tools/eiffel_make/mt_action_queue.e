indexing
	description: "Safe list of actions for multithreaded system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_ACTION_QUEUE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize current
		do
			create mutex
			create actions.make (20)
		end

feature -- Element change

	extend (an_action: ROUTINE [ANY, TUPLE]) is
			-- Extend `an_action' to `actions'.
		require
			an_action_not_void: an_action /= Void
		do
			mutex.lock
			actions.extend (an_action)
			mutex.unlock
		end

	removed_element: ROUTINE [ANY, TUPLE] is
			-- Remove and return last element from `actions', if any.
			-- Otherwise do nothing and return Void.
			--| Not following CQS principle since it would not be thread safe.
		do
			mutex.lock
			if not actions.is_empty then
				actions.finish
				Result := actions.item
				actions.remove
			end
			mutex.unlock
		end

feature -- Status report

	count: INTEGER is
			-- Number of elements in `actions'.
		do
			mutex.lock
			Result := actions.count
			mutex.unlock
		ensure
			count_non_negative: Result >= 0
		end

feature {NONE} -- Implementation: access

	mutex: MUTEX
			-- Mutex used for protecting access to `actions'.

	actions: ARRAYED_LIST [ROUTINE [ANY, TUPLE]]
			-- List of actions being executed.

invariant
	mutex_not_void: mutex /= Void
	actions_not_void: actions /= Void

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
end
