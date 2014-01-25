note
	description: "Summary description for {STRING_REF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_REF

create

	make,
	make_from_string

convert
	make_from_string ({STRING_8})

feature {NONE}

	make (c_string_a: POINTER)
		do
			item := ctor_external (c_string_a)
		end

	make_from_string (string_a: STRING_8)
		local
			string_l: C_STRING
		do
			create string_l.make (string_a)
			item := ctor_external (string_l.item)
		end

feature

	item: POINTER

feature {NONE}

	ctor_external (c_string_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/ADT/StringRef.h%""
		alias
			"[
				return new llvm::StringRef ((const char *)$c_string_a);
			]"
		end
end
