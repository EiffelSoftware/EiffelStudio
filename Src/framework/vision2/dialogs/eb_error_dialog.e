note
	description: "Error dialog"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision	: "$Revision$"

class
	EB_ERROR_DIALOG

inherit
	EV_ERROR_DIALOG
		redefine
			initialize
		end

	SHARED_BENCH_NAMES
		undefine
			default_create,
			copy
		end

create
	default_create,
	make_with_text,
	make_with_text_and_actions

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_ERROR_DIALOG}
			set_title (names.t_error)
			set_pixmap (Default_pixmaps.Error_pixmap)
			set_icon_pixmap (Default_pixmaps.Error_pixmap)
			set_buttons (<<names.b_abort, names.b_retry, names.b_ignore>>)
			set_default_push_button(button (names.b_retry))
			set_default_cancel_button(button (names.b_abort))
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
