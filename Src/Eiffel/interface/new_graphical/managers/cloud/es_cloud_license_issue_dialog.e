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

	SHARED_ES_CLOUD_NAMES
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S)
		do
			service := a_service
			make_with_title (cloud_names.title_license_issue)
		end

	initialize
		local
			lab: EV_LABEL
			errlab: like error_label
			cl: like inner_cell
			b_select, b_quit, b_check_again: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb,tvb: EV_VERTICAL_BOX
			sep: EV_HORIZONTAL_SEPARATOR
			min_but_w: INTEGER
			l_scaler: EVS_DPI_SCALER
			l_report_label: EVS_ELLIPSIS_LABEL
			l_weblnk, l_guestlnk: EV_HIGHLIGHT_LINK_LABEL
			l_split: EV_VERTICAL_SPLIT_AREA
			l_lic_txt: EV_TEXT_FIELD
		do
			Precursor

			create l_scaler.make
			create errlab
			error_label := errlab

			create cl
			inner_cell := cl

			set_size (l_scaler.scaled_size (350), l_scaler.scaled_size (150))
			min_but_w := l_scaler.scaled_size (80)
			create lab.make_with_text (locale.translation_in_context ("An issue occurred with your EiffelStudio license!", "cloud.info"))
			create l_lic_txt
			license_text := l_lic_txt

			create l_guestlnk.make_with_text (locale.translation_in_context ("Use EiffelStudio as Guest.", "cloud.info"))
			l_guestlnk.set_tooltip (locale.translation_in_context ("You can continue using EiffelStudio as a guest account for now.", "cloud.info"))
			l_guestlnk.select_actions.extend (agent on_guest)

			create l_weblnk.make_with_text (locale.translation_in_context ("Please visit your web account.", "cloud.info"))
			l_weblnk.set_tooltip (locale.translation_in_context ("Please visit your web account for more information and options.", "cloud.info"))

			create b_select.make_with_text (cloud_names.button_select)
			button_select := b_select
			b_select.set_tooltip (cloud_names.tooltip_button_select)
			create b_quit.make_with_text (cloud_names.button_quit)
			b_quit.set_tooltip (cloud_names.tooltip_button_quit)
			create b_check_again.make_with_text (cloud_names.button_check_again)
			b_check_again.set_tooltip (cloud_names.tooltip_button_check_again)
			create vb
			vb.set_padding_width (l_scaler.scaled_size (5))
			vb.set_border_width (l_scaler.scaled_size (3))



			create l_split
			vb.extend (l_split)

			create tvb
			tvb.set_padding_width (l_scaler.scaled_size (5))
			tvb.set_border_width (l_scaler.scaled_size (3))

			tvb.extend (lab)
			tvb.disable_item_expand (lab)

			l_lic_txt.hide
			tvb.extend (l_lic_txt)
			tvb.disable_item_expand (l_lic_txt)

			tvb.extend (errlab)
			l_split.set_first (tvb)
			l_split.set_second (cl)
			errlab.set_minimum_height (2 * errlab.font.height)
--			vb.disable_item_expand (errlab)
			errlab.hide
			cl.hide

			vb.extend (l_guestlnk)
			vb.disable_item_expand (l_guestlnk)

			vb.extend (l_weblnk)
			vb.disable_item_expand (l_weblnk)
			create l_report_label
			l_report_label.set_is_ellipsing_character (True)
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

			hb.extend (b_check_again)
			b_quit.set_minimum_width (min_but_w)
			hb.disable_item_expand (b_check_again)

			hb.extend (b_select)
			b_select.set_minimum_width (min_but_w)
			hb.disable_item_expand (b_select)
			b_select.hide

			hb.extend (b_quit)
			b_quit.set_minimum_width (min_but_w)
			hb.disable_item_expand (b_quit)

			set_default_cancel_button (b_check_again)

			b_select.select_actions.extend (agent on_select)
			b_check_again.select_actions.extend (agent on_retry)
			b_quit.select_actions.extend (agent on_quit)
			l_weblnk.select_actions.extend (agent on_web_account (l_report_label))

			extend (vb)
		end

feature -- Access: widgets

	error_label: EV_TEXT

	inner_cell: EV_CELL

	button_select: EV_BUTTON

	license_text: EV_TEXT_FIELD

