note
	description: "Summary description for {CALL_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALL_INST

inherit
	INSTRUCTION

create

	make_from_pointer,
	make,
	make_name,
	make_arguments,
	make_arguments_name

feature {NONE}

	make (f: VALUE)
		do
			item := make_external (f.item)
		end

	make_name (f: VALUE; name: TWINE)
		do
			item := make_name_external (f.item, name.item)
		end

	make_arguments (f: VALUE; args: VALUE_VECTOR)
		obsolete
			"Create procedure with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (args)
			item := make_arguments_external (f.item, array.item)
		end

	make_arguments_name (f: VALUE; args: VALUE_VECTOR; name: TWINE)
		obsolete
			"Create procedure with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (args)
			item := make_arguments_name_external (f.item, array.item, name.item)
		end

feature {NONE} -- Externals

	make_external (f: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f);
			]"
		end

	make_name_external (f: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f, *((llvm::Twine *)$name));
			]"
		end

	make_arguments_external (f: POINTER; args: POINTER): POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f, *((llvm::ArrayRef <llvm::Value *> *) $args));
			]"
		end

	make_arguments_name_external (f: POINTER; args: POINTER; name: POINTER): POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::CallInst::Create ((llvm::Value *)$f, *((llvm::ArrayRef <llvm::Value *> *) $args), *((llvm::Twine *)$name));
			]"
		end
end
