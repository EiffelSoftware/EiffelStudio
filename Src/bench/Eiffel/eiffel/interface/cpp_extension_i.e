indexing

	description:
		"Encapsulation of a C++ extension.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		rename
			is_equal as ext_is_equal
		end
	EXTERNAL_EXT_I
		redefine
			is_equal
		select
			is_equal
		end

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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := ext_is_equal (other) and then
				class_name.is_equal (other.class_name) and then
				class_header_file.is_equal (other.class_header_file) and then
				type.is_equal (other.type)
		end

end -- class CPP_EXTENSION_I
