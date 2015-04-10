note
	description: "Summary description for {FUNCTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_L

inherit
	GLOBAL_VALUE

	DEBUG_OUTPUT

create

	make,
	make_name,
	make_from_pointer,
	cast_from

feature {NONE}

	make (ty: FUNCTION_TYPE; linkage: INTEGER_32)
		do
			item := make_external (ty.item, linkage)
		end

	make_name (ty: FUNCTION_TYPE; linkage: INTEGER_32; n: TWINE)
		do
			item := make_name_external (ty.item, linkage, n.item)
		end

	cast_from (v: VALUE)
		require
			v.class_of_function
		do
			item := v.item
		end

feature

	add_fn_attr (n: NATURAL_32)
		do
			check signature_changed: False end
--			add_fn_attr_external (item, n)
		end

	add_attribute (i: NATURAL_32; n: NATURAL_32)
		do
			check signature_changed: False end
--			add_attribute_external (item, i, n)
		end

	argument_list_push_back (v: ARGUMENT)
		do
			argument_list_push_back_external (item, v.item)
		end

	basic_block_list_push_back (v: BASIC_BLOCK)
		do
			basic_block_list_push_back_external (item, v.item)
		end

	get_function_type: FUNCTION_TYPE
		do
			create Result.make_from_pointer (get_function_type_external (item))
		end

	fill_with_arguments (target: ARGUMENT_VECTOR)
		do
			fill_with_arguments_external (item, target.item)
		end

	is_declaration: BOOLEAN
		do
			Result := is_declaration_external (item)
		end

feature

	debug_output: STRING_8
		do
			Result := get_function_type.get_description.string
		end

feature {NONE} -- Externals

	is_declaration_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				return ((llvm::Function *)$item_a)->isDeclaration ();
			]"
		end

	fill_with_arguments_external (item_a: POINTER; target: POINTER)
		external
			"C++ inline use <vector>, %"llvm/IR/Function.h%""
		alias
			"[
				for (llvm::Function::ArgumentListType::iterator i = ((llvm::Function *)$item_a)->getArgumentList ().begin (); i != ((llvm::Function *)$item_a)->getArgumentList ().end (); i++)
				{
					((std::vector <llvm::Argument *> *)$target)->push_back (&(*i));
				}
			]"
		end

	get_function_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::Function *)$item_a)->getFunctionType ();
			]"
		end

	argument_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				((llvm::Function *)$item_a)->getArgumentList ().push_back ((llvm::Argument *)$v);
			]"
		end

	make_external (ty: POINTER; linkage: INTEGER_32): POINTER
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				return llvm::Function::Create ((llvm::FunctionType *)$ty, (llvm::GlobalValue::LinkageTypes)$linkage);
			]"
		end

	make_name_external (ty: POINTER; linkage: INTEGER_32; n: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				return llvm::Function::Create ((llvm::FunctionType *)$ty, (llvm::GlobalValue::LinkageTypes)$linkage, *((llvm::Twine *)$n));
			]"
		end

	basic_block_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				((llvm::Function *)$item_a)->getBasicBlockList ().push_back ((llvm::BasicBlock *)$v);
			]"
		end

--	add_attribute_external (item_a: POINTER; i: NATURAL_32; n: NATURAL_32)
--		external
--			"C++ inline use %"llvm/IR/Function.h%""
--		alias
--			"[
--				((llvm::Function *)$item_a)->addAttribute ($i, $n);
--			]"
--		end

--	add_fn_attr_external (item_a: POINTER; n: NATURAL_32)
--		external
--			"C++ inline use %"llvm/IR/Function.h%""
--		alias
--			"[
--				((llvm::Function *)$item_a)->addFnAttr ($n)
--			]"
--		end
end
