indexing
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
			generate as generate_attribute_table
		undefine
			is_routine_table,
			tmp_poly_table
		redefine
			is_polymorphic,
			make,
			merge,
			new_entry,
			write
		end

	ROUT_TABLE
		rename
			generate as generate_routine_table
		undefine
			is_attribute_table, write_for_type
		redefine
			is_polymorphic,
			make,
			merge,
			new_entry,
			write
		end

create
	make

feature {NONE} -- Creation

	make (routine_id: INTEGER) is
			-- Create table with associated `routine_id'
		do
			Precursor {ROUT_TABLE} (routine_id)
		end

feature -- Status report

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id?
		do
			Result := Precursor {ATTR_TABLE} (type_id) or else Precursor {ROUT_TABLE} (type_id)
		end

feature -- Access

	new_entry (f: FEATURE_I; c: INTEGER): ENTRY is
			-- New entry corresponding to `f' in class of class ID `c'
		do
			Result := f.new_rout_entry
			Result.set_class_id (c)
		end

feature -- Modification

	merge (other: like Current) is
			-- Put `other' into Current
		do
			Precursor (other)
		end

feature -- Code generation

	write is
			-- Generate table using writer.
		do
			generate_attribute_table (Attr_generator)
			generate_routine_table (Rout_generator)
		end

indexing
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
