indexing
	description: "About ISE Assembly Manager dialog"
	external_name: "ISE.AssemblyManager.AboutDialog"

class
	ABOUT_DIALOG

inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize GUI."
			external_name: "Make"
		local
			returned_value: INTEGER
		do
			make_form
			initialize_gui
			returned_value := showdialog
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
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			an_image: SYSTEM_DRAWING_IMAGE
			a_panel: SYSTEM_WINDOWS_FORMS_PANEL
		do
			set_enabled (True)
			set_text (dictionary.Title)
			a_size.set_width (dictionary.Window_width)
			a_size.set_height (dictionary.Window_height)
			set_size (a_size)
			set_borderstyle (dictionary.Border_style)
			set_icon (dictionary.Assembly_manager_icon)
			set_backcolor (dictionary.White_color)
			set_maximizebox (False)
			
				-- Image
			an_image := image_factory.fromfile (dictionary.Image_filename)
			create a_panel.make_panel
			a_panel.set_height (an_image.height)
			a_panel.set_width (an_image.width)
			a_panel.set_backgroundimage (an_image)			
			controls.add (a_panel)	
			
				-- Text
			create main_panel.make_panel
			main_panel.set_backcolor (dictionary.White_color)
			a_size.set_width (dictionary.Window_width - a_panel.width)
			a_size.set_height (dictionary.Window_width)
			main_panel.set_size (a_size)
			a_point.set_x (a_panel.width)
			a_point.set_y (0)
			main_panel.set_location (a_point)
			controls.add (main_panel)
			
			display_text
		end

feature {NONE} -- Implementation

	image_factory: SYSTEM_DRAWING_IMAGE 
		indexing
			description: "Static needed to create images"
			external_name: "ImageFactory"
		end
	
	main_panel: SYSTEM_WINDOWS_FORMS_PANEL
		indexing
			description: "Panel where text is displayed"
			external_name: "MainPanel"
		end
		
	display_text is
		indexing
			description: "Display text."
			external_name: "DisplayText"
		do
			create_panel_label (dictionary.Product_name, 2 * dictionary.Margin, True)
			create_panel_label (dictionary.Powered_by_eiffel_sharp, 3 * dictionary.Margin + dictionary.Label_height, True)
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
			description: "Create a label with text `a_text' at position `y_position' and add it to `main_panel' controls."
			external_name: "CreatePanelLabel"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
			valid_y_position: y_position >= 0 and y_position <= dictionary.Window_height
		local
			a_label: SYSTEM_WINDOWS_FORMS_LABEL
			a_point: SYSTEM_DRAWING_POINT
			a_font: SYSTEM_DRAWING_FONT
		do
			create a_label.make_label
			a_label.set_backcolor (dictionary.White_color)
			a_label.set_text (a_text)
			a_point.set_x (dictionary.Margin)
			a_point.set_y (y_position)
			a_label.set_location (a_point)
			a_label.set_autosize (True)
			a_label.set_textalign (dictionary.Middle_center_alignment)
			if is_bold_style then
				create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
			else
				create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style)
			end
			a_label.set_font (a_font)
			main_panel.controls.add (a_label)
		end
		
end -- class ABOUT_DIALOG
