note
	description: "Summary description for {ADD_LIBRARY_WIDGET}."
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_LIBRARY_WIDGET

inherit
	CONF_GUI_INTERFACE_CONSTANTS

	EVS_HELPERS

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET)
			-- Build the name + location + browse button.
		local
			fr: EV_FRAME
			vb,vb2: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_btn: EV_BUTTON
			l_name_label,l_location_label,l_info_label: EV_LABEL
			w: INTEGER
		do
			target := a_target
			create on_ok_actions
			create on_cancel_actions
			create button_location_browse
			create field_info

			create fr
			create vb2
			fr.extend (vb2)

			widget := fr
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create vb
			vb.set_padding (layout_constants.tiny_padding_size)
			vb2.extend (vb)

				-- name
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create l_name_label.make_with_text (conf_interface_names.dialog_create_library_name)
			hb.extend (l_name_label)
			hb.disable_item_expand (l_name_label)
			l_name_label.align_text_right

			create field_name
			hb.extend (field_name)
--			hb.disable_item_expand (field_name)

				-- location
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create l_location_label.make_with_text (conf_interface_names.dialog_create_library_location)
			hb.extend (l_location_label)
			hb.disable_item_expand (l_location_label)
			l_location_label.align_text_right

			hb2 := hb
--			create hb2
--			vb2.extend (hb2)
--			vb2.disable_item_expand (hb2)
--			hb2.set_padding (layout_constants.small_padding_size)

			create field_location
			hb2.extend (field_location)

			l_btn := button_location_browse
			l_btn.set_text (conf_interface_names.browse)
			l_btn.select_actions.extend (agent browse)
			l_btn.set_pixmap (conf_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

				-- Information
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			vb.extend (hb)
--			vb.disable_item_expand (hb)

			create l_info_label.make_with_text (conf_interface_names.dialog_create_library_information)
			hb.extend (l_info_label)
			hb.disable_item_expand (l_info_label)
			l_info_label.align_text_right

--			create field_info
			field_info.disable_edit
			field_info.set_minimum_height (60)
			hb.extend (field_info)


				-- Harmony...
			w := l_name_label.minimum_width.max (l_location_label.minimum_width).max (l_info_label.minimum_width)
			l_name_label.set_minimum_width (w + 3)
			l_location_label.set_minimum_width (w + 3)
			l_info_label.set_minimum_width (w + 3)

			-----------------
			--| [Ok] [Cancel]
			create hb
			vb2.extend (hb)
			vb2.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create l_btn.make_with_text (names.l_include)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			layout_constants.set_default_width_for_button (l_btn)

			create l_btn.make_with_text (names.b_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)
		end

feature -- Actions

	on_ok_actions: ACTION_SEQUENCE [TUPLE [ADD_LIBRARY_WIDGET]]

	on_cancel_actions: ACTION_SEQUENCE [TUPLE]

	on_ok
		do
			on_ok_actions.call ([Current])
		end

	on_cancel
		do
			on_cancel_actions.call
		end

feature -- Access

	target: CONF_TARGET

	widget: EV_WIDGET

	field_info: EV_RICH_TEXT
			-- Information text area.

	name: STRING_32
			-- Name of the library.
		do
			Result := field_name.text
		end

	location: STRING_32
			-- Location of the library configuration file, choosen by the user..
		do
			Result := field_location.text
		end

feature {NONE} -- Widgets		

	field_name: EV_TEXT_FIELD
			-- Field for the name of the library.

	field_location: EV_TEXT_FIELD
			-- Field for the location of the library configuration file, choosen by the user.

	button_location_browse: EV_BUTTON
			-- Button "browse" associated with `field_location'.

	browse_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a library
		local
			l_dir: DIRECTORY
		once
			create Result
			create l_dir.make_with_path (target.system.directory)
			if l_dir.is_readable then
				Result.set_start_path (l_dir.path)
			end
			Result.filters.extend ([config_files_filter, config_files_description])
			Result.filters.extend ([all_files_filter, all_files_description])
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_library (cfg: detachable CONF_SYSTEM_VIEW)
		do
			field_name.remove_text
			field_location.remove_text
			if cfg /= Void then
				field_name.set_text (cfg.library_target_name)
				set_location (cfg.original_location)
				set_info_from (cfg)
			else
				set_info_from (Void)
			end
		end

	set_name (a_name: READABLE_STRING_GENERAL)
		do
			field_name.set_text (a_name)
		end

	set_location (a_location: READABLE_STRING_GENERAL)
		do
			field_location.set_text (a_location)
			if a_location.starts_with ("iron:") then
				button_location_browse.hide
			else
				button_location_browse.show
			end
		end

	set_info_from (cfg: detachable CONF_SYSTEM_VIEW)
		local
			l_description: detachable READABLE_STRING_GENERAL
			i,j: INTEGER
			txt: like field_info
		do
			txt := field_info
			txt.enable_edit
			txt.remove_text

			if cfg /= Void then
				l_description := cfg.description
				if
					(l_description = Void or else l_description.is_whitespace) and then
					attached cfg.info ("description") as d
				then
					l_description := d
				end
				if l_description /= Void and then not l_description.is_empty then
					txt.append_text (l_description)
					if not l_description.ends_with ("%N") then
						txt.append_text ("%N")
					end
					j := txt.text_length + 1
					txt.format_region (i + 1, j, description_text_format)
					txt.append_text ("%N")
				end
				if attached cfg.info_items as l_items then
					across
						l_items as ic
					loop
						if @ ic.key.starts_with ("_") then
								-- Ignore.
						elseif @ ic.key.same_string ("description") then
								-- Already processed.
						elseif not @ ic.key.is_empty then
							i := txt.text_length
							txt.append_text (@ ic.key)
							j := txt.text_length + 1
							txt.format_region (i + 1, j, keyword_text_format)

							txt.append_text (":")
							i := txt.text_length
							txt.append_text (ic)
							txt.append_text ("%N")
							j := txt.text_length + 1
							txt.format_region (i + 1, j, description_text_format)
						end
					end
				end
			end
			txt.disable_edit
		end

feature {NONE} -- UI

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

feature {NONE} -- Actions

	browse
			-- Browse for a location.
		local
			win: detachable EV_WINDOW
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
			l_cfg_data: CONF_SYSTEM_VIEW
		do
			win := widget_top_level_window (widget)
			if win /= Void then
				if not field_location.text.is_empty then
					create l_loc.make (field_location.text, target)
					create l_dir.make_with_path (l_loc.evaluated_directory)
				end
				if l_dir /= Void and then l_dir.exists then
					browse_dialog.set_start_path (l_dir.path)
				end

				browse_dialog.show_modal_to_window (win)
				if attached browse_dialog.file_name as l_fn and then not l_fn.is_empty then
					create l_cfg_data.make (create {PATH}.make_from_string (l_fn), l_fn)
					if l_cfg_data.has_library_target then
						if
							attached l_cfg_data.conf_option as l_options and then
							l_options.is_void_safety_sufficient (target.options)
						then
							set_library (l_cfg_data)
						else
							prompts.show_question_prompt (conf_interface_names.add_non_void_safe_library, win, agent set_library (l_cfg_data), Void)
						end
					else
						prompts.show_error_prompt (conf_interface_names.file_is_not_a_library, win, Void)
					end
				end
			end
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
