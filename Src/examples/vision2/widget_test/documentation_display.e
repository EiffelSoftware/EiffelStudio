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

	make_with_text (a_text: EV_RICH_TEXT) is
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
			file_name.append ("_flatshort.rtf")
			if installation_location /= Void then
				create directory_name.make_from_string (installation_location)
				directory_name.extend ("flatshort")
				create full_filename.make_from_string (directory_name.out)
				full_filename.extend (file_name)
				create file.make (full_filename)
			end
			if installation_location /= Void and then file.exists then
				text.set_with_named_file (full_filename)
			else
				text.set_text ("Unable to locate the documentation for " + test_widget_type + ".%N%N" + location_error_message)
			end
			update_text_size
		end
		
	update_text_size is
			-- adjust font size of `flat_short_display' by `value'.
		local
			font: EV_FONT
			format_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			format: EV_CHARACTER_FORMAT
		do
			format := text.character_format (1)
			font := format.font
			font.set_height (current_text_size)
			format.set_font (font)
			create format_info.make_with_flags (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_height)
			text.modify_region (1, text.text_length, format, format_info)
		end

feature {NONE} -- Implementation

	text: EV_RICH_TEXT
		-- All class output is displayed on this widget.

invariant
	text_not_void: text /= Void

end -- class DOCUMENTATION_DISPLAY
