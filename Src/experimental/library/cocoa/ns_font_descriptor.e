note
	description: "Summary description for {NS_FONT_DESCRIPTOR}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_DESCRIPTOR

inherit
	NS_OBJECT

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_FONT_DESCRIPTOR_API}.new)
		end

feature -- Status setting

	set_size (a_size: REAL)
			-- Specifies the point size.
		do
			make_from_pointer ({NS_FONT_DESCRIPTOR_API}.font_descriptor_with_size (item, a_size))
		end

	set_trait (a_symbolic_traits: NATURAL_32)
		do
			make_from_pointer ({NS_FONT_DESCRIPTOR_API}.font_descriptor_with_symbolic_traits (item, a_symbolic_traits))
		end

feature --

	frozen bold_trait: NATURAL_32
			-- NSFontBoldTrait
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFontBoldTrait"
		end

end
