note
	description: "Error for a clashing name of an identifier."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
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
	make,
	make_from_context

feature {NONE} -- Creation

	make (n: ID_AS; f: detachable FEATURE_I; c: CLASS_C)
			-- Create error object for an entity named `n` in feature `f` of class `c`.
		require
			c_attached: attached c
			n_attached: attached n
		do
			set_class (c)
			set_written_class (c)
			if attached f then
				set_feature (f)
			end
			set_entity_name (n.name_id)
			set_location (n)
		ensure
			entity_name_set: attached entity_name
		end

	make_from_context (c: AST_CONTEXT; n: ID_AS)
			-- Create error object for an entity named `n` in the context `c`.
		require
			c_attached: attached c
			n_attached: attached n
		do
			c.init_error (Current)
			set_entity_name (n.name_id)
			set_location (n)
		ensure
			entity_name_set: attached entity_name
		end

feature -- Error properties

	code: STRING = "FRESH_IDENTIFIER"
			-- <Precursor>

	help_file_name: STRING_8 = "Fresh_identifier_error"
			-- Help file name

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		local
			u: UTF_CONVERTER
		do
			a_text_formatter.add ("Entity: ")
			a_text_formatter.add (u.utf_8_string_8_to_string_32 (entity_name))
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
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
