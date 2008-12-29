note
	description: "Redirect values to strings at fixed%
			%list positions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_VALUE_LIST_REDIRECTOR

create
	make

feature -- Initialization

	make
			-- Initialize.
		do
			create redirection_list.make (1)
		end

	add_value_redirector (redirector: DV_VALUE_REDIRECTOR; position: INTEGER)
			-- Add redirection `redirector' at `position' in the list.
		require
			not_void: redirector /= Void
		local
			pair: DV_LOCATED_VALUE_REDIRECTOR
		do
			create pair
			pair.set_value_redirector (redirector)
			pair.set_location (position)
			redirection_list.extend (pair)
		end

feature -- Access

	redirected_list: ARRAYED_LIST [STRING]
			-- Last list set with redirections performed.
		require
			list_set: list_set
		do
			Result := result_list
		end

feature -- Status report

	list_set: BOOLEAN
			-- Has a list been set?
		do
			Result := result_list /= Void
		end

feature -- Basic operations

	redirect_list (list: ARRAYED_LIST [ANY])
			-- Redirect defined values of `list'.
			-- Values at redirection positions must be integer values.
		require
			not_void: list /= Void
		local
			position: INTEGER
			item: ANY
		do
			create result_list.make (list.count)
			from
				list.start
			until
				list.after
			loop
				item := list.item
				if item /= Void then
					result_list.extend (item.out)
				else
					result_list.extend ("")
				end
				list.forth
			end
			from
				redirection_list.start
			until
				redirection_list.after
			loop
				position := redirection_list.item.location
				result_list.put_i_th (redirection_list.item.value_redirector.redirected_value (list.i_th (position)), position)
				redirection_list.forth
			end
		ensure
			list_set: list_set
		end

feature {NONE} -- Implementation

	redirection_list: ARRAYED_LIST [DV_LOCATED_VALUE_REDIRECTOR]
			-- List of redirectors with positions of values to redirect.

	result_list: ARRAYED_LIST [STRING];
			-- Last list set with redirections performed (implementation).

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_VALUE_LIST_REDIRECTOR



