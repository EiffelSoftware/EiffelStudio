indexing
	description: "Interface between the analyzer and the application through dialog boxes";
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_MANAGER

feature

	dialog_message: DIALOG_MESSAGE is
			-- Create an intro dialog boxe
		require	
--			parent_not_void: dialog_parent /= Void
		once
			!! Result.make (dialog_parent)
		ensure
			dialog_message_exists: Result.exists
		end

	dialog_error: DIALOG_ERROR is
			-- Create a error dialog boxe
		require	
--			parent_not_void: dialog_parent /= Void
		once
			!! Result.make (dialog_parent)
		ensure
			dialog_error_exists: Result.exists
		end

feature -- Access

	dialog_parent: WEL_COMPOSITE_WINDOW
			-- Parent of the dialog.

	std_out: INTEGER is 1
			-- Constant for the standard output

	std_error: INTEGER is 2
			-- Constant for the error output

	interface: INTERFACE_MANAGER is
		once
			!! Result
		end

feature -- Element change

	set_dialog_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set `parent_dialog' to `a_parent'.
		require
--			a_parent_not_void: a_parent /= Void
		do
			dialog_parent := a_parent
		ensure
--			parent_set: dialog_parent = a_parent
		end

	display_text (output: INTEGER ; a_string: STRING) is
			-- Display `a_string' in the `output'.
		require
			a_string_not_void: a_string /= Void
		do
			if (output = std_out) then
--				dialog_message.show
--				dialog_message.static_info.set_text (a_string)
			end
	
			if (output = std_error) then
--				dialog_error.show
--				dialog_error.static_info.set_text (a_string)
			end
		end
	
	hide_message is
			-- Hide the message dialog box.
		do
			dialog_message.hide
		end

	hide_error is
			-- Hide the error dialog box.
		do
			dialog_error.hide
		end

	hide_all is
			-- Hide all the dialog boxes.
		do
			hide_message
			hide_error
		end

	do_terminate is
			-- Close the dialog box
		do
			if (dialog_message /= Void) then
				dialog_message.terminate (0)
			end

			if (dialog_error /= Void) then
				dialog_error.terminate (0)
			end
		end

	l_of_include_file: LINKED_LIST [STRING] is
		once
			create Result.make
		end

end -- class INTERFACE_MANAGER
