note
	description: "Summary description for {ALLOCA_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALLOCA_INST

inherit
	UNARY_INSTRUCTION

create

	make_from_pointer,
	make_type,
	make_type_name,
	make_type_array,
	make_type_array_name
--	make_type_array_align,
--	make_type_array_align_name

feature {NONE}

	make_type (ty: TYPE_L)
		do
			item := make_type_external (ty.item)
		end

	make_type_name (ty: TYPE_L; name: TWINE)
		do
			item := make_type_name_external (ty.item, name.item)
		end

	make_type_array (ty: TYPE_L; array_size: VALUE)
		do
			item := make_type_array_external (ty.item, array_size.item)
		end

	make_type_array_name (ty: TYPE_L; array_size: VALUE; name: TWINE)
		do
			item := make_type_array_name_external (ty.item, array_size.item, name.item)
		end

	make_type_array_align (ty: TYPE_L; array_size: VALUE; align: NATURAL_32)
		do
			item := make_type_array_align_external (ty.item, array_size.item, align)
		end

	make_type_array_align_name (ty: TYPE_L; array_size: VALUE; align: NATURAL_32; name: TWINE)
		do
			item := make_type_array_align_name_external (ty.item, array_size.item, align, name.item)
		end

feature {NONE} -- Externals

	make_type_array_align_name_external (ty: POINTER; array_size: POINTER; align: NATURAL_32; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::AllocaInst ((llvm::Type *)$ty, (llvm::Value *)$array_size, $align, *((llvm::Twine *)$name));
			]"
		end

	make_type_array_align_external (ty: POINTER; array_size: POINTER; align: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::AllocaInst ((llvm::Type *)$ty, (llvm::Value *)$array_size, $align);
			]"
		end

	make_type_array_name_external (ty: POINTER; array_size: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::AllocaInst ((llvm::Type *)$ty, (llvm::Value *)$array_size, *((llvm::Twine *)$name));
			]"
		end

	make_type_array_external (ty: POINTER; array_size: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::AllocaInst ((llvm::Type *)$ty, (llvm::Value *)$array_size);
			]"
		end

	make_type_external (ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::AllocaInst ((llvm::Type *)$ty);
			]"
		end

	make_type_name_external (ty: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instruction.h%""
		alias
			"[
				return new llvm::AllocaInst ((llvm::Type *)$ty, *((llvm::Twine *)$name));
			]"
		end

end
