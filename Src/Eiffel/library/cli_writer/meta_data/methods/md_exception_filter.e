indexing
	description: "Description of an exception filter clause."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EXCEPTION_FILTER

inherit
	MD_EXCEPTION_CLAUSE
		rename
			class_token_or_filter_offset as filter_offset
		redefine
			filter_offset,
			is_defined,
			reset
		end

create
	make

feature -- Reset

	reset is
			-- Restore default values.
		do
			filter_offset := -1
			Precursor
		ensure then
			filter_offset_set: filter_offset = -1
		end

feature -- Status report

	is_defined: BOOLEAN is
			-- Is current a fully described exception clause?
		do
			Result := Precursor and then filter_offset >= 0 and then filter_offset <= handler_offset
		ensure then
			valid_filter_offset: Result implies (filter_offset >= 0 and then filter_offset <= handler_offset)
		end

	flags: INTEGER_16 is
			-- Flags of exception clause
		do
			Result := {MD_METHOD_CONSTANTS}.clause_filter
		ensure then
			definition: Result = {MD_METHOD_CONSTANTS}.clause_filter
		end

feature -- Access

	filter_offset: INTEGER
			-- Offset in bytes for filter-based exception handler in associated MD_METHOD_BODY

feature -- Modification

	set_filter_offset (offset: like filter_offset) is
			-- Set `filter_offset' to `offset'.
		require
			valid_filter_offset: offset >= 0
		do
			filter_offset := offset
		ensure
			filter_offset_set: filter_offset = offset
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
