note
	description: "Error when a a local variable or argument name from an enclosing feature is reused."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VPIR1

inherit
	FEATURE_ERROR
		redefine
			build_explain, subcode
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Properties

	entity_name: STRING
			--Variable name in conflict

	code: STRING = "VPIR"
			-- Error code

	subcode: INTEGER
		do
			Result := 1
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Entity name: ")
			a_text_formatter.add (encoding_converter.utf8_to_utf32 (entity_name))
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_entity_name (s_id: INTEGER)
			-- Assign name extracted from name ID `s_id' to `local_name'.
		require
			valid_s_id: s_id >= 1
		do
			entity_name := Names_heap.item (s_id)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class VRLE1
