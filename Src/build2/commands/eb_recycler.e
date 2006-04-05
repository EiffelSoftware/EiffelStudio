indexing
	description	: "Recycler for recyclable objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_RECYCLER

feature -- Basic operations

	destroy is
			-- To be called when Current has became useless.
		do
			if managed_recyclable_items /= Void then
				from
					managed_recyclable_items.start
				until		
					managed_recyclable_items.after
				loop
					managed_recyclable_items.item.recycle
					managed_recyclable_items.remove
				end
			end
		end

	add_recyclable (a_recyclable_item: EB_RECYCLABLE) is
			-- Add `a_recyclable_items' to the list of managed recyclable
			-- items.
		do
			if managed_recyclable_items = Void then
				create managed_recyclable_items.make (2)
			end
			managed_recyclable_items.extend (a_recyclable_item)
		end

	remove_recyclable (a_recyclable_item: EB_RECYCLABLE) is
			-- Remove `a_recyclable_items' from the list.
		do
			if managed_recyclable_items /= Void then
				managed_recyclable_items.prune_all (a_recyclable_item)
			end
		end

feature {NONE} -- Implementation

	managed_recyclable_items: ARRAYED_LIST [EB_RECYCLABLE];
			-- Registered recyclable items.
	



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


end -- class EB_RECYCLABLE