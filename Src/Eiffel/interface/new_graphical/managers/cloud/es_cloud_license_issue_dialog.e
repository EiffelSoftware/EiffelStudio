note
	description: "Summary description for {ES_CLOUD_LICENSE_ISSUE_DIALOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSE_ISSUE_DIALOG

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
			b_online, b_continue, b_quit: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			sep: EV_HORIZONTAL_SEPARATOR
			min_but_w: INTEGER
			l_scaler: EVS_DPI_SCALER
			l_report_label: EV_LABEL
			l_weblnk: EVS_HIGHLIGHT_LINK_LABEL
		do
			Precursor

			create l_scaler.make

			set_size (l_scaler.scaled_size (350), l_scaler.scaled_size (150))
			min_but_w := l_scaler.scaled_size (80)
			create lab.make_with_text ("[
					Your EiffelStudio license expired!
					
					Choose [Guest] to use EiffelStudio as Guest account.
				]")

			create l_weblnk.make_with_text ("Please visit your web account for options.")

			create b_online.make_with_text ("Visit Web Account")
			create b_continue.make_with_text ("Guest")
			create b_quit.make_with_text ("Quit")
			create vb
			vb.set_padding_width (l_scaler.scaled_size (5))
			vb.set_border_width (l_scaler.scaled_size (3))
			vb.extend (lab)
			vb.extend (l_weblnk)
			vb.disable_item_expand (l_weblnk)
			create l_report_label
			l_report_label.hide
			vb.extend (l_report_label)
			vb.disable_item_expand (l_report_label)
			create sep
			vb.extend (sep)
			vb.disable_item_expand (sep)
			vb.set_padding_width (l_scaler.scaled_size (5))

			create hb
			hb.set_padding_width (l_scaler.scaled_size (5))

			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})

			hb.extend (b_quit)
			b_quit.set_minimum_width (min_but_w)
			hb.disable_item_expand (b_quit)

			hb.extend (b_continue)
			b_continue.set_minimum_width (min_but_w)
			hb.disable_item_expand (b_continue)

			hb.extend (b_online)
			b_continue.set_minimum_width (min_but_w)
			hb.disable_item_expand (b_online)

			set_default_cancel_button (b_continue)

			b_continue.select_actions.extend (agent on_guest)
			b_quit.select_actions.extend (agent on_quit)
			b_online.select_actions.extend (agent on_web_account (l_report_label))
			l_weblnk.select_actions.extend (agent on_web_account (l_report_label))



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

	on_guest
		do
			service.continue_as_guest
			close
		end

	on_web_account (a_report_label: EV_LABEL)
		do
			open_url (service.associated_website_url, a_report_label)
		end

	close
		do
			destroy
		end

feature {NONE} -- Implementatopm		

	open_url (a_url: READABLE_STRING_8; a_report_label: detachable EV_LABEL)
		local
			l_launcher: ES_CLOUD_URL_LAUNCHER
		do
			create l_launcher.make (a_url)
			l_launcher.set_status_label (a_report_label)
--			l_launcher.set_associated_widget (widget)
			l_launcher.execute
		end


note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
