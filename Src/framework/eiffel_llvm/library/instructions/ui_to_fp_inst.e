note
	description: "Summary description for {UI_TO_FP_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UI_TO_FP_INST

inherit
	CAST_INST

create

	make,
	make_name

feature {NONE}

	make (s: VALUE; ty: TYPE_L)
		do
			item := make_external (s.item, ty.item)
		end

	make_name (s: VALUE; ty: TYPE_L; name: TWINE)
		do
			item := make_name_external (s.item, ty.item, name.item)
		end

feature {NONE} -- Externals

	make_external (s: POINTER; ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::UIToFPInst ((llvm::Value *)$s, (llvm::Type *)$ty);
			]"
		end

	make_name_external (s: POINTER; ty: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::UIToFPInst ((llvm::Value *)$s, (llvm::Type *)$ty, *((llvm::Twine *)$name));
			]"
		end

end
