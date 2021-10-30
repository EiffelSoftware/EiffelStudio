note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_WIDGET

inherit
	CONF_GUI_INTERFACE_CONSTANTS

	EVS_HELPERS

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_iron_service: ES_IRON_SERVICE)
			-- Build the iron package box.
		local
			vb, vb2,vb3: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			txt: EV_RICH_TEXT
			l_btn: EV_BUTTON
			l_package_name_label, l_info_label, l_location_label: EV_LABEL
			w: INTEGER
		do
			create on_install_actions
			create on_uninstall_actions
			create button_install
			create button_uninstall

			iron_service := a_iron_service

				-- text
			create vb2
			widget := vb2

			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			-----------------
			--| [ Package  ]
			--| [ Location ]
			--| [ Text     ] [Install]
			--| [          ] [Remove]

			create vb
			vb.set_padding_width (layout_constants.tiny_padding_size)
			vb2.extend (vb)

			create hb
			hb.set_padding (layout_constants.small_padding_size)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create l_package_name_label.make_with_text (conf_interface_names.iron_box_package_label)
			l_package_name_label.align_text_right
			hb.extend (l_package_name_label)
			hb.disable_item_expand (l_package_name_label)
			create field_package_name
			hb.extend (field_package_name)

			create hb
			hb.set_padding (layout_constants.small_padding_size)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create l_location_label.make_with_text (conf_interface_names.iron_box_location_label)
			l_location_label.align_text_right
			hb.extend (l_location_label)
			hb.disable_item_expand (l_location_label)
			create field_location
			hb.extend (field_location)

			create hb
			hb.set_padding (layout_constants.small_padding_size)
			vb.extend (hb)


			create l_info_label.make_with_text (conf_interface_names.iron_box_information_label)
			l_info_label.align_text_right
			hb.extend (l_info_label)
			hb.disable_item_expand (l_info_label)

			create txt
			field_text := txt
			hb.extend (txt)
			txt.set_minimum_height (80)
			txt.disable_edit

			create vb3
			hb.extend (vb3)
			hb.disable_item_expand (vb3)

			l_btn := button_install
			l_btn.set_text (conf_interface_names.iron_box_install_label)
			l_btn.disable_sensitive
			vb3.extend (l_btn)
			vb3.disable_item_expand (l_btn)
			l_btn.select_actions.extend (agent on_install)
			layout_constants.set_default_width_for_button (l_btn)

			l_btn := button_uninstall
			l_btn.set_text (conf_interface_names.iron_box_remove_label)
			l_btn.disable_sensitive
			vb3.extend (l_btn)
			vb3.disable_item_expand (l_btn)
			l_btn.select_actions.extend (agent on_uninstall)
			layout_constants.set_default_width_for_button (l_btn)

			w := l_package_name_label.minimum_width.max (l_location_label.minimum_width).max (l_info_label.minimum_width)
			l_package_name_label.set_minimum_width (w + 3)
			l_location_label.set_minimum_width (w + 3)
			l_info_label.set_minimum_width (w + 3)
		end

	iron_service: ES_IRON_SERVICE

feature -- Actions

	on_install_actions: ACTION_SEQUENCE [TUPLE [IRON_PACKAGE]]

	on_uninstall_actions: ACTION_SEQUENCE [TUPLE [IRON_PACKAGE]]

	on_install
		do
			if attached package as p then
				on_install_actions.call ([p])
			else
				check has_package: False end
			end
		end

	on_uninstall
		do
			if attached package as p then
				on_uninstall_actions.call ([p])
			else
				check has_package: False end
			end
		end

feature -- Access

	widget: EV_WIDGET

	package: detachable IRON_PACKAGE
			-- Iron package.

feature {NONE} -- Widgets		

	field_package_name: EV_TEXT_FIELD
			-- Package name field.

	field_location: EV_TEXT_FIELD
			-- Location/uri field.

	field_text: EV_RICH_TEXT
			-- Overview of the iron package.

	is_installed: BOOLEAN

	button_install: EV_BUTTON

	button_uninstall: EV_BUTTON

feature -- Element change

	set_package (p: detachable IRON_PACKAGE)
		local
			txt: like field_text
			i,j: INTEGER
			l_inst_path: PATH
			l_api: IRON_INSTALLATION_API
		do
			is_installed := False

			button_install.disable_sensitive
			button_uninstall.disable_sensitive
			package := p
			txt := field_text
			txt.enable_edit
			txt.remove_text
			field_location.enable_edit
			field_package_name.enable_edit

			field_location.remove_text
			field_package_name.remove_text

			if p /= Void then
				field_package_name.set_text (p.human_identifier)
				field_location.set_text (p.location.string)

				l_api := iron_service.installation_api
				is_installed := l_api.is_package_installed (p)
				if is_installed then
					button_uninstall.enable_sensitive
				else
					button_install.enable_sensitive
				end

