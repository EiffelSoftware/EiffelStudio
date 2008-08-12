indexing
	description	: "Command to perform a clipboard-paste operation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_EDITOR_PASTE_COMMAND

inherit
	EB_CLIPBOARD_COMMAND
		redefine
			executable,
			tooltext,
			pixel_buffer,
			mini_pixmap,
			mini_pixel_buffer
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		undefine
			internal_detach_entities
		redefine
			make,
			executable,
			internal_recycle
		end

	EB_EDITOR_COMMAND
		rename
			make as make_editor
		redefine
			internal_recycle,
			executable,
			mini_pixmap,
			mini_pixel_buffer,
			tooltext
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target) is
			-- Initialization
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_target)
			make_editor
			name := "Editor_paste"
			description := Interface_names.e_Paste
			tooltext := interface_names.b_paste
			tooltip := interface_names.f_paste
			pixel_buffer := pixmaps.icon_pixmaps.general_paste_icon_buffer
			pixmap := pixmaps.icon_pixmaps.general_paste_icon
			menu_name := interface_names.m_paste
			add_agent (agent execute_command)
			set_needs_editable (True)
		end

feature -- Status report

	executable: BOOLEAN is
			-- Is the operation possible?
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			Result := is_sensitive
		end

feature {NONE} -- Implementation

	execute_command is
			-- Execute the copy/copy/paste operation
		local
			l_editor: like editor
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			l_editor := editor
			if l_editor /= Void and then not l_editor.is_recycled and then l_editor.number_of_lines /= 0 then
				l_editor.run_if_editable (agent l_editor.paste)
			end
		end

	editor: EB_EDITOR is
			-- Editor corresponding to Current
		do
			Result := target.ui.current_editor
		end

	tooltext: STRING_GENERAL

	mini_pixmap: EV_PIXMAP

	mini_pixel_buffer: EV_PIXEL_BUFFER

	internal_recycle is
			-- Internal recycle
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}
			Precursor {EB_EDITOR_COMMAND}
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

end -- class EB_EDITOR_PASTE_COMMAND
