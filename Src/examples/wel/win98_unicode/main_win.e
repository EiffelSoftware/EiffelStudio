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

creation
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			resize (800, 680)
			set_menu (main_menu)
				-- Labels
			create input_locale_text.make(Current, "Input locale",
				35, 45, 200, 20, -1)
			create change_font_text.make(Current, "Font Type",
				270, 45, 200, 20, -1)
			create ime_name_text.make (Current, "Name",
				50, 130, 200, 20, -1)
			create ime_description_text.make (Current, "Description",
				50, 170, 200, 20, -1)
			create ime_property_text.make (Current, "Property",
				50, 210, 200, 20, -1)	
			create ime_conversion_text.make (Current, "Conversion Mode",
				250, 130, 200, 20, -1)
			create ime_title_text_info.make (Current, "",
				55, 145, 200, 20, -1)
			create ime_name_text_info.make (Current, "",
				55, 145, 200, 20, -1)
			create ime_description_text_info.make (Current, "",
				55, 185, 200, 20, -1)
			create ime_property_text_info.make (Current, "",
				55, 225, 200, 75, -1)
			create ime_conversion_text_info.make(Current, "",
				255, 145, 160, 80, -1)
				
			-- IME Controls
			create ime_group_box.make (Current, "Input Method Editor (IME)",
				15, 15, 700, 320, -1)	
			create ime_display_group_box.make (Current, "Input Method Editor",
				35, 105, 385, 200, -1)
			create avail_input_locales_combo.make(Current,
				35, 65, 200, 250, -1)
			create font_list.make (Current,
				270, 65, 150, 170, -1)
			create lang_edit.make (Current, "",
				450, 65, 220, 200, -1)
			create configure_ime_button.make (Current, "Configure IME..",
				250, 230, 100, 30, -1)
			create control_button.make (Current, "Apply to all controls",
				450, 275, 150, 30, -1)
	
				-- Controls
			create group_box.make (Current, "Controls",
				15, 365, 700, 220, -1)
			create button.make (Current, "Button",
				35, 400, 75, 30, -1)
			create check_box.make (Current, "Check box", 
				35, 450, 100, 15, -1)
			create radio_button.make (Current, "Radio Button", 
				35, 490, 120, 15, -1)
			create drop_down_combo_box.make(Current,
				35, 530, 150, 50, -1)
			create single_selection_list_box.make (Current,
				225, 400, 180, 80, -1)
			create multi_selection_list_box.make (Current,
				225, 500, 180, 80, -1)
			create tree_view.make (Current, 435, 400, 150, 155, -1)

			create imm.make
			init_display
			
		end

feature -- Access

	
		
	--IMM
	imm: WEL_INPUT_METHOD_MANAGER
	input_locale: POINTER 
	
	--Font
	log_font: WEL_LOG_FONT
	wel_font: WEL_FONT

	--IME Controls
	lang_edit: WEL_RICH_EDIT
	font_list: WEL_DROP_DOWN_LIST_COMBO_BOX
	avail_input_locales_combo: WEL_DROP_DOWN_LIST_COMBO_BOX
	configure_ime_button: WEL_PUSH_BUTTON
	ime_group_box: WEL_GROUP_BOX
	ime_display_group_box: WEL_GROUP_BOX
	
	--Wel controls
	button: WEL_PUSH_BUTTON
	control_button: WEL_PUSH_BUTTON
	check_box: WEL_CHECK_BOX
	group_box: WEL_GROUP_BOX
	radio_button: WEL_RADIO_BUTTON
	drop_down_combo_box: WEL_DROP_DOWN_LIST_COMBO_BOX
	single_selection_list_box: WEL_SINGLE_SELECTION_LIST_BOX
	multi_selection_list_box: WEL_MULTIPLE_SELECTION_LIST_BOX
	tree_view: WEL_TREE_VIEW

	--Labels
	input_locale_text, 
	change_font_text, 
	ime_title_text_info, 
	ime_name_text, ime_name_text_info,
	ime_description_text, ime_description_text_info,
	ime_property_text, ime_property_text_info,
	ime_conversion_text, ime_conversion_text_info,
	change_char_format_text: DISPLAY_TEXT
	
	main_menu: WEL_MENU is
				-- Windows main menu created from resource
			once
				create Result.make_by_id (Idmainmenu_constant)
			end
		
feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
			-- Perform menu command actions
		local
			conv_mode, wel_const: INTEGER
		do
			imm.get_input_context (lang_edit.item)	
			imm.input_method_editor.get_conversion_status
			conv_mode := imm.input_method_editor.conversion_mode					
			inspect menu_id
			when Idsoftkeyboard_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_softkbd
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				else
					imm.input_method_editor.set_conversion_status (conv_mode.bit_or (wel_const))
				end
			when Idshapefull_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_fullshape
				if not (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_or (wel_const))
				end
			when Idshapehalf_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_fullshape
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			when Idnative_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_native
				if not (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_or (wel_const))
				end
			when Idalphanumeric_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_native
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			when Id_imeoptions_conversionmode_eudc_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_eudc
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			when Id_imeoptions_conversionmode_symbol_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_symbol
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			when Id_imeoptions_conversionmode_hanja_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_hanjaconvert
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end
			when Id_imeoptions_conversionmode_noconversion_constant then
				wel_const := feature {WEL_IME_CONSTANTS}.Ime_cmode_noconversion
				if (conv_mode.bit_and (wel_const) = wel_const) then
					imm.input_method_editor.set_conversion_status (conv_mode.bit_and (wel_const.bit_not))
				end	
			end
			imm.release_input_context (lang_edit.item)
			refresh
		end
		
	notify (control: WEL_CONTROL; notify_code: INTEGER) is
		local
			input_locales: ARRAY[POINTER]
			tmp_str: STRING
		do
			if control = font_list then
				create log_font.make (14, font_list.selected_string)
				change_font (log_font)
			elseif control = avail_input_locales_combo then		
				--retrieve an array of available input locales for the system
					input_locales := imm.input_locales
					inspect
						avail_input_locales_combo.selected_item
					when 0 then
						input_locale := input_locales.item (1)
					when 1 then
						input_locale := input_locales.item (2)
					when 2 then
						input_locale := input_locales.item (3)
					when 3 then
						input_locale := input_locales.item (4)
					when 4 then
						input_locale := input_locales.item (5)
					when 5 then
						input_locale := input_locales.item (6)
					when 6 then
						input_locale := input_locales.item (7)
					when 7 then
						input_locale := input_locales.item (8)
					when 8 then
						input_locale := input_locales.item (9)
					end		
					refresh
			elseif
				control = control_button then
					if lang_edit.text.is_equal ("") then
						create tmp_str.make_from_string ("")
					else
						lang_edit.select_all
						tmp_str := lang_edit.selected_text
					end
					change_controls (tmp_str)
			end
		end	
		
	class_background: WEL_BRUSH is
			-- Standard window background color used to create the
			-- window class.
			-- Can be redefined to return a user-defined brush.
		require
			background_brush_not_set: background_brush = Void
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is 
		-- Window's title
		do
			create Result.make_from_string ("Unicode Example")
		end
	
	init_display is
			-- 
		do
			init_fonts_list
			create log_font.make (14, font_list.selected_string)
			change_font (log_font)
			init_controls	
		end
		
	init_menu is
			-- Initialise the main menu
		do
			if imm.has_ime (imm.input_locale) then	
				main_menu.enable_item (Id_imeoptions_conversionmode_eudc_constant)
				main_menu.enable_item (Idalphanumeric_constant)
				main_menu.enable_item (Id_imeoptions_conversionmode_hanja_constant)
				main_menu.enable_item (Idsoftkeyboard_constant)
				main_menu.enable_item (Idshapehalf_constant)
				main_menu.enable_item (Id_imeoptions_conversionmode_symbol_constant)
				main_menu.enable_item (Id_imeoptions_conversionmode_noconversion_constant)
				main_menu.enable_item (Idnative_constant)
				main_menu.enable_item (Idshapefull_constant)
			else
				main_menu.disable_item (Id_imeoptions_conversionmode_eudc_constant)
				main_menu.disable_item (Idalphanumeric_constant)
				main_menu.disable_item (Id_imeoptions_conversionmode_hanja_constant)
				main_menu.disable_item (Idsoftkeyboard_constant)
				main_menu.disable_item (Idshapehalf_constant)
				main_menu.disable_item (Id_imeoptions_conversionmode_symbol_constant)
				main_menu.disable_item (Id_imeoptions_conversionmode_noconversion_constant)
				main_menu.disable_item (Idnative_constant)
				main_menu.disable_item (Idshapefull_constant)
			end
			
		end
	
	init_controls is
		do
			init_menu
			init_locale_list
			init_tree_view
			lang_edit.set_text ("Rich Edit control")
			lang_edit.hide_vertical_scroll_bar
			lang_edit.hide_horizontal_scroll_bar
			drop_down_combo_box.insert_string_at ("Drop down combo", 0)
			drop_down_combo_box.select_item (0)
			single_selection_list_box.insert_string_at ("Single Selection List Box", 0)
			multi_selection_list_box.insert_string_at ("Multiple Selection List Box", 0)
			multi_selection_list_box.insert_string_at ("Multiple Selection List Box", 1)
		end

	init_locale_list is
			-- Add the available input locales to the list
		do
			avail_input_locales_combo.add_string ("English (United States)")
			avail_input_locales_combo.add_string ("English (United Kingdom)")
			avail_input_locales_combo.add_string ("Chinese (Hong Kong)")
			avail_input_locales_combo.add_string ("Hebrew")
			avail_input_locales_combo.add_string ("Arabic (Iraq)")
			avail_input_locales_combo.add_string ("Chinese (Macau)")
			avail_input_locales_combo.add_string ("Chinese (Singapore)")
			avail_input_locales_combo.add_string ("Korean (Hangul) (MS-IME 98)")
			avail_input_locales_combo.add_string ("Chinese (Traditional) - New Phonetic")
			avail_input_locales_combo.select_item (0)
		end

	init_fonts_list is
			-- Add some font types to the list box
		do
			font_list.add_string("MS Shell Dlg")
			font_list.add_string("MingLiU")
			font_list.add_string("Arial")
			font_list.add_string("Georgia")
			font_list.add_string("Narkisim")
			font_list.add_string("Lucida Console")
			font_list.add_string("Courier New")
			font_list.add_string("MS UI Gothic")
			font_list.add_string("Gulim")
			font_list.add_string("Bauhaus 93")
			font_list.select_item (0)
		end
	
	init_tree_view is
			-- Initialise tree view control
		local
			str: STRING
			handle, root_h: POINTER
			tree_view_insert_struct1, tree_view_insert_struct2, tree_view_insert_struct3: WEL_TREE_VIEW_INSERT_STRUCT
			tree_view_item1, tree_view_item2, tree_view_item3: WEL_TREE_VIEW_ITEM
		do
			tree_view.set_unicode_format
			create tree_view_insert_struct1.make
			tree_view_insert_struct1.set_root
			create tree_view_item1.make
			tree_view_item1.set_text ("Root 1")
			tree_view_insert_struct1.set_tree_view_item (tree_view_item1)
			tree_view.insert_item (tree_view_insert_struct1)
			root_h := tree_view.last_item

			str := tree_view_item1.text

			tree_view_item1.set_text ("New text")
			tree_view_insert_struct1.set_tree_view_item (tree_view_item1)
			tree_view.insert_item (tree_view_insert_struct1)

			str := tree_view_item1.text

			create tree_view_insert_struct2.make
			tree_view_insert_struct2.set_last
			tree_view_insert_struct2.set_parent (root_h)
			create tree_view_item2.make
			tree_view_item2.set_text ("Subtree 1")
			tree_view_insert_struct2.set_tree_view_item (tree_view_item2)
			tree_view.insert_item (tree_view_insert_struct2)
			handle := tree_view.last_item

			str := tree_view_item2.text
			
			create tree_view_insert_struct3.make
			tree_view_insert_struct3.set_last
			tree_view_insert_struct3.set_parent (handle)
			create tree_view_item3.make
			tree_view_item3.set_text ("Item 1")
			tree_view_insert_struct3.set_tree_view_item (tree_view_item3)
			tree_view.insert_item (tree_view_insert_struct3)

			str := tree_view_item3.text

			create tree_view_insert_struct3.make
			tree_view_insert_struct3.set_last
			tree_view_insert_struct3.set_parent (handle)
			create tree_view_item3.make
			tree_view_item3.set_text ("Item 2")
			tree_view_insert_struct3.set_tree_view_item (tree_view_item3)
			tree_view.insert_item (tree_view_insert_struct3)

		end
		
	
	change_controls (str: STRING) is
			-- Change the controls text to that of rich edit
		do
			button.set_text (str)
			check_box.set_text (str)
			radio_button.set_text (str)
			drop_down_combo_box.select_item (0)
			drop_down_combo_box.delete_string (0)
			drop_down_combo_box.insert_string_at (str, 0)
			drop_down_combo_box.select_item (0)
			single_selection_list_box.delete_string (0)
			single_selection_list_box.insert_string_at (str, 0)
			multi_selection_list_box.delete_string (0)
			multi_selection_list_box.insert_string_at (str, 0)
			multi_selection_list_box.delete_string (1)
			multi_selection_list_box.insert_string_at (str, 1)
		--	tree_view.set_text (str)
			tree_view.selected_item.set_text (str)
		end
		
		
	change_font (new_font: WEL_LOG_FONT) is
			-- Change the font used by the application controls to 'new_font'
		local
			char_format: WEL_CHARACTER_FORMAT
		do
			create char_format.make
			char_format.set_face_name (font_list.selected_string)
			create wel_font.make_indirect (new_font)
			wel_font.set_indirect (new_font)
			if lang_edit.text_length = 0 then
			else
				lang_edit.select_all
				lang_edit.set_character_format_selection (char_format)
			end
			setup_ime_display
		end	
	
	setup_ime_display is
			-- Initialise the display for the IME display information
		local
			has_ime: BOOLEAN
		do			
			has_ime := imm.has_ime (imm.input_locale)
			wel_font.set_indirect (log_font)
				if not (has_ime) then
					--hide IME info since no IME loaded
					ime_name_text.hide
					ime_description_text.hide
					ime_property_text.hide
					ime_conversion_text.hide
					ime_name_text_info.hide
					ime_description_text_info.hide
					ime_property_text_info.hide
					ime_conversion_text_info.hide
					configure_ime_button.hide
					ime_title_text_info.show					
					ime_title_text_info.set_font (wel_font)
					ime_title_text_info.set_text ("- " + "No IME loaded")
				else
					ime_title_text_info.hide
					ime_name_text.show
					ime_name_text_info.show
					ime_description_text.show
					ime_description_text_info.show
					ime_property_text.show
					ime_property_text_info.show
					ime_conversion_text.show
					ime_conversion_text_info.show
					configure_ime_button.show
					ime_title_text_info.set_font (wel_font)
					ime_name_text.set_font (wel_font)
					ime_name_text_info.set_font (wel_font)
					ime_description_text.set_font (wel_font)
					ime_description_text_info.set_font (wel_font)
					ime_property_text.set_font (wel_font)
					ime_property_text_info.set_font (wel_font)
					ime_conversion_text.set_font (wel_font)
					ime_conversion_text_info.set_font (wel_font)
					configure_ime_button.set_font (wel_font)
					
					ime_title_text_info.clear
					ime_name_text_info.set_text ("- " + imm.ime_filename)
					ime_description_text_info.set_text ("- " + imm.ime_description)
					ime_property_text_info.set_text (ime_properties)
					ime_conversion_text_info.set_text (ime_conversion_status)
				end	
				button.set_font (wel_font)
				check_box.set_font (wel_font)
				radio_button.set_font (wel_font)
				drop_down_combo_box.set_font (wel_font)
				single_selection_list_box.set_font (wel_font)
				multi_selection_list_box.set_font (wel_font)
		end
		
	ime_properties: STRING is
			-- Parse the properties of the current IME into string format
		local
			tmp_prop: INTEGER
			tmp_string: STRING
		do
			create tmp_string.make (0)
			tmp_prop := imm.ime_property (feature {WEL_IME_CONSTANTS}.Igp_property)
			if (tmp_prop.bit_and (feature {WEL_IME_CONSTANTS}.Ime_prop_unicode) = feature {WEL_IME_CONSTANTS}.Ime_prop_unicode) then
				tmp_string.append ("- Unicode IME%N")
			else
				tmp_string.append ("- ANSI IME%N")
			end
			tmp_prop := imm.ime_property (feature {WEL_IME_CONSTANTS}.Igp_getimeversion)
			if (tmp_prop.bit_and (feature {WEL_IME_CONSTANTS}.Imever_0310) = feature {WEL_IME_CONSTANTS}.Imever_0310) then
				tmp_string.append ("- Windows 3.1 IME%N")
			else
				tmp_string.append ("- Windows 9x/Me IME%N")
			end	
			tmp_prop := imm.ime_property (feature {WEL_IME_CONSTANTS}.Igp_setcompstr)
			if (tmp_prop.bit_and (feature {WEL_IME_CONSTANTS}.Scs_cap_compstr) = feature {WEL_IME_CONSTANTS}.Scs_cap_compstr) then
				tmp_string.append ("- Can set composition string%N")
			else
				tmp_string.append ("- Cannot set composition string%N")
			end	
			tmp_prop := imm.ime_property (feature {WEL_IME_CONSTANTS}.Scs_cap_makeread)
			if (tmp_prop.bit_and (feature {WEL_IME_CONSTANTS}.Scs_cap_makeread) = feature {WEL_IME_CONSTANTS}.Scs_cap_makeread) then
				tmp_string.append ("- Can create reading string%N")
			else
				tmp_string.append ("- Cannot create reading string%N")
			end	
			tmp_prop := imm.ime_property (feature {WEL_IME_CONSTANTS}.Scs_cap_setreconvertstring)
			if (tmp_prop.bit_and (feature {WEL_IME_CONSTANTS}.Scs_cap_setreconvertstring) = feature {WEL_IME_CONSTANTS}.Scs_cap_setreconvertstring) then
				tmp_string.append ("- Supports reconversion%N")
			else
				tmp_string.append ("- Does not support reconversion%N")
			end	
			create Result.make_from_string (tmp_string) 
		end		
		
	ime_conversion_status: STRING is
			-- Parse the properties of the current IME conversion mode into string format
		local
			tmp_string: STRING
			conv_mode, sent_mode: INTEGER
		do
			create tmp_string.make (0)
			imm.get_input_context (lang_edit.item)			
			imm.input_method_editor.get_conversion_status
			conv_mode := imm.input_method_editor.conversion_mode
			sent_mode := imm.input_method_editor.sentence_mode

			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_eudc) = feature {WEL_IME_CONSTANTS}.Ime_cmode_eudc ) then
				tmp_string.append ("- EUDC Conversion%N")
				main_menu.check_item (Id_imeoptions_conversionmode_eudc_constant)
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_fixed) = feature {WEL_IME_CONSTANTS}.Ime_cmode_fixed ) then
				tmp_string.append ("- Fixed Conversion%N")
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_fullshape) = feature {WEL_IME_CONSTANTS}.Ime_cmode_fullshape ) then
				tmp_string.append ("- Full shape mode%N")
				main_menu.check_item (Idshapefull_constant)
				main_menu.uncheck_item (Idshapehalf_constant)
			else
				tmp_string.append ("- Half shape mode%N")
				main_menu.check_item (Idshapehalf_constant)
				main_menu.uncheck_item (Idshapefull_constant)
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_hanjaconvert) = feature {WEL_IME_CONSTANTS}.Ime_cmode_hanjaconvert ) then
				tmp_string.append ("- Hanja convert%N")
				main_menu.check_item (Id_imeoptions_conversionmode_hanja_constant)
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_katakana) = feature {WEL_IME_CONSTANTS}.Ime_cmode_katakana ) then
				tmp_string.append ("- Katakana%N")
			else
				tmp_string.append ("- Hiragana%N")
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_native) = feature {WEL_IME_CONSTANTS}.Ime_cmode_native ) then
				tmp_string.append ("- Native mode%N")
				main_menu.check_item (Idnative_constant)
				main_menu.uncheck_item (Idalphanumeric_constant)
			else
				tmp_string.append ("- Alphanumeric Mode%N")
				main_menu.check_item (Idalphanumeric_constant)
				main_menu.uncheck_item (Idnative_constant)
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_noconversion) = feature {WEL_IME_CONSTANTS}.Ime_cmode_noconversion ) then
				tmp_string.append ("- No conversion%N")
				main_menu.check_item (Id_imeoptions_conversionmode_noconversion_constant)
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_roman) = feature {WEL_IME_CONSTANTS}.Ime_cmode_roman ) then
				tmp_string.append ("- Roman%N")
			end
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_softkbd) = feature {WEL_IME_CONSTANTS}.Ime_cmode_softkbd ) then
				tmp_string.append ("- Soft Keyboard%N")
				main_menu.check_item (Idsoftkeyboard_constant)
			else
				main_menu.uncheck_item (Idsoftkeyboard_constant)	
			end	
			if (conv_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_cmode_symbol) = feature {WEL_IME_CONSTANTS}.Ime_cmode_symbol ) then
				tmp_string.append ("- Symbol conversion%N")
				main_menu.check_item (Id_imeoptions_conversionmode_symbol_constant)
			end
			if (sent_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_smode_automatic) = feature {WEL_IME_CONSTANTS}.Ime_smode_automatic ) then
				tmp_string.append ("- Automatic conversion%N")
			end
			if (sent_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_smode_none) = feature {WEL_IME_CONSTANTS}.Ime_smode_none ) then
				tmp_string.append ("- Using phrase information%N")
			end
			if (sent_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_smode_pluralclause) = feature {WEL_IME_CONSTANTS}.Ime_smode_pluralclause ) then
				tmp_string.append ("- Using plural clause information%N")
			end
			if (sent_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_smode_singleconvert) = feature {WEL_IME_CONSTANTS}.Ime_smode_singleconvert ) then
				tmp_string.append ("- Single-character conversion%N")
			end
			if (sent_mode.bit_and (feature {WEL_IME_CONSTANTS}.Ime_smode_conversation) = feature {WEL_IME_CONSTANTS}.Ime_smode_conversation ) then
				tmp_string.append ("- Conversation mode%N")
			end
			imm.release_input_context (lang_edit.item)
			create 	Result.make_from_string (tmp_string)
	end
		
	refresh is
			-- Refresh display
		do
			imm.switch_input_locale (input_locale)
			setup_ime_display
			init_menu
		end

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

