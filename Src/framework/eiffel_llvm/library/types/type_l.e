note
	description: "Summary description for {TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_L

inherit

	ANY
		rename
			print as any_print
		end

	DEBUG_OUTPUT
		rename
			print as any_print
		end

create

	make_from_pointer,
	make_void,
	make_double,
	make_float,
	make_metadata

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make_void (ctx: LLVM_CONTEXT)
		do
			item := make_void_external (ctx.item)
		end

	make_double (ctx: LLVM_CONTEXT)
		do
			item := make_double_external (ctx.item)
		end

	make_float (ctx: LLVM_CONTEXT)
		do
			item := make_float_external (ctx.item)
		end

	make_metadata (ctx: LLVM_CONTEXT)
		do
			item := make_metadata_external (ctx.item)
		end

feature

	get_description: CPP_STRING
		do
			check unresolved_error: False end
			create Result.make
--			get_description_external (item, Result.item)
		end

	print (o: RAW_OSTREAM)
		do
			check unresolved_error: False end
--			print_external (item, o.item)
		end

	is_pointer_ty: BOOLEAN
		do
			Result := is_pointer_ty_external (item)
		end

	is_double_ty: BOOLEAN
		do
			Result := is_double_ty_external (item)
		end

	is_float_ty: BOOLEAN
		do
			Result := is_float_ty_external (item)
		end

	is_struct_ty: BOOLEAN
		do
			Result := is_struct_ty_external (item)
		end

	is_array_ty: BOOLEAN
		do
			Result := is_array_ty_external (item)
		end

	is_vector_ty: BOOLEAN
		do
			Result := is_vector_ty_external (item)
		end

	is_integer_ty: BOOLEAN
		do
			Result := is_integer_ty_external (item)
		end

--	is_abstract: BOOLEAN
--		do
--			Result := is_abstract_external (item)
--		end

	get_type_id: INTEGER_32
		do
			Result := get_type_id_external (item)
		end

feature -- Casting

--	cast_to_opaque_type: OPAQUE_TYPE
--		do
--			create Result.make_from_pointer (cast_to_opaque_type_external (item))
--		end

	cast_to_integer_type: INTEGER_TYPE
		do
			create Result.make_from_pointer (cast_to_integer_type_external (item))
		end

	cast_to_pointer_type: POINTER_TYPE
		do
			create Result.make_from_pointer (cast_to_pointer_type_external (item))
		end

	cast_to_function_type: FUNCTION_TYPE
		do
			create Result.make_from_pointer (cast_to_function_type_external (item))
		end

	cast_to_struct_type: STRUCT_TYPE
		do
			create Result.make_from_pointer (cast_to_struct_type_external (item))
		end

feature

	debug_output: STRING_8
		do
			Result := get_description.string
		end

feature

	item: POINTER

feature -- Casting queries

--	get_description_external (item_a: POINTER; target: POINTER)
--		external
--			"C++ inline use %"llvm/IR/Type.h%", <llvm/Support/raw_ostream.h>"
--		alias
--			"[
--				std::string l_result;
--				llvm::raw_string_ostream Tmp(l_result);
--				Tmp << *((llvm::Type *) $item_a);	
--				((std::string *)$target)->assign (Tmp.str());
--			]"
--		end

--	print_external (item_a: POINTER; o: POINTER)
--		external
--			"C++ inline use %"llvm/IR/Type.h%", %"llvm/Support/raw_ostream.h%""
--		alias
--			"[
--				return ((llvm::Type *)$item_a)->print (*((llvm::raw_ostream *)$o));
--			]"
--		end

	is_pointer_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isPointerTy ();
			]"
		end

	is_double_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isDoubleTy ();
			]"
		end

	is_float_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isFloatTy ();
			]"
		end

	is_integer_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isIntegerTy ();
			]"
		end

	is_vector_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isVectorTy ();
			]"
		end

	is_array_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isArrayTy ();
			]"
		end

	is_struct_ty_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->isStructTy ();
			]"
		end

--	is_abstract_external (item_a: POINTER): BOOLEAN
--		external
--			"C++ inline use %"llvm/IR/Type.h%""
--		alias
--			"[
--				return ((llvm::Type *)$item_a)->isAbstract ();
--			]"
--		end

	cast_to_function_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%", %"llvm/Support/Casting.h%""
		alias
			"[
				return llvm::cast <llvm::FunctionType *> ((llvm::Type *)$item_a);
			]"
		end

	cast_to_pointer_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%", %"llvm/Support/Casting.h%""
		alias
			"[
				return llvm::cast <llvm::PointerType *> ((llvm::Type *)$item_a);
			]"
		end

	cast_to_integer_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%", %"llvm/Support/Casting.h%""
		alias
			"[
				return llvm::cast <llvm::IntegerType *> ((llvm::Type *)$item_a);
			]"
		end

--	cast_to_opaque_type_external (item_a: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/IR/DerivedTypes.h%", %"llvm/Support/Casting.h%""
--		alias
--			"[
--				return llvm::cast <llvm::OpaqueType *> ((llvm::Type *)$item_a);
--			]"
--		end

	cast_to_struct_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%", %"llvm/Support/Casting.h%""
		alias
			"[
				return llvm::cast <llvm::StructType *> ((llvm::Type *)$item_a);
			]"
		end

	make_float_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getFloatTy (*((llvm::LLVMContext *)$ctx));
			]"
		end

	make_double_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getDoubleTy (*((llvm::LLVMContext *)$ctx));
			]"
		end

	classof_integer_type: BOOLEAN
		do
			Result := classof_integer_type_external (item)
		end

	classof_vector_type: BOOLEAN
		do
			Result := classof_vector_type_external (item)
		end

feature {NONE} -- Externals

	classof_vector_type_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return llvm::VectorType::classof ((llvm::Type *)$item_a);
			]"
		end

	get_type_id_external (item_a: POINTER): INTEGER_32
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::Type *)$item_a)->getTypeID ();
			]"
		end

	classof_integer_type_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return llvm::IntegerType::classof ((llvm::Type *)$item_a);
			]"
		end

	make_void_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getVoidTy (*((llvm::LLVMContext *)$ctx));
			]"
		end

	make_metadata_external (ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getMetadataTy (*((llvm::LLVMContext *)$ctx));
			]"
		end
end
