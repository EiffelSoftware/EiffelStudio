indexing
	description: ""

class
	MENU

--inherit 
--	WINFORMS_FORM
--		redefine
--			make,
--			on_paint,
--			dispose_boolean
--		end

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
			mi_file, mi_format: WINFORMS_MENU_ITEM
			l_array_menu_item: NATIVE_ARRAY [WINFORMS_MENU_ITEM]
		do
			create my_window.make
			
			initialize_component

			--  Initialize Fonts - use generic fonts to avoid problems across
			--  different versions of the OS
			create monoSpaceFontFamily.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.monospace)
			create sansSerifFontFamily.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.sans_serif)
			create serifFontFamily.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.serif)
			currentFontFamily := sansSerifFontFamily

			-- Add File Menu
			mi_file := main_menu.get_menu_items.add (("&File").to_cil)
			dummy := mi_file.get_menu_items.add_menu_item (create {WINFORMS_MENU_ITEM}.make_from_text_and_on_click_and_shortcut (("&Open...").to_cil, create {EVENT_HANDLER}.make (Current, $FileOpen_Clicked), feature {WINFORMS_SHORTCUT}.ctrl_O))
			dummy := mi_file.get_menu_items.add (("-").to_cil)     --  Gives us a seperator
			dummy := mi_file.get_menu_items.add_menu_item (create {WINFORMS_MENU_ITEM}.make_from_text_and_on_click_and_shortcut (("E&xit").to_cil, create {EVENT_HANDLER}.make (Current, $FileExit_Clicked), feature {WINFORMS_SHORTCUT}.ctrl_X))

			-- Add Format Menu
			mi_format := main_menu.get_menu_items.add (("F&ormat").to_cil)

			-- Font Face sub-menu
			create mmiSansSerif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&1. ").to_cil, sansSerifFontFamily.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			mmiSansSerif.set_checked (True) 
			mmiSansSerif.set_default_item (True) 
			create mmiSerif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&2. ").to_cil, serifFontFamily.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			create mmiMonoSpace.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&3. ").to_cil, monoSpaceFontFamily.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmiSansSerif)
			l_array_menu_item.put (1, mmiSerif)
			l_array_menu_item.put (2, mmiMonoSpace)
			dummy := mi_format.get_menu_items.add_string_menu_item_array (("Font &Face").to_cil, l_array_menu_item)

			-- Font Size sub-menu
			create mmiSmall.make_from_text_and_on_click (("&Small").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))
			create mmiMedium.make_from_text_and_on_click (("&Medium").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))
			mmiMedium.set_checked (True) 
			mmiMedium.set_default_item (True) 
			create mmiLarge.make_from_text_and_on_click (("&Large").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmiSmall)
			l_array_menu_item.put (1, mmiMedium)
			l_array_menu_item.put (2, mmiLarge)
			dummy := mi_format.get_menu_items.add_string_menu_item_array (("Font &Size").to_cil, l_array_menu_item)

			-- Add Format to label context menu
			-- Note have to add a clone because menus can't belong to 2 parents
			dummy := label_1_context_menu.get_menu_items.add_menu_item (mi_format.clone_menu)

			--  Set up the context menu items - we use these to check and uncheck items
			cmiSansSerif := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (0).get_menu_items.get_item (0)
			cmiSerif := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (0).get_menu_items.get_item (1)
			cmiMonoSpace := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (0).get_menu_items.get_item (2)
			cmiSmall := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (1).get_menu_items.get_item (0)
			cmiMedium := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (1).get_menu_items.get_item (1)
			cmiLarge := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (1).get_menu_items.get_item (2)

			-- We use these to track which menu items are checked
			-- This is made more complex because we have both a menu and a context menu
			miMainFormatFontChecked := mmiSansSerif
			miMainFormatSizeChecked := mmiMedium
			miContextFormatFontChecked := cmiSansSerif
			miContextFormatSizeChecked := cmiMedium

			dummy := my_window.show_dialog
		end


feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container 

	label_1: WINFORMS_LABEL
			-- System.Windows.Forms.Label 

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu 

	label_1_context_menu: WINFORMS_CONTEXT_MENU
			-- System.Windows.Forms.ContextMenu 

	fontSize: DOUBLE
			-- Font face and size

	mmiSansSerif, mmiSerif, mmiMonoSpace, mmiSmall, mmiMedium,
	mmiLarge, cmiSansSerif, cmiSerif, cmiMonoSpace, cmiSmall,
	cmiMedium, cmiLarge, miMainFormatFontChecked, miMainFormatSizeChecked,
	miContextFormatFontChecked, miContextFormatSizeChecked : WINFORMS_MENU_ITEM

	currentFontFamily, monoSpaceFontFamily, sansSerifFontFamily, serifFontFamily: DRAWING_FONT_FAMILY


