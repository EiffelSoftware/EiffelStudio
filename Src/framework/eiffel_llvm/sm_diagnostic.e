note
	description: "Summary description for {SM_DIAGNOSTIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SM_DIAGNOSTIC

inherit

	ANY
		redefine
			default_create
		end

create

	make_from_pointer,
	default_create

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	default_create
		do
			item := ctor_external
		end


feature

	item: POINTER

feature {NONE} -- Externals

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/Support/SourceMgr.h%""
		alias
			"[
				return new llvm::SMDiagnostic;
			]"
		end
end
