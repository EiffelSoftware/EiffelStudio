note
	description: "Summary description for {STORE_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STORE_INST

inherit
	INSTRUCTION

create

	make_from_pointer,
	make,
	make_volatile,
	make_volatile_align

feature {NONE}

	make (val: VALUE; ptr: VALUE)
		do
			item := make_external (val.item, ptr.item)
		end

	make_volatile (val: VALUE; ptr: VALUE; volatile: BOOLEAN)
		do
			item := make_volatile_external (val.item, ptr.item, volatile)
		end

	make_volatile_align (val: VALUE; ptr: VALUE; volatile: BOOLEAN; align: NATURAL_32)
		do
			item := make_volatile_align_external (val.item, ptr.item, volatile, align)
		end

feature {NONE} -- Externals

	make_external (val: POINTER; ptr: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::StoreInst ((llvm::Value *)$val, (llvm::Value *)$ptr);
			]"
		end

	make_volatile_external (val: POINTER; ptr: POINTER; volatile: BOOLEAN): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::StoreInst ((llvm::Value *)$val, (llvm::Value *)$ptr, $volatile);
			]"
		end

	make_volatile_align_external (val: POINTER; ptr: POINTER; volatile: BOOLEAN; align: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::StoreInst ((llvm::Value *)$val, (llvm::Value *)$ptr, $volatile, $align);
			]"
		end
end
