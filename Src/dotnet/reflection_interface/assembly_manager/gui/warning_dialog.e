indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.WarningDialog"

class
	WARNING_DIALOG
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies; a_question: like question_label_text; a_call_back: like call_back) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `dependancies' with `assembly_dependancies'.
			-- Set `question_label_text' with `a_question'.
			-- Set `call_back' with `a_call_back'.
		indexing
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.Length > 0
			non_void_dependancies: assembly_dependancies /= Void
			not_empty_dependancies: assembly_dependancies.count > 0
			non_void_question: a_question /= Void
			not_empty_question: a_question.length > 0
			non_void_call_back: a_call_back /= Void
		local
			return_value: INTEGER
		do
			make_form
			create dictionary
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			question_label_text := a_question
			call_back := a_call_back
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
			question_set: question_label_text.equals_string (a_question)
			call_back_set: call_back = a_call_back
		end

feature -- Access
	
	console: SYSTEM_CONSOLE
	
	dictionary: WARNING_DIALOG_DICTIONARY
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

	question_label_text: STRING 
			-- Question to the user
		indexing
			external_name: "QuestionLabelText"
		end
		
	call_back: SYSTEM_EVENTHANDLER
			-- Call back agent
		indexing
			external_name: "CallBack"
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

	dependancies_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Dependancies label
		indexing
			external_name: "DependanciesLabel"
		end

	question_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Question label
		indexing
			external_name: "QuestionLabel"
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
		once
			--Result := dictionary.Label_height * (dependancies.count + 5) + (dependancies.count + 8) * dictionary.Margin + dictionary.Button_height
			Result := Label_height * (dependancies.count + 5) + (dependancies.count + 8) *  Margin + Button_height
		end
		
feature -- Constants
	
	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
		end
	
	Window_width: INTEGER is 800
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
		
	Margin: INTEGER is 10
			-- Margin
		indexing
			external_name: "Margin"
		end
		
	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
	
	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end

	Font_size: REAL is 8.0
			-- Font size
		indexing
			external_name: "FontSize"
		end
		
	Bold_style: INTEGER is 1
			-- Bold style
		indexing
			external_name: "BoldStyle"
		end
		
	Regular_style: INTEGER is 0
			-- Regular style
		indexing
			external_name: "RegularStyle"
		end	
			
	Button_height: INTEGER is 23
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end
	
	Button_width: INTEGER is 75
			-- Button height
		indexing
			external_name: "ButtonWidth"
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
			--set_borderstyle (dictionary.Border_style)
			--a_size.set_Width (dictionary.Window_width)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)		

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (dictionary.Assembly_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin)
			a_point.set_X (Margin)
			a_point.set_Y (Margin)
			assembly_label.set_location (a_point)
			--a_size.set_Height (dictionary.Label_height)
			a_size.set_Height (Label_height)
			assembly_label.set_size (a_size)
			--create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size,  dictionary.Bold_style) 
			create label_font.make_font_10 (dictionary.Font_family_name, Label_font_size,  Bold_style) 
			assembly_label.set_font (label_font)
			
			create assembly_descriptor_label.make_label
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style) 
			create a_font.make_font_10 (dictionary.Font_family_name, Font_size, Regular_style) 
			assembly_descriptor_label.set_font (a_font)
			assembly_descriptor_label.set_text (dictionary.Assembly_descriptor_text (assembly_descriptor))
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (Margin + Label_height)
			assembly_descriptor_label.set_location (a_point)			
			assembly_descriptor_label.set_autosize (True)
			
				-- `Dependancies: '
			create dependancies_label.make_label
			dependancies_label.set_text (dictionary.Dependancies_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (4 * dictionary.Margin + dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (4 * Margin + Label_height)
			dependancies_label.set_location (a_point)
			dependancies_label.set_autosize (True)
			dependancies_label.set_font (label_font)
			from
			until
				i = dependancies.count
			loop
				a_dependancy := dependancies.item (i)
				create dependancy_label.make_label
				dependancy_label.set_font (a_font)
				dependancy_label.set_text (a_dependancy.fullname)
				--a_point.set_X (dictionary.Margin)
				--a_point.set_Y ( (5 + i) * dictionary.Margin + (2 + i) * dictionary.Label_height)
				a_point.set_X (Margin)
				a_point.set_Y ( (5 + i) * Margin + (2 + i) * Label_height)
				dependancy_label.set_location (a_point)			
				dependancy_label.set_autosize (True)					
				controls.add (dependancy_label)
				i := i + 1
			end 

				-- Question to the user
			create question_label.make_label
			question_label.set_text (Question_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin * (dependancies.count + 6) + dictionary.Label_height * (dependancies.count + 2))
			a_point.set_X (Margin)
			a_point.set_Y (Margin * (dependancies.count + 6) + Label_height * (dependancies.count + 2))
			question_label.set_location (a_point)
			question_label.set_autosize (True)	
			question_label.set_font (label_font)
			
				-- Yes button
			create yes_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) - dictionary.Button_width - (dictionary.Margin //2))
			--a_point.set_Y (Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			a_point.set_X ((Window_width // 2) - Button_width - (Margin //2))
			a_point.set_Y (Window_height - 4 * Margin - Button_height)
			yes_button.set_location (a_point)
			yes_button.set_text (dictionary.Yes_button_label)
			--type := type_factory.GetType_String (dictionary.System_event_handler_type)
			--on_yes_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnYesEventHandler")
			--yes_button.add_Click (on_yes_event_handler_delegate)
			yes_button.add_Click (call_back)

				-- No button
			create no_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			--a_point.set_Y (Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			a_point.set_X ((Window_width // 2) + (Margin //2))
			a_point.set_Y (Window_height - 4 * Margin - Button_height)
			no_button.set_location (a_point)
			no_button.set_text (dictionary.No_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_no_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnNoEventHandler")
			no_button.add_Click (on_no_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (dependancies_label)
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
		do
			console.writeline_string ("yes clicked: will import without dependancies")
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
			
end -- class WARNING_DIALOG
