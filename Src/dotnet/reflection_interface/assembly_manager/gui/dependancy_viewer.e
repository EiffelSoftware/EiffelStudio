indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.DependancyViewer"

class
	DEPENDANCY_VIEWER
	
inherit
	DEPENDANCY_DIALOG
		redefine
			dictionary
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies) is 
		indexing
			description: "[
						Set `assembly_descriptor' with `an_assembly_descriptor'.
						Set `dependancies' with `assembly_dependancies'.
					  ]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.count > 0
			non_void_dependancies: assembly_dependancies /= Void
		local
			is_focused: BOOLEAN
		do
			create main_win.make_winforms_form
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			build_dependancies_list
			initialize_gui
			main_win.show
			is_focused := main_win.focus
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
			non_void_dependancies_list: dependancies_list /= Void
		end

feature -- Access
	
	dictionary: DEPENDANCY_VIEWER_DICTIONARY is
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
			external_name: "InitializeGUI"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			label_font: DRAWING_FONT
			style: DRAWING_FONT_STYLE
			border_style: WINFORMS_FORM_BORDER_STYLE
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX	
		do
			main_win.set_Enabled (True)
			main_win.set_text (dictionary.Title.to_cil)
			main_win.set_form_border_style (border_style.fixed_single)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			main_win.set_size (a_size)	
			main_win.set_maximize_box (False)
			if not retried then
				main_win.set_icon (dictionary.Dependancies_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end

				-- `Selected assembly: '
			create assembly_label.make_winforms_label
			assembly_label.set_text (assembly_descriptor.name.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold) 
			assembly_label.set_font (label_font)
			main_win.get_controls.add (assembly_label)
			
			create_assembly_labels
			
				-- `Dependancies: '
			if dependancies.count > 0 then
				build_table
				a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
				a_size.set_height (dictionary.Window_height - 4 * Dictionary.Margin - 4 * dictionary.Label_height)
				data_grid.set_Size (a_size)
				data_grid.set_caption_text (dictionary.Caption_text.to_cil)
				display_dependancies
				main_win.get_controls.add (data_grid)
			else
				create dependancies_label.make_winforms_label
				dependancies_label.set_text (dictionary.No_dependancies_text.to_cil)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (3 * dictionary.Margin + 4 * dictionary.Label_height)
				dependancies_label.set_location (a_point)
				a_size.set_Height (dictionary.Label_height)
				dependancies_label.set_size (a_size)
				dependancies_label.set_font (label_font)	
				main_win.get_controls.add (dependancies_label)
			end
		rescue
			retried := True
			retry
		end
		
end -- class DEPENDANCY_VIEWER
