note
	description: "Summary description for {IRON_SORTER_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SORTER_FACTORY [G]

inherit
	TABLE_ITERABLE [TUPLE [sorter: SORTER [G]; description: detachable READABLE_STRING_GENERAL], READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make_caseless (nb)
		end

feature -- Access

	sorter (a_name: READABLE_STRING_GENERAL): detachable IRON_SORTER [G]
		local
			n: STRING_32
			neg: BOOLEAN
		do
			create n.make_from_string_general (a_name)
			if n.starts_with ("-") then
				neg := True
				n.remove_head (1)
				n.to_lower
			end
			if attached items.item (n) as d then
				create Result.make (n, d.sorter)
				if neg then
					Result.set_is_reversed (neg)
				end
			end
		end

	sorter_description (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		local
			n: STRING_32
			neg: BOOLEAN
		do
			create n.make_from_string_general (a_name)
			if n.starts_with ("-") then
				neg := True
				n.remove_head (1)
				n.to_lower
			end
			if attached items.item (n) as d then
				if attached d.description as desc and then not desc.is_whitespace then
					Result := desc.as_string_32
				end
			end
		end

	items: STRING_TABLE [TUPLE [sorter: SORTER [G]; description: detachable READABLE_STRING_GENERAL]]

feature -- Status report

	count: INTEGER
		do
			Result := items.count
		end

	new_cursor: TABLE_ITERATION_CURSOR [TUPLE [sorter: SORTER [G]; description: detachable READABLE_STRING_GENERAL], READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Element change

	register_builder (a_name: READABLE_STRING_GENERAL; a_sorter: SORTER [G]; a_description: detachable READABLE_STRING_GENERAL)
		local
			n: STRING_32
		do
			create n.make_from_string_general (a_name)
			n.to_lower
			items.force ([a_sorter, a_description], n)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
