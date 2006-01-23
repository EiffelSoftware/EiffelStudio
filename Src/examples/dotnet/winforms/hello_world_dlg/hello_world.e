indexing
	description: "Display a dialog box containing a %"Hello Windows Forms world%" message."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	HELLO_WORLD

inherit
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			dispose_boolean
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			--| Call `initialize_components'.
			-- Entry point.
		do
			initialize_components
			{WINFORMS_APPLICATION}.run_form (Current)
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
			set_text ("Hello world")
			set_auto_scale_base_size (create {DRAWING_SIZE}.make (5, 13))
			set_accessible_role ({WINFORMS_ACCESSIBLE_ROLE}.window)
			set_accessible_name ("AccessibleForm")
			set_accept_button (my_button)
			set_accessible_description ("Simple Form that demonstrates accessibility")
			set_client_size (create {DRAWING_SIZE}.make (392, 117))

				-- Initialize my_button.
			my_button.set_accessible_description ("Once you've entered some text push this my_button")
			my_button.set_size (create {DRAWING_SIZE}.make (120, 40))
			my_button.set_tab_index (1)
			my_button.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.right)
			my_button.set_location (create {DRAWING_POINT}.make (256, 64))
			my_button.set_text ("Click Me!")
			my_button.set_accessible_name ("DefaultAction")
			my_button.add_click (create {EVENT_HANDLER}.make (Current, $on_my_button_clicked))

				-- Initialize my_text_box.
			my_text_box.set_location (create {DRAWING_POINT}.make (16, 24))
			my_text_box.set_text ("Hello Windows Forms World")
			my_text_box.set_accessible_name ("TextEntryField")
			my_text_box.set_tab_index (0)
			my_text_box.set_accessible_description ("Please enter some text in the box")
			my_text_box.set_size (create {DRAWING_SIZE}.make (360, 20))

			controls.add (my_button)
			controls.add (my_text_box)
		ensure
			non_void_components: components /= Void
			non_void_my_button: my_button /= Void
			non_void_my_text_box: my_text_box /= Void
		end


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			res: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				res := {WINFORMS_MESSAGE_BOX}.show ("Disposed !")
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := True
			retry
		end

	on_my_button_clicked (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when my_button is clicked.
		local
			msg: STRING
			res: WINFORMS_DIALOG_RESULT
		do
			msg := "Text is : '"
			msg.append (my_text_box.text)
			msg.append ("'")
			res := {WINFORMS_MESSAGE_BOX}.show (msg)
		end

invariant
	non_void_components: components /= Void
	non_void_my_button: my_button /= Void
	non_void_my_text_box: my_text_box /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class HELLO_WORLD
