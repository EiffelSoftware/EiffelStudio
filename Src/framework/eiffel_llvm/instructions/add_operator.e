note
	description: "Summary description for {ADD_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_OPERATOR

inherit
	BINARY_OPERATOR
		rename
			make as make_binary,
			make_name as make_name_binary
		end

create

	make,
	make_name

feature {NONE}

	make (v1: VALUE; v2: VALUE)
		require
			v1.get_raw_type.classof_integer_type or v1.get_raw_type.classof_vector_type
			v2.get_raw_type.classof_integer_type or v2.get_raw_type.classof_vector_type
		do
			make_binary (v1, v2)
		end

	make_name (v1: VALUE; v2: VALUE; name: TWINE)
		require
			v1.get_raw_type.classof_integer_type or v1.get_raw_type.classof_vector_type
			v2.get_raw_type.classof_integer_type or v2.get_raw_type.classof_vector_type
		do
			make_name_binary (v1, v2, name)
		end

feature {NONE} -- Externals

	make_external (v1: POINTER; v2: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/InstrTypes.h%""
		alias
			"[
				return llvm::BinaryOperator::CreateAdd ((llvm::Value *)$v1, (llvm::Value *)$v2);
			]"
		end

	make_name_external (v1: POINTER; v2: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/InstrTypes.h%""
		alias
			"[
				return llvm::BinaryOperator::CreateAdd ((llvm::Value *)$v1, (llvm::Value *)$v2, *((llvm::Twine *)$name));
			]"
		end
end
