note
	description: "Summary description for {MODULE_VERIFICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MODULE_VERIFICATION

create

	make

feature {NONE}

	make (module: MODULE)
		local
			str: C_STRING
			str_pointer: POINTER
		do
			failed := verify_external (module.item, $str_pointer)
			create str.own_from_pointer (str_pointer)
			message := str.string
		end

feature

	failed: BOOLEAN
	message: STRING_8

feature {NONE} -- Externals

	verify_external (module: POINTER; message_target: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Analysis/Verifier.h%", <string>"
		alias
			"[
				bool result;
				std::string message;
				char * str;
				size_t message_length;
				
				result = verifyModule (*((llvm::Module *)$module), llvm::ReturnStatusAction, &message);
				message_length = message.length () + 1;
				str = (char *)malloc (message_length);
				strncpy (str, message.c_str (), message_length);
				*((char **)$message_target) = str;
				
				return result;
			]"
		end
end
