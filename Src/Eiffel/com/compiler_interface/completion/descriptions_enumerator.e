indexing
	description: "Enumerator of feature descriptions. Used by completion to calculate%
					%description dynamically for better performance"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DESCRIPTIONS_ENUMERATOR

inherit
	IEIFFEL_ENUM_STRING_IMPL_STUB
		redefine
			count,
			ith_item,
			next,
			reset,
			skip
		end

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty is
			-- Initialize `Current'.
		do
			create features.make (1, 0)
			count := 0
		end

	make (completion_features: ARRAYED_LIST [COMPLETION_ENTRY]) is
			-- Initialize `Current'.
		require
			non_void_features: completion_features /= Void
		do
			features := completion_features
			count := features.count
			index := features.lower
		ensure
			features_set: features = completion_features
		end

feature -- Access

	count: INTEGER
			-- Descriptions count

feature -- Basic Operations

	ith_item (a_index: INTEGER; a_string: CELL [STRING]) is
			-- Retrieve enumerators ith item at `index'.
		do
			if a_index >= features.lower and a_index <= features.upper then
				a_string.put (features.item (a_index).signature)
			else
				a_string.put ("")
			end
		end

	next (a_string: CELL [STRING]; fetched: INTEGER_REF) is
			-- Go to next item in enumerator
		do
			if index >= features.lower and index <= features.upper then
				a_string.put (features.item (index).signature)
				fetched.set_item (1)
			else
				a_string.put ("")
				fetched.set_item (0)
			end
			index := index + 1
		end

	reset is
			-- Reset enumerator.
		do
			index := features.lower
		ensure then
			resetted: index = features.lower
		end

	skip (a_count: INTEGER) is
			-- Skip `a_count' items.
		do
			index := index + a_count
		ensure then
			skipped: index = old index + a_count
		end

feature {NONE} -- Implementation

	features: ARRAY [COMPLETION_ENTRY]
			-- Completion entries containing code to calculate descriptions

	index: INTEGER;
			-- Current index in enumeration

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
end -- class DESCRIPTIONS_ENUMERATOR
