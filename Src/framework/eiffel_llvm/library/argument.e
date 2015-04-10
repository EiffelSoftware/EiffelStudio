note
	description: "Summary description for {ARGUMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT

inherit
	VALUE

create

	make,
	make_name,
	make_from_pointer

feature {NONE}

	make (ty: TYPE_L)
		do
			item := make_external (ty.item)
		end

	make_name (ty: TYPE_L; name: TWINE)
		do
			item := make_name_external (ty.item, name.item)
		end

feature {NONE}

	make_external (ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Argument.h%""
		alias
			"[
				return new llvm::Argument ((llvm::Type *)$ty);
			]"
		end

	make_name_external (ty: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Argument.h%""
		alias
			"[
				return new llvm::Argument ((llvm::Type *)$ty, *((llvm::Twine *)$name));
			]"
		end
end
