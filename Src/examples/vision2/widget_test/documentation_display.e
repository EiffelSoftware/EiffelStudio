indexing
	description: "Objects that display documentation for Vision2 classes."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_DISPLAY
	
inherit
	INTERNAL
	
	WIDGET_TEST_SHARED
	
	INSTALLATION_LOCATOR

create
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (a_text: EV_TEXT) is
			-- Create `Current' and and assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			text := a_text
		end

feature -- Status setting

	update_for_type_change (widget: EV_WIDGET) is
			-- Update documentation for type matching `widget'.
		do
			application.idle_actions.extend (agent real_update_for_type_change (widget))
				-- We defer this so that it is executed on the idle actions of EV_APPLICATION.
				-- This speeds up the appearence of the type change to a user, as they are not
				-- waiting for the file to load before being able to interact with the interface.
		end
		
	real_update_for_type_change (widget: EV_WIDGET) is
			-- Actually perform the update of the text.
		local
			file_name: STRING
			directory_name: DIRECTORY_NAME
			full_filename: FILE_NAME
			file: PLAIN_TEXT_FILE
		do
			application.idle_actions.prune (application.idle_actions.first)
			file_name := class_name (widget)
			file_name.to_lower
			file_name.append ("_flatshort.txt")
			create directory_name.make_from_string (installation_location)
			directory_name.extend ("flatshort")
			create full_filename.make_from_string (directory_name.out)
			full_filename.extend (file_name)
			create file.make_open_read (full_filename)
			file.readstream (file.count)
			text.set_text (file.last_string)
			file.close
		end

feature {NONE} -- Implementation

	text: EV_TEXT
		-- All class output is displayed on this widget.

invariant
	text_not_void: text /= Void

end -- class DOCUMENTATION_DISPLAY
