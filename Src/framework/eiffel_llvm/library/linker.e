note
	description: "Summary description for {LINKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINKER

create

	make

feature {NONE}

	make (module: MODULE)
		do
			item := make_external (module.item)
		end

feature

	get_module: MODULE
		do
			create Result.make_from_pointer (get_module_external (item))
		end

	link_in_module (src: MODULE)
		local
			failed: BOOLEAN
			e: DEVELOPER_EXCEPTION
			str_pointer: POINTER
			str: C_STRING
		do
			failed := link_in_module_external (item, src.item, $str_pointer)
			create str.own_from_pointer (str_pointer)
			if failed then
				create e
				e.set_description ("Error Linking")
				e.raise
			end
		end

feature

	item: POINTER

feature {NONE} -- Externals

	link_in_module_external (item_a: POINTER; src: POINTER; message_target: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Linker.h%", <string>"
		alias
			"[
				bool result;
				std::string message;
				char * str;
				size_t message_length;
				
				result = ((llvm::Linker *)$item_a)->linkInModule ((llvm::Module *)$src, &message);
				message_length = message.length () + 1;
				str = (char *)malloc (message_length);
				strncpy (str, message.c_str (), message_length);
				*((char **)$message_target) = str;
				
				return result;
			]"
		end

	get_module_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Linker.h%""
		alias
			"[
				return ((llvm::Linker *)$item_a)->getModule ();
			]"
		end

	make_external (module: POINTER): POINTER
		external
			"C++ inline use %"llvm/Linker.h%", <llvm/IR/LLVMContext.h>"
		alias
			"[
				return new llvm::Linker ( (llvm::Module *) $module);
			]"
		end
end
