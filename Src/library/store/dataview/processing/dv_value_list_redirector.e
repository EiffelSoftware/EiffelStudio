indexing
	description: "Redirect values to strings at fixed%
			%list positions"
	date: "$Date$"
	revision: "$Revision$"

class
	DV_VALUE_LIST_REDIRECTOR

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create redirection_list.make (1)
		end

	add_value_redirector (redirector: DV_VALUE_REDIRECTOR; position: INTEGER) is
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

	redirected_list: ARRAYED_LIST [STRING] is
			-- Last list set with redirections performed.
		require
			list_set: list_set
		do
			Result := result_list
		end

feature -- Status report

	list_set: BOOLEAN is
			-- Has a list been set?
		do
			Result := result_list /= Void
		end

feature -- Basic operations

	redirect_list (list: ARRAYED_LIST [ANY]) is
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

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_VALUE_LIST_REDIRECTOR



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

