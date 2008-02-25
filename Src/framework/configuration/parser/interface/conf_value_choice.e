indexing
	description: "Choice option value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONF_VALUE_CHOICE

inherit
	CONF_VALUE
		redefine
			default_create,
			out
		end

create {CONF_OPTION}

	default_create

feature {NONE} -- Creation

	default_create
		do
			count := 1
		end

feature -- Access

	item: NATURAL_8 assign put
			-- Currently selected index (if any)

	count: NATURAL_8 assign limit
			-- Total number of available indexes

feature -- Modification

	put (value: like item)
			-- Set `item' to `value'.
		require
			value_small_enough: value < count
		do
			item := value
			is_set := True
		ensure
			item_set: item = value
			is_set: is_set
		end

feature {CONF_OPTION} -- Modification

	limit (total: like count)
			-- Set `count' to `total'.
		require
			total_large_enough: total > item
		do
			count := total
		ensure
			count_set: count = total
		end

feature -- Output

	out: STRING
		do
			if is_set then
				Result := item.out
			else
				Result := ""
			end
		end

invariant
	positive_count: count > 0
	item_in_range: item < count

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
