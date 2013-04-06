note
	description: "A type represented by a lower and upper bound."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_INTERVAL_A

inherit
	ABSTRACT_TYPE_INTERVAL_A

create
	make

feature -- Initialization

	make (a_lower, a_upper: INHERITANCE_TYPE_A)
			-- Initialize Current with `a_lower' as `lower' and `a_upper' as `upper'.
		do
			lower := a_lower
			upper := a_upper
		ensure
			lower_set: lower = a_lower
			upper_set: upper = a_upper
		end

feature -- Visitor

	process (a_visitor: TYPE_A_VISITOR)
		do
			a_visitor.process_type_interval_a (Current)
		end

feature -- Access

	lower, upper: INHERITANCE_TYPE_A
			-- <Precursor>

	base_class: CLASS_C
			-- <Precursor>
		do
			Result := lower.base_class
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := lower.hash_code.bit_xor (upper.hash_code)
		end

	create_info: CREATE_INFO
			-- Byte code information for entity type creation
		do
			Result := lower.create_info
		end

feature -- Status report

	is_equivalent (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := lower.is_equivalent (other.lower) and upper.is_equivalent (other.upper)
		end

feature -- Generic conformance

	annotation_flags: NATURAL_16
			-- <Precursor>
		do
				-- Nothing to be done. An interval type
				-- does not carry any attachment, it is part of the lower
				-- and upper bounds.
		end

feature -- Output

	dump: STRING
		do
			create Result.make_from_string (lower.dump)
			Result.append (" .. ")
			Result.append (upper.dump)
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C)
			-- <Precursor>
		do
			lower.ext_append_to (a_text_formatter, c)
			a_text_formatter.add_space
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_dotdot, Void)
			a_text_formatter.add_space
			upper.ext_append_to (a_text_formatter, c)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
