indexing 
	description: "Message box"
	external_name: "ISE.AssemblyManager.MessageBox"

class
	MESSAGE_BOX

inherit
	DIALOG
	
create 
	make

feature {NONE} -- Initialization

	make (a_message: STRING; call_back: SYSTEM_EVENTHANDLER) is
		indexing
			description: "Set `message' with `a_message'."
			external_name: "Make"
		require
			non_void_message: a_message /= Void
			not_empty_message: a_message.length > 0
			non_void_call_back: call_back /= Void
		local
			returned_value: INTEGER
			is_focused: BOOLEAN
			arguments: SYSTEM_EVENTARGS
		do
			make_form
			message := a_message
			initialize_gui	
			show
			is_focused := focus
			create arguments.make
			call_back.invoke (Current, arguments)
		ensure
			message_set: message.equals_string (a_message)
		end

feature -- Access

	message: STRING 
		indexing
			description: "Message"
			external_name: "Message"
		end
		
feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGui"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			a_font: SYSTEM_DRAWING_FONT
		do
			set_Enabled (True)
			set_text (Title)
			set_borderstyle (dictionary.Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)	
			set_maximizebox (False)
			set_icon (dictionary.Assembly_manager_icon)	
			
			create message_label.make_label
			a_point.set_x (dictionary.Margin)
			a_point.set_y (4 * dictionary.Margin)
			message_label.set_location (a_point)
			a_size.set_width (Window_width - 2 * dictionary.Margin - dictionary.Margin // 2)
			a_size.set_height (dictionary.Label_height)
			message_label.set_size (a_size)
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
			message_label.set_font (a_font)
			message_label.set_text (message)
			
			controls.add (message_label)
		end
		
feature {NONE} -- Implementation

	message_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Message label"
			external_name: "MessageLabel"
		end

	Title: STRING is "ISE Assembly Manager"
		indexing
			description: "Window title"
			external_name: "Title"
		end
	
	Window_height: INTEGER is 120
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end
	
	Window_width: INTEGER is 400
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end
		
end -- class MESSAGE_BOX
