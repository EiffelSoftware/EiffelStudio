indexing 
	description: "Message box"
	external_name: "ISE.AssemblyManager.MessageBox"

class
	MESSAGE_BOX

inherit
	DIALOG
		redefine
			dictionary
		end
	
create 
	make

feature {NONE} -- Initialization

	make (a_message: STRING; call_back: EVENT_HANDLER) is
		indexing
			description: "Set `message' with `a_message'."
			external_name: "Make"
		require
			non_void_message: a_message /= Void
			not_empty_message: a_message.count > 0
			non_void_call_back: call_back /= Void
		local
			returned_value: WINFORMS_DIALOG_RESULT
			is_focused: BOOLEAN
			arguments: EVENT_ARGS
		do
			create main_win.make_winforms_form
			message := a_message
			initialize_gui	
			main_win.show
			is_focused := main_win.focus
			create arguments.make
			call_back.invoke (Current, arguments)
		ensure
			message_set: message.is_equal (a_message)
		end

feature -- Access

	message: STRING 
		indexing
			description: "Message"
			external_name: "Message"
		end

	dictionary: MESSAGE_BOX_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
		
feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGui"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			a_font: DRAWING_FONT
			a_label: WINFORMS_LABEL
			a_panel: WINFORMS_PANEL
			an_image: DRAWING_IMAGE
			border_style: WINFORMS_FORM_BORDER_STYLE
			style: DRAWING_FONT_STYLE
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX
			file: PLAIN_TEXT_FILE
		do
			main_win.set_Enabled (True)
			main_win.set_text (dictionary.Title.to_cil)
			main_win.set_form_border_style (border_style.fixed_single)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			main_win.set_size (a_size)	
			main_win.set_maximize_box (False)
			if not retried then
				create file.make (dictionary.Assembly_manager_icon_filename)
				if file.exists then
					main_win.set_icon (dictionary.Assembly_manager_icon)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				end
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
			
			create message_label.make_winforms_label
			a_point.set_x (dictionary.Margin)
			a_point.set_y (2 * dictionary.Margin)
			message_label.set_location (a_point)
			message_label.set_auto_size (True)
			create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold)
			message_label.set_font (a_font)
			message_label.set_text (message.to_cil)
			main_win.get_controls.add (message_label)

			create a_label.make_winforms_label
			a_point.set_x (dictionary.Margin)
			a_point.set_y (2 * dictionary.Margin + dictionary.Label_height)
			a_label.set_location (a_point)
			a_label.set_auto_size (True)
			create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Regular)
			a_label.set_font (a_font)
			a_label.set_text (dictionary.Other_message.to_cil)
			main_win.get_controls.add (a_label)
			
				-- Image
			if not retried then
				create file.make (dictionary.Watch_icon_filename)
				if file.exists then
					an_image := image_factory.from_file (dictionary.Watch_icon_filename.to_cil)
					create a_panel.make_winforms_panel
					a_panel.set_height (an_image.get_height)
					a_panel.set_width (an_image.get_width)
					a_panel.set_background_image (an_image)	
					a_point.set_x (dictionary.Window_width - 2 * dictionary.Margin - an_image.get_width)
					a_point.set_y (2 * dictionary.Margin)
					a_panel.set_location (a_point)
				else
					returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Watch_pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
					create a_panel.make_winforms_panel
					a_panel.set_height (dictionary.Image_height)
					a_panel.set_width (dictionary.Image_width)
					a_point.set_x (dictionary.Window_width - 2 * dictionary.Margin - dictionary.Image_width)
					a_point.set_y (2 * dictionary.Margin)
					a_panel.set_location (a_point)				
				end
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Watch_pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
				create a_panel.make_winforms_panel
				a_panel.set_height (dictionary.Image_height)
				a_panel.set_width (dictionary.Image_width)
				a_point.set_x (dictionary.Window_width - 2 * dictionary.Margin - dictionary.Image_width)
				a_point.set_y (2 * dictionary.Margin)
				a_panel.set_location (a_point)
			end
			main_win.get_controls.add (a_panel)	
		rescue 
			retried := True
			retry
		end
		
feature {NONE} -- Implementation

	message_label: WINFORMS_LABEL
		indexing
			description: "Message label"
			external_name: "MessageLabel"
		end

	image_factory: DRAWING_IMAGE 
		indexing
			description: "Static needed to create images"
			external_name: "ImageFactory"
		end
		
end -- class MESSAGE_BOX
