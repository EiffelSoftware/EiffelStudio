indexing
	description: ""
	
class
	HELLO_WORLD

inherit
	
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			dispose_boolean
		end

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		do
			initialize_components
			feature {WINFORMS_APPLICATION}.run_form (Current)
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container
	
	my_button: WINFORMS_BUTTON			
			-- System.Windows.Forms.Button
	
	my_text_box: WINFORMS_TEXT_BOX		
			-- System.Windows.Forms.TextBox 

feature -- Implementation

	initialize_components is
			-- Initialize all window components.
		do
			create components.make
			create my_button.make
			create my_text_box.make
			
				-- Initialize window.
			set_text (("Hello world").to_cil)
			set_auto_scale_base_size (create {DRAWING_SIZE}.make_from_width_and_height (5, 13))
			set_accessible_role (feature {WINFORMS_ACCESSIBLE_ROLE}.window)
			set_accessible_name (("AccessibleForm").to_cil)
			set_accept_button (my_button)
			set_accessible_description (("Simple Form that demonstrates accessibility").to_cil)
			set_client_size (create {DRAWING_SIZE}.make_from_width_and_height (392, 117))
			
				-- Initialize my_button.
			my_button.set_accessible_description (("Once you've entered some text push this my_button").to_cil)
			my_button.set_size (create {DRAWING_SIZE}.make_from_width_and_height (120, 40))
			my_button.set_tab_index (1)
			my_button.set_anchor (feature {WINFORMS_ANCHOR_STYLES}.bottom | feature {WINFORMS_ANCHOR_STYLES}.right)
			my_button.set_location (create {DRAWING_POINT}.make_from_x_and_y (256, 64))
			my_button.set_text (("Click Me!").to_cil)
			my_button.set_accessible_name (("DefaultAction").to_cil)
			my_button.add_click (create {EVENT_HANDLER}.make (Current, $my_button_clicked))
			
				-- Initialize my_text_box.
			my_text_box.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 24))
			my_text_box.set_text (("Hello WinForms World").to_cil)
			my_text_box.set_accessible_name (("TextEntryField").to_cil)
			my_text_box.set_tab_index (0)
			my_text_box.set_accessible_description (("Please enter some text in the box").to_cil)
			my_text_box.set_size (create {DRAWING_SIZE}.make_from_width_and_height (360, 20))
			
			controls.add (my_button)
			controls.add (my_text_box)
		end


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				dummy := feature {WINFORMS_MESSAGE_BOX}.show (("Disposed !").to_cil)
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
		end
	
	my_button_clicked (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when my_button is clicked.
		local
			msg: SYSTEM_STRING
			dummy: WINFORMS_DIALOG_RESULT
		do
			msg := msg.concat_string_string_string (("Text is : '").to_cil, my_text_box.text, ("'").to_cil)
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (msg)
		end
		
end -- class HELLO_WORLD