feature {NONE} -- Implementation

	initialize_component is
			--
		local
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
		do
			create components.make
			create main_menu.make
			create label_1.make
			create label_1_context_menu.make

			my_window.set_text (("Menus 'R Us").to_cil)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (392, 117)
			my_window.set_client_size_size (l_size)
			create main_menu.make
			my_window.set_menu (main_menu)

			label_1.set_back_color (feature {DRAWING_COLOR}.get_light_steel_blue)
			l_point.make_from_x_and_y (16, 24)
			label_1.set_location (l_point)
			label_1.set_tab_index (0)
			--label_1.set_anchor = (System.Windows.Forms.AnchorStyles) 13
			l_size.make_from_width_and_height (360, 50)
			label_1.set_size (l_size)
			label_1.set_text (("Right Click on me - I have a context menu!").to_cil)
			label_1.set_context_menu (label_1_context_menu)
			
			my_window.get_controls.add (label_1)
		end


feature {NONE} -- Implementation

	font_sizes (a_size: STRING): DOUBLE is
			--  Comment out this structure to view menus.cs in the WinForms Designer.
			--  Remember not to edit the menus in the designer. It will conflict
			--  with the hand-written menu code. Remember to uncomment this
			--  structure when you are finished.
		do
			if a_size.is_equal ("Small") then
				Result := 8
			elseif a_size.is_equal ("Medium") then
				Result := 12
			elseif a_size.is_equal ("Large") then
				Result := 24
			end
		end

	FileExit_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Exit Menu item handler
		do
			my_window.close
		end

	FileOpen_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Open Menu item handler
		local
			dummy: WINFORMS_DIALOG_RESULT
		do
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (("And why would this open a file?").to_cil)
		end


	FormatFont_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Font Menu item handler
		local
			mi_clicked: WINFORMS_MENU_ITEM
		do
			mi_clicked ?= sender

			miMainFormatFontChecked.set_checked (False)
			miContextFormatFontChecked.set_checked (False)

			if mi_clicked.equals (mmiSansSerif) or mi_clicked.equals (cmiSansSerif) then
				miMainFormatFontChecked := mmiSansSerif
				miContextFormatFontChecked := cmiSansSerif
				currentFontFamily := sansSerifFontFamily
			elseif mi_clicked.equals (mmiSerif) or mi_clicked.equals (cmiSerif) then
				miMainFormatFontChecked := mmiSerif
				miContextFormatFontChecked := cmiSerif
				currentFontFamily := serifFontFamily
			else
				miMainFormatFontChecked := mmiMonoSpace
				miContextFormatFontChecked := cmiMonoSpace
				currentFontFamily := monoSpaceFontFamily
			end

			miMainFormatFontChecked.set_checked (True)
			miContextFormatFontChecked.set_checked (True)

			label_1.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (currentFontFamily, fontSize))
		end


	FormatSize_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Size Menu item handler
		local
			mi_clicked: WINFORMS_MENU_ITEM
			font_size_string: SYSTEM_STRING
		do
			mi_clicked ?= sender

			miMainFormatSizeChecked.set_checked (False)
			miContextFormatSizeChecked.set_checked (False)

			font_size_string := mi_clicked.get_text

			if font_size_string.equals (("&Small").to_cil) then
				miMainFormatSizeChecked := mmiSmall
				miContextFormatSizeChecked := cmiSmall
				fontSize := font_sizes ("Small")
			elseif font_size_string.equals (("&Large").to_cil) then
				miMainFormatSizeChecked := mmiLarge
				miContextFormatSizeChecked := cmiLarge
				fontSize := font_sizes ("Large")
			else
				miMainFormatSizeChecked := mmiMedium
				miContextFormatSizeChecked := cmiMedium
				fontSize := font_sizes ("Medium")
			end

			miMainFormatSizeChecked.set_checked (True)
			miContextFormatSizeChecked.set_checked (True)

			label_1.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (currentFontFamily, fontSize))
		end



end -- Class MENU


