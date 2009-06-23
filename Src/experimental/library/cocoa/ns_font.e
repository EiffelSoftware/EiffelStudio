note
	description: "Wrapper for NSFont."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT

inherit
	NS_OBJECT

create
	system_font_of_size,
	bold_system_font_of_size,
	label_font_of_size,
	font_with_descriptor
create {NS_OBJECT}
	make_from_pointer

feature -- Creation

	font_with_descriptor (a_font_descriptor: NS_FONT_DESCRIPTOR; a_size: REAL)
			-- Returns a font object for the specified font descriptor and font size.
		do
			share_from_pointer ({NS_FONT_API}.font_with_descriptor (a_font_descriptor.item, a_size))
		end

feature -- Factory

	-- FIXME: Do only create one object for every Cocoa-Object

	font_with_name (a_font_name: STRING; a_size: REAL)
		do

		end

	system_font_of_size (a_font_size: REAL)
		do
			share_from_pointer ({NS_FONT_API}.system_font_of_size (a_font_size))
		end

	bold_system_font_of_size (a_font_size: REAL)
		do
			share_from_pointer ({NS_FONT_API}.bold_system_font_of_size (a_font_size))
		end

	label_font_of_size (a_font_size: REAL)
		do
			share_from_pointer ({NS_FONT_API}.label_font_of_size (a_font_size))
		end

feature -- Access

	font_name: STRING
		do
			Result := (create {NS_STRING}.make_from_pointer ({NS_FONT_API}.font_name (item))).to_string
		ensure
			result_not_void: Result /= void
		end

end
