indexing
	description	: "Names for buttons, labels, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	INTERFACE_NAMES

feature -- Labels names

	l_Library_name: STRING is			"Library Name"
	l_Done: STRING is					"Done"
	l_Compilable_libraries: STRING is	"Available libraries:"
	l_Libraries_to_compile: STRING is	"Libraries to precompile:"
	l_Yes: STRING is 					"Yes"
	l_No: STRING is 					"No"
	
feature -- Buttons names

	b_Add_all: STRING is				"Add all ->"
	b_Add: STRING is 					"Add ->"
	b_Remove_all: STRING is				"<- Remove all"
	b_Remove: STRING is					"<- Remove"
	b_Add_your_own_library: STRING is	"Add your own library...";

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
end -- class INTERFACE_NAMES
