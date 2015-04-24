note
	description: "Error for a clashing name of an identifier."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-21 04:05:33 +0400$"
	revision: "$Revision$"

class FRESH_IDENTIFIER_ERROR

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			help_file_name
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Creation

	make (c: AST_CONTEXT; n: ID_AS)
			-- Create error object for an entity named `n' in the context `c'.
		require
			c_attached: c /= Void
			n_attached: n /= Void
		do
			c.init_error (Current)
			set_entity_name (n.name_id)
			set_location (n)
		ensure
			entity_name_set: entity_name /= Void
		end

feature -- Error properties

	code: STRING = "FRESH_IDENTIFIER"
			-- <Precursor>

	help_file_name: STRING_8 = "Fresh_identifier_error"
			-- Help file name

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Entity: ")
			a_text_formatter.add (encoding_converter.utf8_to_utf32 (entity_name))
			a_text_formatter.add_new_line
		end

feature {NONE} -- Access

	entity_name: STRING
			-- Entity name.

feature {NONE} -- Modification

	set_entity_name (id: INTEGER)
			-- Assign name extracted from name ID `id' to `entity_name'.
		require
			valid_id: id >= 1
		do
			entity_name := Names_heap.item (id)
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end
