indexing
	description: "Objects that represent a dialog informing the user that the%
		%object name they have just entered already exists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DUPLICATE_OBJECT_NAME_DIALOG

inherit

	EV_MESSAGE_DIALOG
		redefine
			initialize
		end

create
	make_with_text

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_MESSAGE_DIALOG}
			set_title (ev_question_dialog_title)
			set_pixmap (Default_pixmaps.Error_pixmap)
			set_buttons (<<"Modify", ev_cancel>>)
			set_default_push_button(button ("Modify"))
			set_default_cancel_button(button (ev_cancel))
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
		end
		
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


end -- class GB_DUPLICATE_OBJECT_NAME_DIALOG
