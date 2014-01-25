note
	description: "Summary description for {SOURCE_MGR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOURCE_MGR

create

	make

feature {NONE}

	make
		do
			item := ctor_external
		end

feature

	add_new_source_buffer (f: MEMORY_BUFFER; include_loc: SM_LOC)
		do
			add_new_source_buffer_external (item, f.item, include_loc.item)
		end

	set_include_dirs (v: CPP_STRING_VECTOR)
		do
			set_include_dirs_external (item, v.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	set_include_dirs_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/Support/SourceMgr.h%", <vector>, <string>"
		alias
			"[
				((llvm::SourceMgr *)$item_a)->setIncludeDirs (*((std::vector <std::string> *)$v));
			]"
		end

	add_new_source_buffer_external (item_a: POINTER; f: POINTER; include_loc: POINTER)
		external
			"C++ inline use %"llvm/Support/SourceMgr.h%", %"llvm/Support/MemoryBuffer.h%""
		alias
			"[
				((llvm::SourceMgr *)$item_a)->AddNewSourceBuffer ((llvm::MemoryBuffer *)$f, *((llvm::SMLoc *)$include_loc));
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/Support/SourceMgr.h%""
		alias
			"[
				return new llvm::SourceMgr;
			]"
		end
end
