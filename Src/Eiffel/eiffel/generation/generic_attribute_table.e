note
	description: "[
			Representation of a table of attributes originated from an attribute
			of a formal generic type for the final Eiffel executable.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class GENERIC_ATTRIBUTE_TABLE

inherit

	ATTR_TABLE [ROUT_ENTRY]
		rename
			generate_loop_initialization as generate_attribute_loop_initialization,
			generate as generate_attribute_table,
			make as make_poly
		undefine
			tmp_poly_table,
			merge,
			extend
		redefine
			generate_initialization,
			is_routine_table,
			new_entry,
			write
		end

	ROUT_TABLE
		rename
			generate as generate_routine_table,
			make as make_poly
		undefine
			is_attribute_table, write_for_type
		redefine
			generate_initialization,
			is_routine_table,
			new_entry,
			write
		end

create
	make

feature {NONE} -- Creation

	make (routine_id: INTEGER; is_based_on_formal_generic: BOOLEAN)
			-- Create table with associated `routine_id` that corresponds to an attribute
			-- of a formal generic type if `is_based_on_formal_generic`.
	do
		make_poly (routine_id)
		is_formal_generic_base := is_based_on_formal_generic
	ensure
		rout_id = routine_id
		is_formal_generic_base = is_based_on_formal_generic
	end

feature -- Status report

	is_routine_table: BOOLEAN
			-- <Precursor>
		do
			Result := is_formal_generic_base or has_body
		end

feature {NONE} -- Status report

	is_formal_generic_base: BOOLEAN
			-- Is base type a formal generic?

feature -- Access

	new_entry (f: FEATURE_I; t: CLASS_TYPE; d: BOOLEAN; c: INTEGER): ENTRY
			-- <Precursor>
		do
			Result := f.new_rout_entry (t, d, c)
		end

feature -- Code generation

	generate_initialization (buf: GENERATION_BUFFER; header_buf: GENERATION_BUFFER)
			-- <Precursor>
		do
			Precursor {ATTR_TABLE} (buf, header_buf)
			if is_formal_generic_base or else has_body then
					-- Generate routine table if routine table is unconditionally used or there is a self_initializing attribute.
				Precursor {ROUT_TABLE} (buf, header_buf)
			end
		end

	write
			-- Generate table using writer.
		do
			generate_attribute_table (Attr_generator)
			if is_formal_generic_base or else has_body then
					-- Generate routine table if routine table is unconditionally used or there is a self_initializing attribute.
				generate_routine_table (Rout_generator)
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
