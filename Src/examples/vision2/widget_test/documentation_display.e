indexing
	description: "Objects that display documentation for Vision2 classes."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_DISPLAY
	
inherit
	INTERNAL

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
		

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

	update_for_type_change (widget: EV_WIDGET) is
			--
		local
			file_name: STRING
			directory: DIRECTORY
			directory_name: DIRECTORY_NAME
			full_filename: FILE_NAME
			file: PLAIN_TEXT_FILE
		do
			file_name := class_name (widget)
			--file_name := file_name.substring (4, file_name.count)
			file_name.append ("_flatshort.txt")
			create directory_name.make_from_string (".")
			directory_name.extend ("flatshort")
			create full_filename.make_from_string (directory_name.out)
			full_filename.extend (file_name)
			create file.make_open_read (full_filename)
			file.readstream (file.count)
			text.set_text (file.last_string)
			--class_names.extend (filename.substring (1, filename.count - 2))
			file.close
		end
		

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	text: EV_TEXT
		-- All class output is displayed on this widget.

invariant
	text_not_void: text /= Void

end -- class DOCUMENTATION_DISPLAY
