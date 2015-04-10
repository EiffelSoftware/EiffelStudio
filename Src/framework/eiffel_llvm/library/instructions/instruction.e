note
	description: "Summary description for {INSTRUCTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSTRUCTION

inherit

	USER

create

	make_from_pointer

feature

	set_metadata (kind_id: NATURAL_32; node: MD_NODE)
		do
			set_metadata_external (item, kind_id, node.item)
		end

	set_metadata_string (kind: STRING_8; node: MD_NODE)
		local
			kind_c: C_STRING
		do
			create kind_c.make (kind)
			set_metadata_string_external (item, kind_c.item, node.item)
		end

--	md_dbg: NATURAL_32
--		do
--			Result := md_dbg_external
--		end

feature {NONE} -- Externals

--	md_dbg_external: NATURAL_32
--		external
--			"C++ inline use %"llvm/LLVMContext.h%""
--		alias
--			"[
--				return llvm::LLVMContext::MD_dbg;
--			]"
--		end

	set_metadata_string_external (item_a: POINTER; kind: POINTER; node: POINTER)
		external
			"C++ inline use %"llvm/IR/Instruction.h%""
		alias
			"[
				((llvm::Instruction *)$item_a)->setMetadata ((const char *)$kind, (llvm::MDNode *)$node);
			]"
		end

	set_metadata_external (item_a: POINTER; kind_id: NATURAL_32; node: POINTER)
		external
			"C++ inline use %"llvm/IR/Instruction.h%""
		alias
			"[
				((llvm::Instruction *)$item_a)->setMetadata ($kind_id, (llvm::MDNode *)$node);
			]"
		end
end
