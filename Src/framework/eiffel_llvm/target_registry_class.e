note
	description: "Summary description for {TARGET_REGISTRY_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	TARGET_REGISTRY_CLASS

feature

	initialize_all_targets
		do
			initialize_all_targets_external
		end

	initialize_all_asm_printers
		do
			initialize_all_asm_printers_external
		end

	initialize_all_asm_parsers
		do
			initialize_all_asm_parsers_external
		end

	lookup_target (triple: STRING): TARGET
		local
			error_pointer: POINTER
			error_string: C_STRING
			error: STRING
			triple_c_string: C_STRING
			result_pointer: POINTER
		do
			create triple_c_string.make (triple)
			result_pointer := lookup_target_external (triple_c_string.item, $error_pointer)
			if result_pointer = default_pointer then
				create error_string.own_from_pointer (error_pointer)
				error := error_string.string;
				(create {EXCEPTION}).raise
			else
				create Result.make_from_pointer (result_pointer)
			end
		end

	begin: TARGET_REGISTRY_ITERATOR
		do
			create Result
			begin_external (Result.item)
		end

	end_item: TARGET_REGISTRY_ITERATOR
		do
			create Result
			end_external (Result.item)
		end

feature {NONE} -- Externals

	initialize_all_asm_parsers_external
		external
			"C++ inline use %"llvm/Target/TargetSelect.h%""
		alias
			"[
				llvm::InitializeAllAsmParsers ();
			]"
		end

	initialize_all_asm_printers_external
		external
			"C++ inline use %"llvm/Target/TargetSelect.h%""
		alias
			"[
				llvm::InitializeAllAsmPrinters ();
			]"
		end

	initialize_all_targets_external
		external
			"C++ inline use %"llvm/Target/TargetSelect.h%""
		alias
			"[
				llvm::InitializeAllTargets ();
			]"
		end

	begin_external (target_a: POINTER)
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				*((llvm::TargetRegistry::iterator *)$target_a) = llvm::TargetRegistry::begin ();
			]"
		end


	end_external (target_a: POINTER)
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				*((llvm::TargetRegistry::iterator *)$target_a) = llvm::TargetRegistry::end ();
			]"
		end

	lookup_target_external (triple: POINTER; error: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				std::string triple ((const char *)$triple);
				std::string error;
				size_t length;
				char * error_copy;
				const llvm::Target * result;
				
				result = llvm::TargetRegistry::lookupTarget (triple, error);
				length = error.length ();
				if (length != 0)
				{
					error_copy = (char *)malloc (length + 1);
					strncpy (error_copy, error.c_str (), length);
				}
				else
				{
					error_copy = 0;
				}
				*((void **)$error) = error_copy;
				
				return (EIF_POINTER)result;
			]"
		end
end
