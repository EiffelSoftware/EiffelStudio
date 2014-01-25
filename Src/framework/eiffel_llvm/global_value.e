note
	description: "Summary description for {GLOBAL_VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GLOBAL_VALUE

inherit
	CONSTANT

feature

	set_section (s: STRING_8)
		local
			s_c_string: C_STRING
			s_ref: STRING_REF
		do
			create s_c_string.make (s)
			create s_ref.make (s_c_string.item)
			set_section_external (item, s_ref.item)
		end

feature {NONE} -- Externals

	set_section_external (item_a: POINTER; s: POINTER)
		external
			"C++ inline use %"llvm/IR/GlobalValue.h%""
		alias
			"[
				((llvm::GlobalValue *)$item_a)->setSection (*((llvm::StringRef *)$s));
			]"
		end
end
