indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.RemoveDialog"

class
	REMOVE_DIALOG
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

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
			return_value: INTEGER
		do
			make_form
			create dictionary
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
		end

feature -- Access
	
	dictionary: REMOVE_DIALOG_DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end
	
	dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			-- Assembly dependancies
		indexing
			external_name: "Dependancies"
		end

	assembly_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly label
		indexing
			external_name: "AssemblyLabel"
		end

	assembly_descriptor_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Assembly descriptor label
		indexing
			external_name: "AssemblyDescriptorLabel"
		end

	question_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Question label
		indexing
			external_name: "QuestionLabel"
		end

	dependancies_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Check box to remove dependancies 
		indexing
			external_name: "DependanciesCheckBox"
		end
				
	yes_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Yes button
		indexing
			external_name: "YesButton"
		end

	no_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- No button
		indexing
			external_name: "NoButton"
		end
		
	Window_height: INTEGER is 
			-- Window height
		indexing
			external_name: "WindowHeight"
		do
			if dependancies.count > 0 then
				Result := 220
			else
				Result := 180
			end
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
			a_font: SYSTEM_DRAWING_FONT
			i: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME
			dependancy_label: SYSTEM_WINDOWS_FORMS_LABEL	
			type: SYSTEM_TYPE
			on_yes_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_no_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			set_borderstyle (dictionary.Border_style)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)			

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (dictionary.Assembly_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size,  dictionary.Bold_style) 
			assembly_label.set_font (label_font)
			
			create assembly_descriptor_label.make_label
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style) 
			assembly_descriptor_label.set_font (a_font)			
			assembly_descriptor_label.set_text (dictionary.Assembly_descriptor_text (assembly_descriptor))
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			assembly_descriptor_label.set_location (a_point)			
			assembly_descriptor_label.set_autosize (True)

				-- Question to the user
			create question_label.make_label
			question_label.set_text (dictionary.Question_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (5 * dictionary.Margin +  dictionary.Label_height)
			question_label.set_location (a_point)
			question_label.set_autosize (True)	
			question_label.set_font (label_font)
			
				-- `Dependancies: '
			if dependancies.count > 0 then
					-- Dependancies check box (not checked by default)		
				create dependancies_check_box.make_checkbox
				dependancies_check_box.set_font (a_font)
				dependancies_check_box.set_text (dictionary.Dependancies_check_box_text)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (7 * dictionary.Margin + 2 * dictionary.Label_height)
				dependancies_check_box.set_location (a_point)
				a_size.set_height (dictionary.Label_height)
				dependancies_check_box.set_size (a_size)
				dependancies_check_box.set_checked (False)
				dependancies_check_box.set_autocheck (True)
				controls.add (dependancies_check_box)
			end
			
				-- Yes button
			create yes_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - dictionary.Button_width - (dictionary.Margin //2))
			a_point.set_Y (Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			yes_button.set_location (a_point)
			yes_button.set_text (dictionary.Yes_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_yes_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnYesEventHandler")
			yes_button.add_Click (on_yes_event_handler_delegate)

				-- No button
			create no_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			no_button.set_location (a_point)
			no_button.set_text (dictionary.No_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_no_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnNoEventHandler")
			no_button.add_Click (on_no_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (question_label)
			controls.add (yes_button)
			controls.add (no_button)
		end

feature -- Event handling

	on_yes_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `yes_button' activation.
		indexing
			external_name: "OnYesEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			warning_dialog: WARNING_DIALOG
			type: SYSTEM_TYPE
			on_confirmation_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			if dependancies.count > 0 then
				if dependancies_check_box.Checked then
					create on_confirmation_event_handler_delegate.make_eventhandler (Current, $remove_assembly_and_dependancies)
					create warning_dialog.make (assembly_descriptor, dependancies, dictionary.Warning_text, on_confirmation_event_handler_delegate)
				else
					remove_assembly
					close
				end
			else
				remove_assembly
				close
			end
		end

	on_no_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `no_button' activation.
		indexing
			external_name: "OnNoEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end
		
feature {NONE} -- Implementation

	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type
		indexing
			external_name: "TypeFactory"
		end
		
	delegate_factory: SYSTEM_DELEGATE
			-- Statics needed to create a delegate
		indexing
			external_name: "DelegateFactory"
		end

	remove_assembly is
			-- Remove the assembly corresponding to `assembly_descriptor'.
		indexing
			external_name: "RemoveAssembly"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			retried: BOOLEAN
		do
			if not retried then
				create reflection_interface.make_reflectioninterface
				reflection_interface.MakeReflectionInterface
				reflection_interface.removeassembly (assembly_descriptor)
			end
		rescue
			retried := True
			retry
		end
		
	remove_assembly_and_dependancies is
			-- Remove the assembly corresponding to `assembly_descriptor' and its dependancies.
		indexing
			external_name: "RemoveAssemblyAndDependancies"
		require
			non_void_assembly_descriptor: assembly_descriptor /= Void
		local
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			i: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			convert: ISE_REFLECTION_CONVERSIONSUPPORT
			retried: BOOLEAN
		do
			remove_assembly
			if not retried then
				create reflection_interface.make_reflectioninterface
				reflection_interface.MakeReflectionInterface
				create convert.make_conversionsupport
				from
				until
					i = dependancies.count
				loop
					a_dependancy := dependancies.item (i)
					a_descriptor := convert.assemblydescriptorfromname (a_dependancy)
					reflection_interface.removeassembly (a_descriptor)
					i := i + 1
				end
			end
			close
		rescue
			retried := True
			retry
		end	
		
end -- class REMOVE_DIALOG
