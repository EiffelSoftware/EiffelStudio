indexing
	description: "Skeleton for EDITOR_EIFFEL_SCANNER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_EIFFEL_SCANNER_SKELETON

feature -- Access

	current_class : CONF_CLASS
			-- Current class

	current_group : CONF_GROUP is
			-- Current group
		do
			if current_class /= Void then
				Result ?= current_class.group
			end
		end

feature -- Element change

	set_current_class (a_class : CONF_CLASS) is
			-- Set `current_class' with `a_class'
		do
			current_class := a_class
		end

feature {NONE} -- Implementation

	tmp_classes : LINKED_SET [CONF_CLASS]

	is_current_group_valid: BOOLEAN is
		do
			Result := current_class /= Void
			check
				Result implies current_group /= Void
			end
		end

	stone_of_class (a_class: CONF_CLASS): CLASSI_STONE is
			-- Stone of `a_class'
		require
			a_class_not_void: a_class /= Void
		local
			l_class: CLASS_I
		do
			l_class ?= a_class
			check
				l_class_not_void: l_class /= Void
			end
			if l_class.is_compiled then
				create {CLASSC_STONE}Result.make (l_class.compiled_class)
			else
				create Result.make (l_class)
			end
		ensure
			result_not_void: Result /= Void
		end

invariant
	invariant_clause: True -- Your invariant here

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