--				txt.set_current_format (normal_text_format)
--				i := txt.text_length
--				txt.append_text (conf_interface_names.iron_box_package_label)
--				j := txt.text_length + 1
--				txt.format_region (i, j, keyword_text_format)
--				txt.append_text (" ")

--				i := txt.text_length
--				txt.append_text (p.human_identifier)
--				j := txt.text_length + 1
--				txt.format_region (i, j, name_text_format)
--				txt.append_text ("%N")

				if attached p.description as desc and then not desc.is_empty then
					i := txt.text_length + 1
					txt.append_text (desc)
					if not desc.ends_with_general ("%N") then
						txt.append_text ("%N")
					end

					j := txt.text_length + 1
					txt.format_region (i, j, description_text_format)
					txt.append_text ("%N")
				end
				if attached p.tags as p_tags and then not p_tags.is_empty then
					i := txt.text_length + 1

					txt.append_text (conf_interface_names.iron_box_tags_label)
					j := txt.text_length + 1
					txt.format_region (i, j, keyword_text_format)

					txt.append_text (":")
					i := txt.text_length + 1
					across
						p_tags as ic
					loop
						txt.append_text (" ")
						txt.append_text (ic)
					end
					j := txt.text_length + 1
					txt.format_region (i, j, tags_text_format)

					txt.append_text ("%N")
				end

				if attached p.items as p_items then
					across
						p_items as ic
					loop
						if @ ic.key.same_string ("description") then
								-- Already processed.
						else
							i := txt.text_length + 1
							txt.append_text (@ ic.key)
							j := txt.text_length + 1
							txt.format_region (i, j, keyword_text_format)

							txt.append_text (":")
							i := txt.text_length + 1
							if attached ic as s then
								txt.append_text (s)
							end
							txt.append_text ("%N")
							j := txt.text_length + 1
							txt.format_region (i, j, description_text_format)
						end
					end
				end
				i := txt.text_length + 1
				if is_installed then
					if attached l_api.projects_from_installed_package (p) as l_projects then
						l_inst_path := l_api.package_installation_path (p)
						txt.append_text ("%N")
						txt.append_text (conf_interface_names.iron_box_package_installed_message (if attached l_inst_path then l_inst_path else create {PATH}.make_empty end, l_projects))
						txt.append_text ("%N")
					end
				else
					if attached l_api.conflicting_available_package (p) as l_conflict then
						txt.append_text ("%N")
						txt.append_text (conf_interface_names.iron_box_install_conflicting_package_help (p.identifier, p.location.string, l_conflict.location.string))
						txt.append_text ("%N")
						txt.append_text ("%N")
						txt.append_text (conf_interface_names.iron_box_install_package_help (p.location.string))
					else
						txt.append_text ("%N")
						txt.append_text (conf_interface_names.iron_box_install_package_help (p.identifier))
					end
					txt.append_text ("%N")
				end
				j := txt.text_length + 1
				txt.format_region (i, j, description_text_format)
			end

			txt.disable_edit
			field_location.disable_edit
			field_package_name.disable_edit
		end

	normal_text_format: EV_CHARACTER_FORMAT
		once
			create Result.make_with_font (normal_font)
			Result.set_color (normal_fg_color)
		end

	keyword_text_format: EV_CHARACTER_FORMAT
		once
			create Result.make_with_font (keyword_font)
			Result.set_color (normal_fg_color)
		end

	name_text_format: EV_CHARACTER_FORMAT
		once
			create Result.make_with_font (name_font)
			Result.set_color (name_fg_color)
		end

	description_text_format: EV_CHARACTER_FORMAT
		once
			create Result.make_with_font (description_font)
			Result.set_color (normal_fg_color)
		end

	tags_text_format: EV_CHARACTER_FORMAT
		once
			create Result.make_with_font (tags_font)
			Result.set_color (tags_fg_color)
		end

	normal_font: EV_FONT
		once
			create Result
		end

	keyword_font: EV_FONT
		local
			ft: EV_FONT
		once
			ft := normal_font
			create Result.make_with_values (ft.family, {EV_FONT_CONSTANTS}.Weight_bold, ft.shape, ft.height)
		end

	name_font: EV_FONT
		local
			ft: EV_FONT
		once
			ft := normal_font
			create Result.make_with_values ({EV_FONT_CONSTANTS}.family_typewriter, {EV_FONT_CONSTANTS}.Weight_bold, ft.shape, ft.height)
		end

	description_font: EV_FONT
		local
			ft: EV_FONT
		once
			ft := normal_font
			create Result.make_with_values (ft.family, ft.weight, {EV_FONT_CONSTANTS}.shape_italic, ft.height)
		end

	tags_font: EV_FONT
		local
			ft: EV_FONT
		once
			ft := normal_font
			create Result.make_with_values (ft.family, ft.weight, {EV_FONT_CONSTANTS}.shape_italic, ft.height)
		end

	name_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (210, 0, 0)
		end

	normal_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
		end

	tags_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 210)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
