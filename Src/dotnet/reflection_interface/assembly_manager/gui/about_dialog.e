indexing
	description: "About ISE Assembly Manager dialog"
	external_name: "ISE.AssemblyManager.AboutDialog"

class
	ABOUT_DIALOG

inherit
	ASSMEBLY_MANAGER_SUPPORT [STRING]

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize GUI."
			external_name: "Make"
		local
			returned_value: WINFORMS_DIALOG_RESULT
		do
			create main_win.make_winforms_form
			initialize_gui
			returned_value := main_win.show_dialog
		end

feature -- Access

	dictionary: ABOUT_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		ensure
			dictionary_created: Result /= Void
		end
		
feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGui"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			an_image: DRAWING_IMAGE
			a_panel: WINFORMS_PANEL
			border_style: WINFORMS_FORM_BORDER_STYLE
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX
		do
			main_win.set_enabled (True)
			main_win.set_text (dictionary.Title.to_cil)
			a_size.set_width (dictionary.Window_width)
			a_size.set_height (dictionary.Window_height)
			main_win.set_size (a_size)
			main_win.set_form_border_style (border_style.fixed_single)
			if not retried then
				main_win.set_icon (dictionary.Assembly_manager_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
			main_win.set_back_color (dictionary.White_color)
			main_win.set_maximize_box (False)
			
				-- Image
			an_image := image_factory.from_file (dictionary.Image_filename.to_cil)
			create a_panel.make_winforms_panel
			a_panel.set_height (an_image.get_height)
			a_panel.set_width (an_image.get_width)
			a_panel.set_background_image (an_image)			
			main_win.get_controls.add (a_panel)	
			
				-- Text
			create main_panel.make_winforms_panel
			main_panel.set_back_color (dictionary.White_color)
			a_size.set_width (dictionary.Window_width - a_panel.get_width)
			a_size.set_height (dictionary.Window_width)
			main_panel.set_size (a_size)
			a_point.set_x (a_panel.get_width)
			a_point.set_y (0)
			main_panel.set_location (a_point)
			main_win.get_controls.add (main_panel)
			
			display_text
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	image_factory: DRAWING_IMAGE 
		indexing
			description: "Static needed to create images"
			external_name: "ImageFactory"
		end
	
	main_panel: WINFORMS_PANEL
		indexing
			description: "Panel where text is displayed"
			external_name: "MainPanel"
		end

	main_win: WINFORMS_FORM
	
	display_text is
		indexing
			description: "Display text."
			external_name: "DisplayText"
		do
			create_panel_label (dictionary.Product_name, 2 * dictionary.Margin, True)
			create_panel_label (dictionary.Powered_by_eiffel_dotnet, 3 * dictionary.Margin + dictionary.Label_height, True)
			create_panel_label (dictionary.Company_name, 4 * dictionary.Margin + 2 * dictionary.Label_height, False)
			create_panel_label (dictionary.Street, 4 * dictionary.Margin + 3 * dictionary.Label_height, False)
			create_panel_label (dictionary.Town, 4 * dictionary.Margin + 4 * dictionary.Label_height, False)
			create_panel_label (dictionary.Telephone, 4 * dictionary.Margin + 5 * dictionary.Label_height, False)		
			create_panel_label (dictionary.Fax, 4 * dictionary.Margin + 6 * dictionary.Label_height, False)	
			create_panel_label (dictionary.Web_address, 4 * dictionary.Margin + 7 * dictionary.Label_height, False)		
			create_panel_label (dictionary.Dotnet_web_address, 4 * dictionary.Margin + 8 * dictionary.Label_height, True)		
		end
	
	create_panel_label (a_text: STRING; y_position: INTEGER; is_bold_style: BOOLEAN) is
		indexing
			description: "Create a label with text `a_text' at position `y_position' and add it to `main_panel' get_controls."
			external_name: "CreatePanelLabel"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
			valid_y_position: y_position >= 0 and y_position <= dictionary.Window_height
		local
			a_label: WINFORMS_LABEL
			a_point: DRAWING_POINT
			a_font: DRAWING_FONT
			alignment: DRAWING_CONTENT_ALIGNMENT
			style: DRAWING_FONT_STYLE
		do
			create a_label.make_winforms_label
			a_label.set_back_color (dictionary.White_color)
			a_label.set_text (a_text.to_cil)
			a_point.set_x (dictionary.Margin)
			a_point.set_y (y_position)
			a_label.set_location (a_point)
			a_label.set_auto_size (True)
			a_label.set_text_align (alignment.Middle_center)
			if is_bold_style then
				create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold)
			else
				create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Regular)
			end
			a_label.set_font (a_font)
			main_panel.get_controls.add (a_label)
		end
		
end -- class ABOUT_DIALOG