feature -- Access

	service: ES_CLOUD_S

	issue: detachable ES_ACCOUNT_LICENSE_ISSUE
	installation: detachable ES_ACCOUNT_INSTALLATION

	alternative_license_selection: detachable TUPLE [license: ES_ACCOUNT_LICENSE; installation: ES_ACCOUNT_INSTALLATION; account: ES_ACCOUNT]

	set_issue (a_issue: ES_ACCOUNT_LICENSE_ISSUE)
		local
			t: STRING_32
			selbox: ES_CLOUD_LICENSE_SELECTION_BOX
			inst: ES_ACCOUNT_INSTALLATION
		do
			button_select.hide
			error_label.remove_text
			error_label.hide
			issue := a_issue
			inst := service.installation
			installation := inst
			if attached a_issue.license as lic then
				license_text.set_text (lic.key)
				license_text.show
			else
				license_text.hide
			end
			if attached a_issue.reason as l_reason then
				if
					l_reason.is_case_insensitive_equal_general ("license expired") or else
					(attached a_issue.license as lic and then lic.is_expired)
				then
					set_license_expired
				else
					set_title (l_reason)
				end
				create t.make_from_string_general (l_reason)
			elseif attached a_issue.license as lic then
				if lic.is_suspended then
					set_license_suspended
					create t.make_from_string_general (Cloud_names.title_license_suspended)
				elseif lic.is_expired then
					set_license_expired
					create t.make_from_string_general (Cloud_names.title_license_expired)
				else
					set_license_issue
				end
			else
				set_license_issue
			end
			if
				attached inst.adapted_licenses as lics and then
				not lics.is_empty and then
				attached service.active_account as acc
			then
				create selbox.make (service, acc, inst, agent on_license_selected (acc, inst, ?, ?))
				selbox.set_title (locale.translation_in_context ("Select a license (double-click to validate)", "cloud.info"))
				inner_cell.replace (selbox)
				inner_cell.show
				button_select.show
			else
				inner_cell.hide
			end
			if t /= Void and then not t.is_whitespace then
				error_label.set_text (t)
				error_label.show
			else
				error_label.hide
			end
		end

	set_license_expired
		do
			set_title (cloud_names.title_license_expired)
		end

	set_license_suspended
		do
			set_title (cloud_names.title_license_suspended)
		end

	set_license_issue
		do
			set_title (cloud_names.title_license_issue)
		end

feature -- Callbacks

	on_quit
		do
			service.quit
			close
		end

	on_retry
		do
			ev_application.add_idle_action_kamikaze (agent service.check_for_new_license)
			close
		end

	on_select
		do
			if
				attached alternative_license_selection as sel
			then
				service.update_installation_license (sel.account, sel.installation, sel.license)
				service.update_account (sel.account)
				close
			else
				check has_selected_license: False end
			end
		end

	on_license_selected (acc: ES_ACCOUNT; inst: ES_ACCOUNT_INSTALLATION; lic: detachable ES_ACCOUNT_LICENSE; lic_is_choosen: BOOLEAN)
		do
			if
				lic /= Void
			then
				alternative_license_selection := [lic, inst, acc]
				if lic_is_choosen then
					on_select
--					service.update_installation_license (acc, inst, lic)
--					service.update_account (acc)
--					close
				end
			else
				alternative_license_selection := Void
			end
			if alternative_license_selection /= Void then
				button_select.enable_sensitive
			else
				button_select.disable_sensitive
			end
		end

	on_guest
		do
			service.continue_as_guest
			close
		end

	on_web_account (a_report_label: EV_LABEL)
		do
			open_url (service.view_account_website_url, a_report_label)
		end

	close
		do
				-- Clean
			error_label.remove_text
			error_label.hide
			inner_cell.wipe_out
			inner_cell.hide
			issue := Void
			installation := Void
			alternative_license_selection := Void
			destroy
		end

feature {NONE} -- Implementatopm		

	open_url (a_url: READABLE_STRING_8; a_report_label: detachable EV_LABEL)
		local
			l_launcher: ES_CLOUD_URL_LAUNCHER
		do
			create l_launcher.make (a_url)
			l_launcher.set_status_label (a_report_label)
			l_launcher.set_associated_widget (Current)
			l_launcher.execute
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
