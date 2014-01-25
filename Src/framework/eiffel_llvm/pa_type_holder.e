note
	description: "Summary description for {PA_TYPE_HOLDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PA_TYPE_HOLDER

create

	make

feature {NONE}

	make (ty: TYPE_L)
		do
			item := make_external (ty.item)
		end

feature

	get: TYPE_L
		do
			create Result.make_from_pointer (get_external (item))
		end

feature

	item: POINTER

feature {NONE}

	get_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return ((llvm::PATypeHolder *)$item_a)->get ();
			]"
		end

	make_external (ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return new llvm::PATypeHolder ((const llvm::Type *)$ty);
			]"
		end
end
