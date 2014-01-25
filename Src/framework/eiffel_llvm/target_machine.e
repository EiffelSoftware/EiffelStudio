note
	description: "Summary description for {TARGET_MACHINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_MACHINE

create

	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	get_target_data: TARGET_DATA
		do
			create Result.make_from_pointer (get_target_data_external (item))
		end

	add_passes_to_emit_file (manager: PASS_MANAGER_BASE; output: FORMATTED_RAW_OSTREAM; file_type: INTEGER_64; optimization_type: INTEGER_64; disable_verify: BOOLEAN)
		local
			failure: BOOLEAN
		do
			failure := add_passes_to_emit_file_external (item, manager.item, output.item, file_type, optimization_type, disable_verify)
			if failure then
				(create {EXCEPTION}).raise
			end
		end

feature

	item: POINTER

feature {NONE}

	get_target_data_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetMachine.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::TargetMachine *)$item_a)->getTargetData ();		
			]"
		end

	add_passes_to_emit_file_external (item_a: POINTER; manager: POINTER; output: POINTER; file_type: INTEGER_64; optimization_type: INTEGER_64; disable_verify: BOOLEAN): BOOLEAN
		external
			"C++ inline use %"llvm/Target/TargetMachine.h%", %"llvm/PassManager.h%", %"llvm/Support/FormattedStream.h%""
		alias
			"[
				return ((llvm::TargetMachine *)$item_a)->addPassesToEmitFile (*((llvm::PassManagerBase *)$manager), *((llvm::formatted_raw_ostream *)$output), (llvm::TargetMachine::CodeGenFileType)$file_type, (llvm::CodeGenOpt::Level)$optimization_type, $disable_verify);
			]"
		end
end
