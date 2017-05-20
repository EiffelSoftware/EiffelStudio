note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			on_menu_command,
			notify
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_RICH_EDIT_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_LANGUAGE_IDENTIFIERS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create input_locales.make_filled (({POINTER}).default ,1, 0)
			create log_font.make (12, "Courrier New")
			make_top (Title)
			resize (800, 680)
			set_menu (main_menu)
				-- Labels
			create input_locale_text.make(Current, "Input locale", 35, 45, 200, 20, -1)
			create change_font_text.make(Current, "Font Type", 270, 45, 200, 20, -1)
			create ime_name_text.make (Current, "Name", 50, 130, 200, 20, -1)
			create ime_description_text.make (Current, "Description", 50, 170, 200, 20, -1)
			create ime_property_text.make (Current, "Property", 50, 210, 200, 20, -1)
			create ime_conversion_text.make (Current, "Conversion Mode", 250, 130, 200, 20, -1)
			create ime_title_text_info.make (Current, "", 55, 145, 200, 20, -1)
			create ime_name_text_info.make (Current, "", 55, 145, 200, 20, -1)
			create ime_description_text_info.make (Current, "", 55, 185, 200, 20, -1)
			create ime_property_text_info.make (Current, "", 55, 225, 200, 75, -1)
			create ime_conversion_text_info.make(Current, "", 255, 145, 160, 80, -1)

				-- IME Controls
			create ime_group_box.make (Current, "Input Method Editor (IME)", 15, 15, 700, 320, -1)
			create ime_display_group_box.make (Current, "Input Method Editor", 35, 105, 385, 200, -1)
			create avail_input_locales_combo.make(Current, 35, 65, 200, 250, -1)
			create font_list.make (Current, 270, 65, 150, 170, -1)
			create lang_edit.make (Current, "", 450, 65, 220, 200, -1)
			create configure_ime_button.make (Current, "Configure IME..", 250, 230, 100, 30, -1)
			create control_button.make (Current, "Apply to all controls", 450, 275, 150, 30, -1)

				-- Controls
			create group_box.make (Current, "Controls", 15, 365, 700, 220, -1)
			create button.make (Current, "Button", 35, 400, 75, 30, -1)
			create check_box.make (Current, "Check box", 35, 450, 100, 15, -1)
			create radio_button.make (Current, "Radio Button", 35, 490, 120, 15, -1)
			create drop_down_combo_box.make(Current, 35, 530, 150, 50, -1)
			create single_selection_list_box.make (Current, 225, 400, 180, 80, -1)
			create multi_selection_list_box.make (Current, 225, 500, 180, 80, -1)
			create tree_view.make (Current, 435, 400, 150, 155, -1)

			create imm.make
			init_display

		ensure
			imm_attached: imm /= Void
			avail_input_locales_combo_attached: avail_input_locales_combo /= Void
		end

