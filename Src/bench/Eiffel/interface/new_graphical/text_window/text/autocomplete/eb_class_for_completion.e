indexing
	description: "A class to be inserted into the auto-complete list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_CLASS_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		redefine
			icon,
			tooltip_text,
			is_class,
			full_insert_name
		end

create
	make

create {EB_CLASS_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_class: like associated_class) is
			-- Creates and initializes a new class completion item
		require
			a_class_not_void: a_class /= Void
		do
			make_with_name (a_class.name)
			associated_class := a_class
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Access

	is_class: BOOLEAN is
			-- Is completion item a class?
		do
			Result := True
		end

	full_insert_name: STRING is
			-- Full name to insert in editor
		do
			Result := associated_class.name
		end

	icon: EV_PIXMAP is
			-- Associated icon based on data
		do
			Result := pixmap_from_class_i (associated_class)
		end

	tooltip_text: STRING is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			Result := Current.out.twin
		end

feature {NONE} -- Implementation

	associated_class: CLASS_I;
			-- Corresponding class

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

end -- class EB_CLASS_FOR_COMPLETION
