indexing
	description: "[
		Error when XML representation of a class that belongs to an assembly
		is missing from the Eiffel assembly cache.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD62

inherit
	LACE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly; a_class: like external_class) is
			-- Create VD62 error using data from `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
			a_class_not_void: a_class /= Void
		do
			assembly := an_assembly
			external_class := a_class	
		ensure
			assembly_set: assembly = an_assembly
			external_class_set: external_class = a_class
		end

feature {NONE} -- Properties

	assembly: ASSEMBLY_I
			-- Assembly which refer to `referred_assembly' which is unknown.

	external_class: EXTERNAL_CLASS_I
			-- External class whose XML file representation is missing.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Assembly cluster name: ")
			a_text_formatter.add (assembly.cluster_name)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Assembly details: %"")
			assembly.format (a_text_formatter)
			a_text_formatter.add ("%"")
			a_text_formatter.add_new_line
			a_text_formatter.add ("Missing file: ")
			a_text_formatter.add (external_class.file_name)
			a_text_formatter.add_new_line
		end

invariant
	assembly_not_void: assembly /= Void
	external_class_not_void: external_class /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class VD62
