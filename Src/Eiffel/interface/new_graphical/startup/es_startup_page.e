note
	description: "[
			Startup page structure.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STARTUP_PAGE

inherit
	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	ES_SHARED_FONTS_AND_COLORS

	SHARED_ES_CLOUD_SERVICE

	SHARED_LOCALE

create {ES_STARTUP_PAGE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_edition: EIFFEL_EDITION)
			-- Initialize `Current'.
		do
			eiffel_edition := a_edition
			terms_agreement_required := a_edition.is_branded_edition
			build_interface
		end

feature {NONE} -- Initialization

	build_interface
		local
			cl: EV_CELL
		do
			create dialog.make_with_title ("EiffelStudio")
			dialog.set_icon_pixmap (Pixmaps.icon_pixmaps.general_dialog_icon)
			dialog.set_icon_name ("Startup")
			create cl
			main_box := cl
			dialog.extend (cl)

			cl.set_background_color (colors.stock_colors.default_background_color)
		end

feature -- Execution

	start (win: EV_WINDOW)
		local
			acc: ES_ACCOUNT
		do
			if terms_agreement_required or is_cloud_enabled then
				if terms_agreement_required and not terms_accepted then
					switch_to_user_agreement_page
					show_modal_to_window (win)
				elseif is_cloud_enabled and then attached es_cloud_s.service as cld then
					if is_logged_in then
						acc := cld.active_account
					end
					if acc /= Void and then not acc.is_expired then --and then acc.has_active_plan then
						cld.on_account_signed_in (acc)
						on_next
					elseif {ES_IDE_SETTINGS}.cloud_required then
						switch_to_account_page (cld, if acc /= Void then acc.username else Void end, False)
						show_modal_to_window (win)
					else
						on_next
					end
				else
					on_next
				end
			else
				on_next
			end
		end

	switch_to_user_agreement_page
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			txt: EV_TEXT
			lnk: EV_LINK_LABEL
			eiffel_image: EV_PIXMAP
			but: EV_BUTTON
			l_focus: detachable EV_WIDGET
			bg,fg: EV_COLOR
		do
			bg := colors.stock_colors.color_read_write
			fg := colors.stock_colors.default_foreground_color

			create hb
			hb.set_border_width (layout_constants.default_border_size)
			hb.set_padding_width (layout_constants.default_padding_size)

			main_box.replace (hb)
			if terms_agreement_required then
				create vb
				eiffel_image :=	Pixmaps.bm_About.twin
				eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
				eiffel_image.set_background_color (bg)
				eiffel_image.set_foreground_color (fg)
				vb.extend (eiffel_image)
				vb.disable_item_expand (eiffel_image)
				vb.extend (create {EV_CELL})

				hb.extend (vb)
				hb.disable_item_expand (vb)

				create vb
				hb.extend (vb)
				vb.set_padding_width (layout_constants.default_padding_size)

--				if eiffel_edition.is_branded_edition then
--					create lab.make_with_text (locale.translation_in_context ("To continue using this branded edition of EiffelStudio, you must first agree with the license terms. If you do not agree with the terms, use another EiffelStudio Edition.", "license"))
--					vb.extend (lab)
--					vb.disable_item_expand (lab)
--				end

				create lab.make_with_text (interface_names.l_please_read_and_accept_terms)
				vb.extend (lab)
				vb.disable_item_expand (lab)

				create txt
				txt.set_text (terms_agreement_text)
				txt.disable_edit
				txt.set_background_color (bg)
				txt.set_foreground_color (fg)
				vb.extend (txt)
				txt.set_minimum_height (220)
				create lnk.make_with_text (interface_names.l_read_license_text)
				lnk.align_text_left
				lnk.select_actions.extend (agent on_license_selected)
				vb.extend (lnk)
				vb.disable_item_expand (lnk)

				create hb
				vb.extend (hb)
				vb.disable_item_expand (hb)

				hb.extend (create {EV_CELL})

					-- Vertical menu of buttons.
				create vb
				vb.set_padding_width (layout_constants.default_padding_size)
				vb.set_border_width (layout_constants.default_border_size)
				hb.extend (vb)
				hb.disable_item_expand (vb)


				create but.make_with_text_and_action (interface_names.b_continue, agent on_usage_accepted)
				layout_constants.set_default_size_for_button (but)
				l_focus := but
				append_label_and_item_horizontally (interface_names.l_agree_and_continue_with_terms, but, vb)

				if eiffel_edition.is_standard_edition then
					create but.make_with_text_and_action (interface_names.b_purchase, agent on_purchase_selected)
					layout_constants.set_default_size_for_button (but)
					append_label_and_item_horizontally (interface_names.l_purchase_license, but, vb)
				end

				create but.make_with_text_and_action (interface_names.b_reject_and_quit, agent on_quit)
				layout_constants.set_default_size_for_button (but)
				append_label_and_item_horizontally ("", but, vb)

				hb.extend (create {EV_CELL})
			end
			if l_focus /= Void then
				l_focus.set_focus
			end
			main_box.set_background_color (bg)
			main_box.propagate_background_color
		end

	switch_to_account_page (cld: ES_CLOUD_S; a_username: detachable READABLE_STRING_GENERAL; a_account_optional: BOOLEAN)
		require
			is_cloud_enabled: is_cloud_enabled
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			eiffel_image: EV_PIXMAP
			but: EV_BUTTON
			l_focus: detachable EV_WIDGET
			wid: ES_ACCOUNT_LOGIN_REGISTER_BOX
			bg: EV_COLOR
		do
			bg := colors.stock_colors.color_read_write
			create hb
			hb.set_border_width (layout_constants.default_border_size)
			hb.set_padding_width (layout_constants.default_padding_size)
			main_box.replace (hb)

				-- Logo column
			create vb
			eiffel_image :=	Pixmaps.bm_about.twin
			eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
			eiffel_image.set_background_color (bg)
			vb.extend (eiffel_image)
			vb.disable_item_expand (eiffel_image)
			vb.extend (create {EV_CELL})

			hb.extend (vb)
			hb.disable_item_expand (vb)

			create vb
			hb.extend (vb)

			vb.set_padding_width (layout_constants.default_padding_size)

			if {ES_IDE_SETTINGS}.cloud_required then
				create wid.make_cloud_required (cld)
			else
				create wid.make (cld)
			end
			if a_username /= Void then
				wid.set_username (a_username)
			end
			wid.next_actions.extend (agent on_next)
			vb.extend (wid)
			vb.disable_item_expand (wid)
			vb.extend (create {EV_CELL})

			if a_account_optional then
				create but.make_with_text_and_action (interface_names.b_close, agent on_close)
			else
				create but.make_with_text_and_action (interface_names.b_quit, agent on_quit)
			end
			layout_constants.set_default_width_for_button (but)
			append_label_and_item_horizontally ("", but, vb)


			if l_focus /= Void then
				l_focus.set_focus
			end
			main_box.set_background_color (bg)
			main_box.propagate_background_color
			wid.set_default_mode
		end

feature -- Access: edition		

	eiffel_edition: EIFFEL_EDITION

feature -- Status

	terms_agreement_required: BOOLEAN
			-- Is Current EiffelStudio the Standard edition?

	terms_accepted: BOOLEAN
		do
			Result := preferences.misc_data.terms_accepted
		end

	is_cloud_enabled: BOOLEAN
		do
			Result := es_cloud_s.service /= Void
		end

	is_logged_in: BOOLEAN
		do
			if attached es_cloud_s.service as cld then
				Result := cld.active_account /= Void
			else
					-- ES Cloud is not activated!
				Result := True
			end
		end

feature -- Text

	terms_agreement_text: STRING_32
		do
			Result := locale.translation_in_context ("To continue using this edition of EiffelStudio, you must first agree with the license terms. If you do not agree with the terms, use another EiffelStudio Edition.", "license")
			if eiffel_edition.is_branded_edition then
				if attached eiffel_edition.edition_terms as l_terms_of_use then
					Result.prepend_character ('%N')
					Result.prepend_character ('%N')
					Result.prepend (l_terms_of_use)
				end
				Result.prepend_character ('%N')
				Result.prepend_character ('%N')
				if attached eiffel_edition.edition_title as l_title then
					Result.prepend (l_title)
				else
					Result.prepend ({STRING_32}"EiffelStudio " + eiffel_edition.edition_name + " edition.")
				end
			end
		end

feature -- Access: widgets

	main_box: EV_CELL
	dialog: EV_DIALOG

feature -- Status report

	is_useable: BOOLEAN
		do
			Result := not dialog.is_destroyed
		end

feature -- Access: actions

	next_action: detachable PROCEDURE
	quit_action: detachable PROCEDURE

feature -- Event: license

	on_license_selected
		local
			cmd: EB_LICENSE_COMMAND
		do
			create cmd
			cmd.set_parent_window (dialog)
			cmd.execute
		end

	on_usage_accepted
		do
			preferences.misc_data.set_terms_accepted (True)
				-- Save preferences right away.
			preferences.preferences.save_preferences
			if is_cloud_enabled and then attached {ES_CLOUD_S} es_cloud_s.service as cld then
				if is_logged_in then
					on_next
				else
					switch_to_account_page (cld, Void, False)
				end
			else
				on_next
			end
		end

	on_purchase_selected
		do
			open_url ("https://www.eiffel.com/eiffelstudio/purchase/")
		end

feature -- Event: UI

	on_next
		do
			if
				is_cloud_enabled and then
				{ES_IDE_SETTINGS}.cloud_required and then
				attached es_cloud_s.service as cld and then
				not (cld.is_guest or cld.is_signed_in)
			then
				on_quit
			else
				on_close
				if attached next_action as act then
					act.call
				end
			end
		end

	on_quit
		do
			on_close
			if attached quit_action as act then
				act.call
			end
		end

	on_close
		do
			dialog.destroy
		end

	show_modal_to_window (w: EV_WINDOW)
		do
			dialog.show_modal_to_window (w)
		end

feature -- Change

	set_next_action (act: detachable PROCEDURE)
		do
			next_action := act
		end

	set_quit_action (act: detachable PROCEDURE)
		do
			quit_action := act
		end

feature {NONE} -- Implementation		

	open_url (a_url: READABLE_STRING_8)
		local
			popup: EV_POPUP_WINDOW
			t: EV_TIMEOUT
			lab: EV_LABEL
			is_launched: BOOLEAN
		do

			create popup.make_with_shadow
			create lab.make_with_text ("Open link " + a_url)
			popup.extend (lab)
			popup.set_size (200, 50)
			popup.set_position (dialog.x_position + (dialog.width - popup.width) // 2, dialog.y_position + (dialog.height - popup.height) // 2)
			lab.pointer_button_release_actions.extend (agent (i_popup: EV_POPUP_WINDOW; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
				do
					i_popup.destroy
				end (popup, ?, ?, ?, ?, ?, ?, ?, ?))
			popup.show_relative_to_window (dialog)

			is_launched := (create {ES_URI_LAUNCHER}).launch (a_url)
			if is_launched then
				create t.make_with_interval (5_000) -- 5 seconds
				t.actions.extend (agent popup.destroy)
			end
		end

	append_label_and_item_horizontally (a_label_text: READABLE_STRING_GENERAL; a_item: EV_WIDGET; a_container: EV_VERTICAL_BOX)
		local
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
		do
			create hb
			hb.set_padding_width (layout_constants.default_padding_size)
			a_container.extend (hb)
			a_container.disable_item_expand (hb)

			create lab.make_with_text (a_label_text)
			hb.extend (lab)
			hb.extend (a_item)
			hb.disable_item_expand (a_item)
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
