indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.Dialog"

deferred class
	DIALOG
	
inherit
	ASSMEBLY_MANAGER_SUPPORT [STRING]
		rename
			to_string as to_assembly_manager_support_string,
			finalize as assembly_manager_support_finalize
		end
		
feature -- Access

	main_win: WINFORMS_FORM

	assembly_descriptor: ASSEMBLY_DESCRIPTOR
		indexing
			description: "Assembly descriptor"
			external_name: "AssemblyDescriptor"
		end

	dictionary: DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		ensure
			non_void_dictionary: Result /= Void
		end

	assembly_label: WINFORMS_LABEL
		indexing
			description: "Assembly label"
			external_name: "AssemblyLabel"
		end
		
feature -- Basic Operations

	create_assembly_labels is
		indexing
			description: "Create labels with assembly version, culture and public key."
			external_name: "CreateAssemblyLabels"
		local
			a_label: WINFORMS_LABEL
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			a_font: DRAWING_FONT
			label_text: STRING
		do
			create a_label.make_winforms_label
			a_label.set_font (a_font)
			label_text := dictionary.Version_string.clone (dictionary.Version_string)
			label_text.append (assembly_descriptor.version)
			a_label.set_text (label_text.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			a_label.set_location (a_point)			
			a_label.set_auto_size (True)
			main_win.get_controls.add (a_label)

			create a_label.make_winforms_label
			a_label.set_font (a_font)
			label_text := dictionary.Culture_string.clone (dictionary.Culture_string)
			label_text.append (assembly_descriptor.culture)
			a_label.set_text (label_text.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
			a_label.set_location (a_point)			
			a_label.set_auto_size (True)
			main_win.get_controls.add (a_label)

			create a_label.make_winforms_label
			a_label.set_font (a_font)
			label_text := dictionary.Public_key_string.clone (dictionary.Public_key_string)
			label_text.append (assembly_descriptor.public_key)
			a_label.set_text (label_text.to_cil)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + 3 * dictionary.Label_height)
			a_label.set_location (a_point)			
			a_label.set_auto_size (True)
			main_win.get_controls.add (a_label)
		end
		
end -- class DIALOG
