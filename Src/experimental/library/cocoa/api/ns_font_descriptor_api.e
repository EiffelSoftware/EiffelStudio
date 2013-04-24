note
	description: "Summary description for {NS_FONT_DESCRIPTOR_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_DESCRIPTOR_API

feature -- Access

	frozen new: POINTER
			-- + (id)new
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFontDescriptor new];"
		end

	frozen font_descriptor_with_size (a_font_descriptor: POINTER; a_size: REAL): POINTER
			-- - (NSFontDescriptor *)fontDescriptorWithSize:(CGFloat)newPointSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontDescriptor*)$a_font_descriptor fontDescriptorWithSize: $a_size];"
		end

	frozen font_descriptor_with_symbolic_traits (a_font_descriptor: POINTER; a_symbolic_traits: NATURAL_32): POINTER
			-- - (NSFontDescriptor *)fontDescriptorWithSymbolicTraits:(NSFontSymbolicTraits)symbolicTraits
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontDescriptor*)$a_font_descriptor fontDescriptorWithSymbolicTraits: $a_symbolic_traits];"
		end

end
