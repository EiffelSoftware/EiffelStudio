note
	description: "Summary description for {VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE

inherit
	REFACTORING_HELPER

create

	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	get_raw_type: TYPE_L
		do
			fixme ("The function getRawType isn't available any more. Check if getType does the same.")
			create Result.make_from_pointer (get_raw_type_external (item))
		end

	set_name (name: STRING_8)
		local
			name_l: TWINE
		do
			name_l := name
			set_name_external (item, name_l.item)
		end

	has_name: BOOLEAN
		do
			Result := has_name_external (item)
		end

	get_name: STRING_8
		local
			name: C_STRING
		do
			create name.own_from_pointer (get_name_external (item))
			Result := name.string
		end

feature

	item: POINTER

feature -- Casting queries

	class_of_function: BOOLEAN
		do
			Result := class_of_function_external (item)
		end

feature {NONE} -- Externals

	get_name_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Value.h%""
		alias
			"[
				std::string result_str;
				size_t result_size;
				char * result;
				
				result_str = ((llvm::Value *)$item_a)->getName ().str();
				result_size = result_str.length () + 1;
				result = (char *)malloc (result_size);
				strncpy (result, result_str.c_str (), result_size);
				return result;
			]"
		end

	set_name_external (item_a: POINTER; name: POINTER)
		external
			"C++ inline use %"llvm/IR/Value.h%""
		alias
			"[
				((llvm::Value *)$item_a)->setName (*((llvm::Twine *)$name));
			]"
		end

	has_name_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Value.h%""
		alias
			"[
				return ((llvm::Value *)$item_a)->hasName ();
			]"
		end

	get_raw_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Value.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::Value *)$item_a)->getType ();
			]"
		end

	class_of_function_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Function.h%", %"llvm/IR/Value.h%""
		alias
			"[
				return llvm::Function::classof ((llvm::Value *)$item_a);
			]"
		end

end
