indexing
	description	: "Abstract representation of a separator in a tool bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOOLBARABLE_SEPARATOR

inherit
	EB_TOOLBARABLE

	EB_CONSTANTS

create
	default_create

feature -- Status setting

	-- Contrary to EB_TOOLBARABLE_COMMAND's, a separator
	-- 		* is displayed by default (otherwise it wouldn't exist at all)
	-- 		* is necessarily not sensitive

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN): EV_TOOL_BAR_ITEM is
			-- Create a new toolbar item for Current
			-- display_text currently has only a compatibility role
		do
			create {EV_TOOL_BAR_SEPARATOR} Result
		end

feature -- Implementation

	pixmap: EV_PIXMAP is
			-- Picture representing a button in the customize toolbar dialog box
		once
			Result := Pixmaps.Icon_toolbar_separator
		end

	description: STRING is "Separator"
			-- Identifier of a separator in the customize toolbar dialog box

	name: STRING is "Separator";
			-- Name of the command. Use to store the command in the
			-- preferences.

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

end -- class EB_TOOLBARABLE_SEPARATOR