feature -- Access

		--IMM
	imm: detachable WEL_INPUT_METHOD_MANAGER
	input_locale: POINTER
	input_locales: ARRAY[POINTER]

		--Font
	log_font: WEL_LOG_FONT
	wel_font: detachable WEL_FONT

		--IME Controls
	lang_edit: detachable WEL_RICH_EDIT
	font_list: detachable WEL_DROP_DOWN_LIST_COMBO_BOX
	avail_input_locales_combo: detachable WEL_DROP_DOWN_LIST_COMBO_BOX
	configure_ime_button: detachable WEL_PUSH_BUTTON
	ime_group_box: detachable WEL_GROUP_BOX
	ime_display_group_box: detachable WEL_GROUP_BOX

	--Wel controls
	button: detachable WEL_PUSH_BUTTON
	control_button: detachable WEL_PUSH_BUTTON
	check_box: detachable WEL_CHECK_BOX
	group_box: detachable WEL_GROUP_BOX
	radio_button: detachable WEL_RADIO_BUTTON
	drop_down_combo_box: detachable WEL_DROP_DOWN_LIST_COMBO_BOX
	single_selection_list_box: detachable WEL_SINGLE_SELECTION_LIST_BOX
	multi_selection_list_box: detachable WEL_MULTIPLE_SELECTION_LIST_BOX
	tree_view: detachable WEL_TREE_VIEW

		--Labels
	input_locale_text, change_font_text: detachable DISPLAY_TEXT
	ime_name_text, ime_description_text, ime_property_text, ime_conversion_text: detachable DISPLAY_TEXT
	ime_title_text_info, ime_name_text_info, ime_description_text_info,
	ime_property_text_info, ime_conversion_text_info: detachable DISPLAY_TEXT

	main_menu: WEL_MENU
			-- Windows main menu created from resource
		once
			create Result.make_by_id (Idr_menu1_constant)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER)
			-- Perform menu command actions
		local
			conv_mode, wel_const: INTEGER
			l_imm: like imm
			l_lang_edit: like lang_edit
			l_input_editor: detachable WEL_INPUT_METHOD_EDITOR
		do
			l_imm := imm
			l_lang_edit := lang_edit
			check
				l_imm_attached: l_imm /= Void
				l_lang_edit_attached: l_lang_edit /= Void
			end
			l_imm.get_input_context (l_lang_edit.item)
			l_input_editor := l_imm.input_method_editor
			check l_input_editor_not_void: l_input_editor /= Void end
			l_input_editor.get_conversion_status
			conv_mode := l_input_editor.conversion_mode
			inspect menu_id
			when Idsoftkeyboard_constant then
				wel_const := {WEL_IME_CONSTANTS}.Ime_cmode_softkbd
				if (conv_mode.bit_and (wel_const) = wel_const) then
					l_input_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				else
					l_input_editor.set_conversion_status (conv_mode.bit_or (wel_const))
				end
			when Idshapefull_constant then
				wel_const := {WEL_IME_CONSTANTS}.Ime_cmode_fullshape
				if not (conv_mode.bit_and (wel_const) = wel_const) then
					l_input_editor.set_conversion_status (conv_mode.bit_or (wel_const))
				end
			when Idshapehalf_constant then
				wel_const := {WEL_IME_CONSTANTS}.Ime_cmode_fullshape
				if (conv_mode.bit_and (wel_const) = wel_const) then
					l_input_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			when Idnative_constant then
				wel_const := {WEL_IME_CONSTANTS}.Ime_cmode_native
				if not (conv_mode.bit_and (wel_const) = wel_const) then
					l_input_editor.set_conversion_status (conv_mode.bit_or (wel_const))
				end
			when Idalphanumeric_constant then
				wel_const := {WEL_IME_CONSTANTS}.Ime_cmode_native
				if (conv_mode.bit_and (wel_const) = wel_const) then
					l_input_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			end
			l_imm.release_input_context (l_lang_edit.item)
			refresh
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER)
			-- Notification loop
		local
			tmp_str: STRING_32
			cnt: INTEGER
			l_avail_input_locales_combo: like avail_input_locales_combo
		do
			if control = font_list then
				if attached font_list as l_font_list then
					create log_font.make (14, l_font_list.selected_string)
					change_font (log_font)
				end
			elseif control = avail_input_locales_combo then
				l_avail_input_locales_combo := avail_input_locales_combo
					-- Per creation routine postcondition and stable attribute property.
				check l_avail_input_locales_combo_attached: l_avail_input_locales_combo /= Void end
				from
					cnt := 0
				until
					cnt = input_locales.count
				loop
					if l_avail_input_locales_combo.selected_item = cnt then
						input_locale := input_locales.item (cnt + 1)
						cnt := input_locales.count
					else
						cnt := cnt + 1
					end
				end
				refresh
			elseif control = control_button then
				if attached lang_edit as l_lang_edit then
					if l_lang_edit.text.is_equal ("") then
						create tmp_str.make_from_string ("")
					else
						l_lang_edit.select_all
						tmp_str := l_lang_edit.selected_text
					end
					change_controls (tmp_str)
				end
			elseif control = configure_ime_button then
				if attached imm as l_imm and then l_imm.enabled and then l_imm.has_ime (l_imm.input_locale) then

					l_imm.ime_dialog_configure (item)
				else
					(create {WEL_MSG_BOX}.make).error_message_box (Void, "No Input Editor available", "IME not available")
				end
			end
		end

	class_background: WEL_BRUSH
			-- Standard window background color used to create the
			-- window class.
			-- Can be redefined to return a user-defined brush.
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	Title: STRING_32
			-- Window's title
		do
			create Result.make_from_string ("Unicode Example")
		end

	init_display
			-- Initialise display
		do
			if attached font_list as l_font_list then
				l_font_list.add_string("MS Shell Dlg")
				l_font_list.add_string("Arial")
				l_font_list.add_string("Georgia")
				l_font_list.add_string("Narkisim")
				l_font_list.add_string("MS UI Gothic")
				l_font_list.add_string("Gulim")
				l_font_list.add_string("Bauhaus 93")
				l_font_list.select_item (0)
				create log_font.make (14, l_font_list.selected_string)
				change_font (log_font)
				init_controls
			end
		end

	init_menu
			-- Initialize the main menu
		do
			if attached imm as l_imm and then l_imm.has_ime (l_imm.input_locale) then
				main_menu.enable_item (Idalphanumeric_constant)
				main_menu.enable_item (Idsoftkeyboard_constant)
				main_menu.enable_item (Idshapehalf_constant)
				main_menu.enable_item (Idnative_constant)
				main_menu.enable_item (Idshapefull_constant)
			else
				main_menu.disable_item (Idalphanumeric_constant)
				main_menu.disable_item (Idsoftkeyboard_constant)
				main_menu.disable_item (Idshapehalf_constant)
				main_menu.disable_item (Idnative_constant)
				main_menu.disable_item (Idshapefull_constant)
			end

		end

	init_controls
			-- Initialize controls
		do
			init_menu
			init_locale_list
			init_tree_view
			if attached lang_edit as l_lang_edit then
				l_lang_edit.set_text ("Rich Edit control")
				l_lang_edit.hide_vertical_scroll_bar
				l_lang_edit.hide_horizontal_scroll_bar
			end
			if attached drop_down_combo_box as l_drop_down_combo_box then
				l_drop_down_combo_box.insert_string_at ("Drop down combo", 0)
				l_drop_down_combo_box.select_item (0)
			end
			if attached single_selection_list_box as l_single_selection_list_box then
				l_single_selection_list_box.insert_string_at ("Single Selection List Box", 0)
			end
			if attached multi_selection_list_box as l_multi_selection_list_box then
				l_multi_selection_list_box.insert_string_at ("Multiple Selection List Box", 0)
				l_multi_selection_list_box.insert_string_at ("Multiple Selection List Box", 1)
			end
		end

	init_locale_list
			-- Add the available input locales to the list
		local
			cnt, langid: INTEGER
			lang_string: detachable STRING_32
			l_avail_input_locales_combo: like avail_input_locales_combo
		do
			if attached imm as l_imm then
				input_locales := l_imm.input_locales
				l_avail_input_locales_combo := avail_input_locales_combo
					-- Per creation routine postcondition and stable attribute property.
				check l_avail_input_locales_combo_attached: l_avail_input_locales_combo /= Void end
				from
					cnt := 1
				until
					cnt = input_locales.count + 1
				loop
					langid := l_imm.get_language_identifier (input_locales.item (cnt))
					lang_string := identifiers.item (langid)
					if lang_string = Void then
						l_avail_input_locales_combo.add_string ("Unknown Language")
					else
						l_avail_input_locales_combo.add_string (lang_string)
					end
					cnt := cnt + 1
				end
				l_avail_input_locales_combo.select_item (0)
			end
		end

	init_tree_view
			-- Initialise tree view control
		local
			l_tree_view: like tree_view
			handle, root_h: POINTER
			tree_view_insert_struct1, tree_view_insert_struct2, tree_view_insert_struct3: WEL_TREE_VIEW_INSERT_STRUCT
			tree_view_item1, tree_view_item2, tree_view_item3: WEL_TREE_VIEW_ITEM
		do
			l_tree_view := tree_view
			check l_tree_view_attached: l_tree_view /= Void end
			create tree_view_insert_struct1.make
			tree_view_insert_struct1.set_root
			create tree_view_item1.make
			tree_view_item1.set_text ("Tree View Control")
			tree_view_insert_struct1.set_tree_view_item (tree_view_item1)
			l_tree_view.insert_item (tree_view_insert_struct1)
			root_h := l_tree_view.last_item

			create tree_view_insert_struct2.make
			tree_view_insert_struct2.set_last
			tree_view_insert_struct2.set_parent (root_h)
			create tree_view_item2.make
			tree_view_item2.set_text ("Subtree 1")
			tree_view_insert_struct2.set_tree_view_item (tree_view_item2)
			l_tree_view.insert_item (tree_view_insert_struct2)
			handle := l_tree_view.last_item

			create tree_view_insert_struct3.make
			tree_view_insert_struct3.set_last
			tree_view_insert_struct3.set_parent (handle)
			create tree_view_item3.make
			tree_view_item3.set_text ("Item 1")
			tree_view_insert_struct3.set_tree_view_item (tree_view_item3)
			l_tree_view.insert_item (tree_view_insert_struct3)

			create tree_view_insert_struct3.make
			tree_view_insert_struct3.set_last
			tree_view_insert_struct3.set_parent (handle)
			create tree_view_item3.make
			tree_view_item3.set_text ("Item 2")
			tree_view_insert_struct3.set_tree_view_item (tree_view_item3)
			l_tree_view.insert_item (tree_view_insert_struct3)

			l_tree_view.select_item (tree_view_item1)
		end

	change_controls (str: STRING_32)
			-- Change the controls text to that of rich edit
		local
			tvitem: WEL_TREE_VIEW_ITEM
		do
			if attached button as l_button then
				l_button.set_text (str)
			end
			if attached check_box as l_check_box then
				l_check_box.set_text (str)
			end
			if attached radio_button as l_radio_button then
				l_radio_button.set_text (str)
			end
			if attached drop_down_combo_box as l_drop_down_combo_box then
				l_drop_down_combo_box.select_item (0)
				l_drop_down_combo_box.delete_string (0)
				l_drop_down_combo_box.insert_string_at (str, 0)
				l_drop_down_combo_box.select_item (0)
			end
			if attached single_selection_list_box as l_single_selection_list_box then
				l_single_selection_list_box.delete_string (0)
				l_single_selection_list_box.insert_string_at (str, 0)
			end
			if attached multi_selection_list_box as l_multi_selection_list_box then
				l_multi_selection_list_box.delete_string (0)
				l_multi_selection_list_box.insert_string_at (str, 0)
				l_multi_selection_list_box.delete_string (1)
				l_multi_selection_list_box.insert_string_at (str, 1)
			end
			if attached tree_view as l_tree_view then
				tvitem := l_tree_view.selected_item
				tvitem.set_text (str)
				l_tree_view.set_tree_item (tvitem)
			end
		end

	change_font (new_font: WEL_LOG_FONT)
			-- Change the font used by the application controls to 'new_font'
		local
			char_format: WEL_CHARACTER_FORMAT
			l_wel_font: like wel_font
		do
			if attached font_list as l_font_list then
				create char_format.make
				char_format.set_face_name (l_font_list.selected_string)
				create l_wel_font.make_indirect (new_font)
				wel_font := l_wel_font
				l_wel_font.set_indirect (new_font)
				if attached lang_edit as l_lang_edit and then l_lang_edit.text_length > 0 then
					l_lang_edit.select_all
					l_lang_edit.set_character_format_selection (char_format)
				end
				setup_ime_display
			end
		end

	setup_ime_display
			-- Initialise the display for the IME display information
		local
			l_imm: like imm
			l_wel_font: like wel_font
		do
			l_imm := imm
			l_wel_font := wel_font
			check l_wel_font_attached: l_wel_font /= Void end
			l_wel_font.set_indirect (log_font)
			if l_imm = Void or else not l_imm.has_ime (l_imm.input_locale) then
					--hide IME info since no IME loaded
				if attached {DISPLAY_TEXT} ime_name_text as w1 then
					w1.hide
				end
				if attached {DISPLAY_TEXT} ime_description_text as w2 then
					w2.hide
				end
				if attached {DISPLAY_TEXT} ime_property_text as w3 then
					w3.hide
				end
				if attached {DISPLAY_TEXT} ime_conversion_text as w4 then
					w4.hide
				end
				if attached {DISPLAY_TEXT} ime_name_text_info as w5 then
					w5.hide
				end
				if attached {DISPLAY_TEXT} ime_description_text_info as w6 then
					w6.hide
				end
				if attached {DISPLAY_TEXT} ime_property_text_info as w7 then
					w7.hide
				end
				if attached {DISPLAY_TEXT} ime_conversion_text_info as w8 then
					w8.hide
				end
				if attached {DISPLAY_TEXT} configure_ime_button as w9 then
					w9.hide
				end
				if attached {DISPLAY_TEXT} ime_title_text_info as w10 then
					w10.show
					w10.set_font (l_wel_font)
					w10.set_text ("- " + "No IME loaded")
				end
			else
				if attached {DISPLAY_TEXT} ime_title_text_info as w11 then
					w11.hide
					w11.set_font (l_wel_font)
					w11.clear
				end
				if attached {DISPLAY_TEXT} ime_name_text as w12 then
					w12.show
					w12.set_font (l_wel_font)
				end
				if attached {DISPLAY_TEXT} ime_name_text_info as w13 then
					w13.show
					w13.set_font (l_wel_font)
					w13.set_text ("- " + l_imm.ime_filename)
				end
				if attached {DISPLAY_TEXT} ime_description_text as w14 then
					w14.show
					w14.set_font (l_wel_font)
				end
				if attached {DISPLAY_TEXT} ime_description_text_info as w15 then
					w15.show
					w15.set_font (l_wel_font)
					w15.set_text ("- " + l_imm.ime_description)
				end
				if attached {DISPLAY_TEXT} ime_property_text as w16 then
					w16.show
					w16.set_font (l_wel_font)
				end
				if attached {DISPLAY_TEXT} ime_property_text_info as w17 then
					w17.show
					w17.set_font (l_wel_font)
					w17.set_text (ime_properties)
				end
				if attached {DISPLAY_TEXT} ime_conversion_text as w18 then
					w18.show
					w18.set_font (l_wel_font)
				end
				if attached {DISPLAY_TEXT} ime_conversion_text_info as w19 then
					w19.show
					w19.set_font (l_wel_font)
					w19.set_text (ime_conversion_status)
				end
				if attached {DISPLAY_TEXT} configure_ime_button as w20 then
					w20.show
					w20.set_font (l_wel_font)
				end
			end
			if attached button as l_button then
				l_button.set_font (l_wel_font)
			end
			if attached check_box as l_check_box then
				l_check_box.set_font (l_wel_font)
			end
			if attached radio_button as l_radio_button then
				l_radio_button.set_font (l_wel_font)
			end
			if attached drop_down_combo_box as l_drop_down_combo_box then
				l_drop_down_combo_box.set_font (l_wel_font)
			end
			if attached single_selection_list_box as l_single_selection_list_box then
				l_single_selection_list_box.set_font (l_wel_font)
			end
			if attached multi_selection_list_box as l_multi_selection_list_box then
				l_multi_selection_list_box.set_font (l_wel_font)
			end
			if attached tree_view as l_tree_view then
				l_tree_view.set_font (l_wel_font)
			end
		end

	ime_properties: STRING_32
			-- Parse the properties of the current IME into string format
		local
			tmp_prop: INTEGER
			tmp_string: STRING_32
			l_imm: like imm
		do
			l_imm := imm
			check l_imm_attached: l_imm /= Void end
			create tmp_string.make (0)
			tmp_prop := l_imm.ime_property ({WEL_IME_CONSTANTS}.Igp_property)
			if (tmp_prop.bit_and ({WEL_IME_CONSTANTS}.Ime_prop_unicode) = {WEL_IME_CONSTANTS}.Ime_prop_unicode) then
				tmp_string.append ("- Unicode IME%N")
			else
				tmp_string.append ("- ANSI IME%N")
			end
			tmp_prop := l_imm.ime_property ({WEL_IME_CONSTANTS}.Igp_getimeversion)
			if (tmp_prop.bit_and ({WEL_IME_CONSTANTS}.Imever_0310) = {WEL_IME_CONSTANTS}.Imever_0310) then
				tmp_string.append ("- Windows 3.1 IME%N")
			else
				tmp_string.append ("- Windows 9x/Me IME%N")
			end
			tmp_prop := l_imm.ime_property ({WEL_IME_CONSTANTS}.Igp_setcompstr)
			if (tmp_prop.bit_and ({WEL_IME_CONSTANTS}.Scs_cap_compstr) = {WEL_IME_CONSTANTS}.Scs_cap_compstr) then
				tmp_string.append ("- Can set composition string%N")
			else
				tmp_string.append ("- Cannot set composition string%N")
			end
			tmp_prop := l_imm.ime_property ({WEL_IME_CONSTANTS}.Scs_cap_makeread)
			if (tmp_prop.bit_and ({WEL_IME_CONSTANTS}.Scs_cap_makeread) = {WEL_IME_CONSTANTS}.Scs_cap_makeread) then
				tmp_string.append ("- Can create reading string%N")
			else
				tmp_string.append ("- Cannot create reading string%N")
			end
			tmp_prop := l_imm.ime_property ({WEL_IME_CONSTANTS}.Scs_cap_setreconvertstring)
			if (tmp_prop.bit_and ({WEL_IME_CONSTANTS}.Scs_cap_setreconvertstring) = {WEL_IME_CONSTANTS}.Scs_cap_setreconvertstring) then
				tmp_string.append ("- Supports reconversion%N")
			else
				tmp_string.append ("- Does not support reconversion%N")
			end
			create Result.make_from_string (tmp_string)
		end

	ime_conversion_status: STRING_32
			-- Parse the properties of the current IME conversion mode into string format
		local
			tmp_string: STRING_32
			conv_mode, sent_mode: INTEGER
			l_imm: like imm
			l_lang_edit: like lang_edit
			l_input_editor: detachable WEL_INPUT_METHOD_EDITOR
		do
			l_imm := imm
			l_lang_edit := lang_edit
			check
				l_imm_attached: l_imm /= Void
				l_lang_edit_attached: l_lang_edit /= Void
			end
			create tmp_string.make (0)
			l_imm.get_input_context (l_lang_edit.item)
			l_input_editor := l_imm.input_method_editor
			check l_input_editor_not_void: l_input_editor /= Void end
			l_input_editor.get_conversion_status
			conv_mode := l_input_editor.conversion_mode
			sent_mode := l_input_editor.sentence_mode

			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_eudc) = {WEL_IME_CONSTANTS}.Ime_cmode_eudc ) then
				tmp_string.append ("- EUDC Conversion%N")
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_fixed) = {WEL_IME_CONSTANTS}.Ime_cmode_fixed ) then
				tmp_string.append ("- Fixed Conversion%N")
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_fullshape) = {WEL_IME_CONSTANTS}.Ime_cmode_fullshape ) then
				tmp_string.append ("- Full shape mode%N")
				main_menu.check_item (Idshapefull_constant)
				main_menu.uncheck_item (Idshapehalf_constant)
			else
				tmp_string.append ("- Half shape mode%N")
				main_menu.check_item (Idshapehalf_constant)
				main_menu.uncheck_item (Idshapefull_constant)
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_hanjaconvert) = {WEL_IME_CONSTANTS}.Ime_cmode_hanjaconvert ) then
				tmp_string.append ("- Hanja convert%N")
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_katakana) = {WEL_IME_CONSTANTS}.Ime_cmode_katakana ) then
				tmp_string.append ("- Katakana%N")
			else
				tmp_string.append ("- Hiragana%N")
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_native) = {WEL_IME_CONSTANTS}.Ime_cmode_native ) then
				tmp_string.append ("- Native mode%N")
				main_menu.check_item (Idnative_constant)
				main_menu.uncheck_item (Idalphanumeric_constant)
			else
				tmp_string.append ("- Alphanumeric Mode%N")
				main_menu.check_item (Idalphanumeric_constant)
				main_menu.uncheck_item (Idnative_constant)
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_noconversion) = {WEL_IME_CONSTANTS}.Ime_cmode_noconversion ) then
				tmp_string.append ("- No conversion%N")
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_roman) = {WEL_IME_CONSTANTS}.Ime_cmode_roman ) then
				tmp_string.append ("- Roman%N")
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_softkbd) = {WEL_IME_CONSTANTS}.Ime_cmode_softkbd ) then
				tmp_string.append ("- Soft Keyboard%N")
				main_menu.check_item (Idsoftkeyboard_constant)
			else
				main_menu.uncheck_item (Idsoftkeyboard_constant)
			end
			if (conv_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_cmode_symbol) = {WEL_IME_CONSTANTS}.Ime_cmode_symbol ) then
				tmp_string.append ("- Symbol conversion%N")
			end
			if (sent_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_smode_automatic) = {WEL_IME_CONSTANTS}.Ime_smode_automatic ) then
				tmp_string.append ("- Automatic conversion%N")
			end
			if (sent_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_smode_none) = {WEL_IME_CONSTANTS}.Ime_smode_none ) then
				tmp_string.append ("- Using phrase information%N")
			end
			if (sent_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_smode_pluralclause) = {WEL_IME_CONSTANTS}.Ime_smode_pluralclause ) then
				tmp_string.append ("- Using plural clause information%N")
			end
			if (sent_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_smode_singleconvert) = {WEL_IME_CONSTANTS}.Ime_smode_singleconvert ) then
				tmp_string.append ("- Single-character conversion%N")
			end
			if (sent_mode.bit_and ({WEL_IME_CONSTANTS}.Ime_smode_conversation) = {WEL_IME_CONSTANTS}.Ime_smode_conversation ) then
				tmp_string.append ("- Conversation mode%N")
			end
			l_imm.release_input_context (l_lang_edit.item)
			create 	Result.make_from_string (tmp_string)
		end

	refresh
			-- Refresh display
		do
			if attached imm as l_imm then
				l_imm.switch_input_locale (input_locale)
			end
			setup_ime_display
			init_menu
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_WINDOW

