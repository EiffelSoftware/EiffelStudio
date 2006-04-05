indexing
	description: "Check to test if a list of classes is writable."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CLASSES_WRITABLE

inherit
	ERF_CHECK

	CONF_REFACTORING

create
	make

feature {NONE} -- Initialization

	make (a_classes: DS_HASH_SET [CLASS_I]) is
			-- Create check for `a_classes'.
		require
			a_classes_not_void: a_classes /= void
		do
			classes := a_classes
		end

feature -- Basic operation

	execute is
            -- Execute a check.
        local
        	l_class: CLASS_I
        do
        	conf_todo
        	success := True
        	from
        		classes.start
        	until
        		not success or classes.after
        	loop
        		l_class := classes.item_for_iteration
        		if l_class.is_read_only then
        			success := False
        			error_message := "The class "+l_class.name_in_upper+" is not writable."
        		end
        		classes.forth
        	end
        end

feature {NONE} -- Implementation

	classes: DS_HASH_SET [CLASS_I]
			-- The list of classes to check.

invariant
	classes_not_void: classes /= Void

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

end
