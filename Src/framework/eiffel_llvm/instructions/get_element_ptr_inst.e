note
	description: "Summary description for {GET_ELEMENT_PTR_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GET_ELEMENT_PTR_INST

inherit
	INSTRUCTION

create

	make_from_pointer,
	make_index_list,
	make_index_list_name,
	make_inbounds_index_list,
	make_inbounds_index_list_name

feature {NONE}

	make_index_list (ptr: VALUE; idx: VALUE_VECTOR)
		obsolete
			"Create procedure with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (idx)
			item := make_index_list_external (ptr.item, array.item)
		end

	make_index_list_name (ptr: VALUE; idx: VALUE_VECTOR; name: TWINE)
		obsolete
			"Create procedure with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (idx)
			item := make_index_list_name_external (ptr.item, array.item, name.item)
		end

	make_inbounds_index_list (ptr: VALUE; idx: VALUE_VECTOR)
		obsolete
			"Create procedure with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (idx)
			item := make_inbounds_index_list_external (ptr.item, array.item)
		end

	make_inbounds_index_list_name (ptr: VALUE; idx: VALUE_VECTOR; name: TWINE)
		obsolete
			"Create procedure with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (idx)
			item := make_inbounds_index_list_name_external (ptr.item, array.item, name.item)
		end

feature {NONE} -- Externals

	make_index_list_external (ptr: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::Create ((llvm::Value *)$ptr, *((llvm::ArrayRef <llvm::Value *> *) $idx));
			]"
		end

	make_index_list_name_external (ptr: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::Create ((llvm::Value *)$ptr, *((llvm::ArrayRef <llvm::Value *> *) $idx), *((llvm::Twine *)$name));
			]"
		end

	make_inbounds_index_list_external (ptr: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::CreateInBounds ((llvm::Value *)$ptr,  *((llvm::ArrayRef <llvm::Value *> *) $idx));
			]"
		end

	make_inbounds_index_list_name_external (ptr: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%", <vector>"
		alias
			"[
				return llvm::GetElementPtrInst::CreateInBounds ((llvm::Value *)$ptr,  *((llvm::ArrayRef <llvm::Value *> *) $idx), *((llvm::Twine *)$name));
			]"
		end
end
