indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.Dialog"

deferred class
	DIALOG
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

feature -- Access

	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
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

	assembly_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly label
		indexing
			external_name: "AssemblyLabel"
		end
		
feature -- Basic Operations

--	create_assembly_labels is
--		indexing
--			description: "Create labels with assembly name, version, culture and public key."
--			external_name: "CreateAssemblyLabels"
--		local
--			a_label: SYSTEM_WINDOWS_FORMS_LABEL
--			a_size: SYSTEM_DRAWING_SIZE
--			a_point: SYSTEM_DRAWING_POINT
--			a_font: SYSTEM_DRAWING_FONT
--		do
--			create a_label.make_label
--			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style) 
--			a_label.set_font (a_font)
--			a_label.set_text (dictionary.Name_string.concat_string_string (dictionary.Name_string, assembly_descriptor.name))
--			a_point.set_X (dictionary.Margin)
--			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
--			a_label.set_location (a_point)			
--			a_label.set_autosize (True)
--			controls.add (a_label)
--
--			create a_label.make_label
--			a_label.set_font (a_font)
--			a_label.set_text (dictionary.Version_string.concat_string_string (dictionary.Version_string, assembly_descriptor.version))
--			a_point.set_X (dictionary.Margin)
--			a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
--			a_label.set_location (a_point)			
--			a_label.set_autosize (True)
--			controls.add (a_label)
--
--			create a_label.make_label
--			a_label.set_font (a_font)
--			a_label.set_text (dictionary.Culture_string.concat_string_string (dictionary.Culture_string, assembly_descriptor.culture))
--			a_point.set_X (dictionary.Margin)
--			a_point.set_Y (dictionary.Margin + 3 * dictionary.Label_height)
--			a_label.set_location (a_point)			
--			a_label.set_autosize (True)
--			controls.add (a_label)
--
--			create a_label.make_label
--			a_label.set_font (a_font)
--			a_label.set_text (dictionary.Public_key_string.concat_string_string (dictionary.Public_key_string, assembly_descriptor.publickey))
--			a_point.set_X (dictionary.Margin)
--			a_point.set_Y (dictionary.Margin + 4 * dictionary.Label_height)
--			a_label.set_location (a_point)			
--			a_label.set_autosize (True)
--			controls.add (a_label)
--		end

	create_assembly_labels is
		indexing
			description: "Create labels with assembly version, culture and public key."
			external_name: "CreateAssemblyLabels"
		local
			a_label: SYSTEM_WINDOWS_FORMS_LABEL
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			a_font: SYSTEM_DRAWING_FONT
		do
			create a_label.make_label
			a_label.set_font (a_font)
			a_label.set_text (dictionary.Version_string.concat_string_string (dictionary.Version_string, assembly_descriptor.version))
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			a_label.set_location (a_point)			
			a_label.set_autosize (True)
			controls.add (a_label)

			create a_label.make_label
			a_label.set_font (a_font)
			a_label.set_text (dictionary.Culture_string.concat_string_string (dictionary.Culture_string, assembly_descriptor.culture))
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
			a_label.set_location (a_point)			
			a_label.set_autosize (True)
			controls.add (a_label)

			create a_label.make_label
			a_label.set_font (a_font)
			a_label.set_text (dictionary.Public_key_string.concat_string_string (dictionary.Public_key_string, assembly_descriptor.publickey))
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + 3 * dictionary.Label_height)
			a_label.set_location (a_point)			
			a_label.set_autosize (True)
			controls.add (a_label)
		end
		
end -- class DIALOG