note
	description	: "Recycler for recyclable objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_RECYCLER

obsolete
	"Use facilities in {EB_RECYCABLE} instead. Check `auto_recycle' and `delay_auto_recycle'"

feature -- Basic operations

	destroy
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
				managed_recyclable_items := Void
			end
		end

	add_recyclable (a_recyclable_item: EB_RECYCLABLE)
			-- Add `a_recyclable_items' to the list of managed recyclable
			-- items.
		do
			if managed_recyclable_items = Void then
				create managed_recyclable_items.make (2)
			end
			managed_recyclable_items.extend (a_recyclable_item)
		end

	recycle_item (a_recyclable: EB_RECYCLABLE)
			-- Recycle `a_recyclable' if it is in `managed_recyclable_items' and then remove it from `managed_recyclable_items'.
		require
			a_recyclable_attached: a_recyclable /= Void
		local
			l_cursor: CURSOR
			l_items: like managed_recyclable_items
			l_done: BOOLEAN
		do
			l_items := managed_recyclable_items
			l_cursor := l_items.cursor
			from
				l_items.start
			until
				l_items.after or l_done
			loop
				if l_items.item = a_recyclable then
					a_recyclable.recycle
					l_items.remove
					l_done := True
				else
					l_items.forth
				end
			end
		end

feature {NONE} -- Implementation

	managed_recyclable_items: ARRAYED_LIST [EB_RECYCLABLE];
			-- Registered recyclable items.

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

end -- class EB_RECYCLABLE
