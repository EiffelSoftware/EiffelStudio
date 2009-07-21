note
	description: "Check if a given class name is already used."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CHK_SAME_CLASS_NAME

inherit
	ERF_CHECK

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_group: CONF_GROUP; a_name: STRING)
			-- Create check for class name `a_name' in the context of `a_group'.
		require
			a_group_not_void: a_group /= Void
			a_name_not_void: a_name /= Void
		do
			new_name := a_name
			group := a_group
			error_message := interface_names.l_there_is_already_a_class_with_the_same_name
		end

feature -- Basic operation

	execute
            -- Execute a check.
		local
			l_class: detachable CLASS_I
        do
        	l_class := universe.safe_class_named (new_name, group)
        	if attached l_class then
        			-- Allows renames of classes on override clusters to names of classes
        			-- in overridden. I do not think the vice versa is required.
        		success := l_class.group.is_overriden and group.is_override
        	else
        		success := True
        	end
        end

feature {NONE} -- Implementation

	new_name: STRING
			-- The name to check.

	group: CONF_GROUP;
			-- The context to check.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
