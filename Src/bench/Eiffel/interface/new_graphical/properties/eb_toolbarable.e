indexing
	description	: "Objects that can be contained in an EB_TOOLBAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TOOLBARABLE

feature -- Access

	name: STRING is
			-- Name of the command. Use to store the command in the
			-- preferences.
		deferred
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN): EV_TOOL_BAR_ITEM is
			-- Create a new toolbar item for Current
		deferred
		end

feature {EB_CUSTOMIZABLE_LIST_ITEM, EB_CUSTOM_TOOLBAR_LIST} -- Implementation

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the item.
		deferred
		end

	description: STRING is
			-- Description of the command as it appears in the
			-- "customize" dialog.
		deferred
		ensure
			description_set: Result /= Void and then not Result.is_empty
		end

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

end -- class EB_TOOLBARABLE
