note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFICATION_STACK

create
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER)
		do
			create items.make (1, a_count)
			insertion_index := items.lower
		end

feature -- Element change

	wipe_out
		do
			items.discard_items
			insertion_index := items.lower
			count := 0
		end

	put (m: NOTIFICATION_MESSAGE)
		local
			i: INTEGER
		do
			i := insertion_index
			items.put (m, i)
			i := i + 1
			if i > items.upper then
				i := items.lower
			end
			insertion_index := i
			count := count + 1
		end

	delete (m: NOTIFICATION_MESSAGE)
		local
			i: INTEGER
			done: BOOLEAN
		do
			from
				i := items.lower
			until
				i > items.upper or done
			loop
				if items [i] = m then
					done := True
					items [i] := Void
					count := count - 1
				else
					i := i + 1
				end
			end
		end

feature -- Access

	count: INTEGER

	count_of_unacknowledged_items: INTEGER
		do
			across
				items as ic
			loop
				if attached ic.item as msg and then not msg.is_acknowledged then
					Result := Result + 1
				end
			end
		end

	linear: LIST [NOTIFICATION_MESSAGE]
		local
			i: INTEGER
		do
			create {ARRAYED_LIST [NOTIFICATION_MESSAGE]} Result.make (items.count)
			i := insertion_index + 1
			from
				i := insertion_index
			until
				i > items.upper
			loop
				if attached items[i] as m then
					Result.force (m)
				end
				i := i + 1
			end
			if insertion_index > items.lower then
				i := items.lower
				from
					i := items.lower
				until
					i > insertion_index
				loop
					if attached items[i] as m then
						Result.force (m)
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	insertion_index: INTEGER

	items: ARRAY [detachable NOTIFICATION_MESSAGE]

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
