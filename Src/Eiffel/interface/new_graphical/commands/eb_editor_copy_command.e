note
	description	: "Command to perform a clipboard-copy operation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_EDITOR_COPY_COMMAND

inherit
	EB_ON_SELECTION_COMMAND
		redefine
			initialize
		end

create
	make


feature {NONE} -- Initialization

	initialize
			-- Initialize Command.
		do
			set_menu_name (Interface_names.M_copy)
			set_pixmap (Pixmaps.icon_pixmaps.general_copy_icon)
			set_pixel_buffer (Pixmaps.icon_pixmaps.general_copy_icon_buffer)
			set_name ("Editor_copy")
			set_tooltip (Interface_names.f_copy)
			set_tooltext (Interface_names.b_copy)
			add_agent (agent target.copy_selection)
			set_needs_editable (False)
		end

note
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

end -- class EB_EDITOR_COPY_COMMAND
