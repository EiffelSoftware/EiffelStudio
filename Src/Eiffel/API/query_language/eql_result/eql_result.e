indexing
	description: "Object that represents a resultset from an EQL query"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_RESULT [G -> EQL_RESULT_ITEM]

inherit
	EQL_TREE_NODE [G]
		rename
			make as tree_node_make
		redefine
			itr,
			distinct_itr,
			modification_count,
			increase_modification_count
		end

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			node_list_make
			root_node := Current
		end

feature -- Iterator

	itr: EQL_RESULT_ITERATOR [G] is
			-- Iterator for Current
		do
			create Result.make (Current)
		end

	distinct_itr: EQL_DISTINCT_RESULT_ITERATOR [G] is
			-- Distinct iterator
		do
			create Result.make (Current)
		end

feature{EQL_ITERATOR} -- Modification counter

	modification_count: NATURAL_64
			-- Count of modification, used by fail fast iterators

feature{EQL_TREE_NODE} -- Modification counter operation

	increase_modification_count is
			-- Increase `modification_count' by `1'.
			-- If `modification_count' reaches its `max_value', reset it to 0.
		do
			if modification_count = {NATURAL_64}.max_value then
				modification_count := 0
			else
				modification_count := modification_count + 1
			end
		ensure then
			good_result: ((old modification_count = {NATURAL_64}.max_value) implies modification_count = 0) and
						 ((old modification_count < {NATURAL_64}.max_value) implies modification_count = old modification_count + 1)
		end

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
