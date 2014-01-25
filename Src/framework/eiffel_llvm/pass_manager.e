note
	description: "Summary description for {PASS_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PASS_MANAGER

inherit

	PASS_MANAGER_BASE
		undefine
			default_create
		end

create

	default_create

feature {NONE}

	default_create
		do
			item := ctor_external
		end

feature

	add (p: PASS)
		do
			add_external (item, p.item)
		end

	run (m: MODULE)
		do
			run_external (item, m.item)
		end

feature {NONE} -- Externals

	run_external (item_a: POINTER; module_a: POINTER)
		external
			"C++ inline use %"llvm/IR/PassManager.h%", %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::PassManager *)$item_a)->run (*(llvm::Module *)$module_a)
			]"
		end

	add_external (item_a: POINTER; pass_a: POINTER)
		external
			"C++ inline use %"llvm/IR/PassManager.h%", %"llvm/Pass.h%""
		alias
			"[
				((llvm::PassManager *)$item_a)->add ((llvm::Pass *)$pass_a);
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/IR/PassManager.h%""
		alias
			"[
				return new llvm::PassManager;
			]"
		end
end
