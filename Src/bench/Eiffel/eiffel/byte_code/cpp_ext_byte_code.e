indexing

	description:
		"Encapsulation of a C++ external.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE

feature -- Properties

	class_name: STRING
 
	class_header_file: STRING
 
	type: INTEGER
 
feature -- Convenience
 
	set_class_header_file (h: STRING) is
			-- Assign `h' to `class_header_file'.
		do
			class_header_file := h
		end
 
	set_class_name (n: STRING) is
			-- Assign `n' to `class_name'.
		do
			class_name := n
		end
 
	set_type (t: INTEGER) is
			-- Assing `t' to `type'.
		do
			type := t
		end

end -- class CPP_EXT_BYTE_CODE
