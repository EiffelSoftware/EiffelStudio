indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.DependancyViewer"

class
	DEPENDANCY_VIEWER
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; assembly_dependancies: like dependancies) is --; a_call_back: like call_back) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `dependancies' with `assembly_dependancies'.
			-- Set `call_back' with `a_call_back'.
		indexing
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.Length > 0
			non_void_dependancies: assembly_dependancies /= Void
			--non_void_call_back: a_call_back /= Void
		local
			return_value: INTEGER
		do
			make_form
			create dictionary
			assembly_descriptor := an_assembly_descriptor
			dependancies := assembly_dependancies
			--call_back := a_call_back
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			dependancies_set: dependancies = assembly_dependancies
			--call_back_set: call_back = a_call_back
		end

feature -- Access
	
	dictionary: DEPENDANCY_VIEWER_DICTIONARY
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

--	call_back: SYSTEM_EVENTHANDLER
--			-- Delegate called when `close_button' is selected
--		indexing
--			external_name: "CallBack"
--		end
		
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
	
	close_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Close button
		indexing
			external_name: "CloseButton"
		end

	Window_height: INTEGER is 
			-- Window height
		indexing
			external_name: "WindowHeight"
		do
			if dependancies.count = 0 then
				Result := 200
			else
				Result := dictionary.Label_height * (dependancies.count + 4) + (dependancies.count + 8) * dictionary.Margin + dictionary.Button_height
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
			on_close_event_handler_delegate: SYSTEM_EVENTHANDLER
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
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style) 
			assembly_label.set_font (label_font)
			
			create assembly_descriptor_label.make_label
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style) 
			assembly_descriptor_label.set_font (a_font)
			assembly_descriptor_label.set_text (dictionary.Assembly_descriptor_text (assembly_descriptor))
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			assembly_descriptor_label.set_location (a_point)			
			assembly_descriptor_label.set_autosize (True)
			
				-- `Dependancies: '
			if dependancies.count > 0 then
				create dependancies_label.make_label
				dependancies_label.set_text (dictionary.Dependancies_label_text)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (3 * dictionary.Margin + 2 * dictionary.Label_height)
				dependancies_label.set_location (a_point)
				a_size.set_Height (dictionary.Label_height)
				dependancies_label.set_size (a_size)
				dependancies_label.set_font (label_font)
				from
				until
					i = dependancies.count
				loop
					a_dependancy := dependancies.item (i)
					create dependancy_label.make_label
					dependancy_label.set_text (a_dependancy.fullname)
					a_point.set_X (dictionary.Margin)
					a_point.set_Y ( (4 + i) * dictionary.Margin + (3 + i) * dictionary.Label_height)
					dependancy_label.set_location (a_point)			
					dependancy_label.set_autosize (True)
					dependancy_label.set_font (a_font)
					controls.add (dependancy_label)
					i := i + 1
				end 
			else
				create dependancies_label.make_label
				dependancies_label.set_text (dictionary.No_dependancies_text)
				a_point.set_X (dictionary.Margin)
				a_point.set_Y (3 * dictionary.Margin + 2 * dictionary.Label_height)
				dependancies_label.set_location (a_point)
				a_size.set_Height (dictionary.Label_height)
				dependancies_label.set_size (a_size)
				dependancies_label.set_font (label_font)				
			end
				
				-- Close button
			create close_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Button_width //2))
			a_point.set_Y (Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			close_button.set_location (a_point)
			close_button.set_text (dictionary.Close_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_close_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCloseEventHandler")
			close_button.add_Click (on_close_event_handler_delegate)
			
				-- Addition of controls
			controls.add (assembly_label)
			controls.add (assembly_descriptor_label)
			controls.add (dependancies_label)
			controls.add (close_button)
		end

feature -- Event handling

	on_close_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `close_button' activation.
		indexing
			external_name: "OnCloseEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		--local
			--an_array: ARRAY [ANY]
			--object_invoked: ANY
		do
			close
			--create an_array.make (0)
			--object_invoked := call_back.dynamicinvoke (an_array)
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
			
end -- class DEPENDANCY_VIEWER
