note
	description: "Summary description for {LOAD_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOAD_INST

inherit
	UNARY_INSTRUCTION

create

	make_from_pointer,
	make,
	make_name,
	make_name_volatile,
	make_name_volatile_align

feature {NONE}

	make (ptr: VALUE)
		do
			item := make_external (ptr.item)
		end

	make_name (ptr: VALUE; name: TWINE)
		do
			item := make_name_external (ptr.item, name.item)
		end

	make_name_volatile (ptr: VALUE; name: TWINE; volatile: BOOLEAN)
		do
			item := make_name_volatile_external (ptr.item, name.item, volatile)
		end

	make_name_volatile_align (ptr: VALUE; name: TWINE; volatile: BOOLEAN; align: NATURAL_32)
		do
			item := make_name_volatile_align_external (ptr.item, name.item, volatile, align)
		end

feature {NONE} -- Externals

	make_external (ptr: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::LoadInst ((llvm::Value *)$ptr);
			]"
		end

	make_name_external (ptr: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::LoadInst ((llvm::Value *)$ptr, *((llvm::Twine *)$name));
			]"
		end

	make_name_volatile_external (ptr: POINTER; name: POINTER; volatile: BOOLEAN): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::LoadInst ((llvm::Value *)$ptr, *((llvm::Twine *)$name), $volatile);
			]"
		end

	make_name_volatile_align_external (ptr: POINTER; name: POINTER; volatile: BOOLEAN; align: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::LoadInst ((llvm::Value *)$ptr, *((llvm::Twine *)$name), $volatile, $align);
			]"
		end
end
