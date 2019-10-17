note
	description: "Summary description for {ES_CLOUD_PAUSE_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PAUSE_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S; a_title: READABLE_STRING_GENERAL)
		do
			service := a_service
			make_with_title (a_title)
		end

	initialize
		local
			lab: EV_LABEL
			b_continue, b_quit: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			sep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor
			set_size (400, 400)
			create lab.make_with_text ("[
					Another EiffelStudio session is running...
					
					Choose [Continue] to use EiffelStudio from this device.
				]")
			create b_continue.make_with_text ("Continue")
			create b_quit.make_with_text ("Quit")
			create vb
			vb.set_padding_width (5)
			vb.set_border_width (3)
			vb.extend (lab)
			create sep
			vb.extend (sep)
			vb.disable_item_expand (sep)
			create hb
			vb.set_padding_width (5)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.extend (b_quit)
			b_quit.set_minimum_width (200)
			hb.disable_item_expand (b_quit)
			hb.extend (b_continue)
			b_continue.set_minimum_width (200)
			hb.disable_item_expand (b_continue)
			set_default_cancel_button (b_continue)

			b_continue.select_actions.extend (agent on_continue)
			b_quit.select_actions.extend (agent on_quit)

			extend (vb)
		end

feature -- Access

	service: ES_CLOUD_S

feature -- Callbacks

	on_quit
		do
			service.quit
			close
		end

	on_continue
		do
			service.resume_active_session
			close
		end

	close
		do
			destroy
		end


note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
