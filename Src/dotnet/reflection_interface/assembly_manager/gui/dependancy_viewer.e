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
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `dependancies' with `assembly_dependancies'.
		indexing
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.Length > 0
			non_void_dependancies: assembly_dependancies /= Void
		local
			is_focused: BOOLEAN
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			build_dependancies_list
			initialize_gui
			show
			is_focused := focus
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
			non_void_dependancies_list: dependancies_list /= Void
		end

feature -- Access
	
	dictionary: DEPENDANCY_VIEWER_DICTIONARY is
			-- Dictionary
		indexing
			external_name: "Dictionary"
		once
			create Result
		end
		
feature -- Basic Operations

	initialize_gui is
			-- Initialize GUI.
		indexing
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT	
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			set_borderstyle (dictionary.Border_style)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			set_size (a_size)	
			set_maximizebox (False)
			set_icon (dictionary.Dependancies_icon)

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.name)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style) 
			assembly_label.set_font (label_font)
			controls.add (assembly_label)
			
			create_assembly_labels
			
				-- `Dependancies: '
			if dependancies.count > 0 then
				build_table
				a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
				a_size.set_height (dictionary.Window_height - 4 * Dictionary.Margin - 4 * dictionary.Label_height)
				data_grid.set_Size (a_size)
				data_grid.set_captiontext (dictionary.Caption_text)
				display_dependancies
				controls.add (data_grid)
			else
				create dependancies_label.make_label
				dependancies_label.set_text (dictionary.No_dependancies_text)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (3 * dictionary.Margin + 4 * dictionary.Label_height)
				dependancies_label.set_location (a_point)
				a_size.set_Height (dictionary.Label_height)
				dependancies_label.set_size (a_size)
				dependancies_label.set_font (label_font)	
				controls.add (dependancies_label)
			end
		end
		
end -- class DEPENDANCY_VIEWER
