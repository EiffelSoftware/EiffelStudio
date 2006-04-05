indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_dialog_options ->  Caption_dialog_option | Class_dialog_option | Font_dialog_option |
--			   Menu_dialog_option | Style_dialog_option | Exstyle_dialog_option

class S_MORE_DIALOG_OPTIONS 

inherit
	RB_CHOICE

feature

	construct_name: STRING is
		once
			Result := "MORE_DIALOG_OPTIONS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			caption: CAPTION_DIALOG_OPTION
			class_option: CLASS_DIALOG_OPTION
			font: FONT_DIALOG_OPTION
			menu: MENU_DIALOG_OPTION
			style: STYLE_DIALOG_OPTION
			exstyle: EXSTYLE_DIALOG_OPTION
		once
			!! Result.make
			Result.forth

			!! caption.make
			put (caption)

			!! class_option.make
			put (class_option)

			!! font.make
			put (font)

			!! menu.make
			put (menu)

			!! style.make
			put (style)

			!! exstyle.make
			put (exstyle)
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
end -- class S_MORE_DIALOG_OPTIONS

