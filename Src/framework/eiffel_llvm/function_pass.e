note
	description: "Summary description for {FUNCTION_PASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_PASS

inherit

	PASS

create

	verifier_pass

feature {NONE}

	verifier_pass
		do
			item := create_verifier_pass_external
		end

feature {NONE} -- Externals

	create_verifier_pass_external: POINTER
		external
			"C++ inline use %"llvm/Analysis/Verifier.h%""
		alias
			"[
				return llvm::createVerifierPass ();
			]"
		end
end
