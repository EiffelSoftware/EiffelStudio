note
	description: "Summary description for {TRIPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRIPLE

create

	make_from_string,
	host_triple

feature {NONE}

	make_from_string (str: STRING)
		local
			c_str: C_STRING
		do
			create c_str.make (str)
			item := ctor_string (c_str.item)
		end

	host_triple
		local
			host_c_str: C_STRING
		do
			create host_c_str.make_by_pointer (host_triple_external)
			item := ctor_string (host_c_str.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	host_triple_external: POINTER
		external
			"C++ inline use %"llvm/System/Host.h%""
		alias
			"[
				return (EIF_POINTER)llvm::sys::getHostTriple ().c_str ();		
			]"
		end

	ctor: POINTER
		external
			"C++ inline use %"llvm/ADT/Triple.h%""
		alias
			"[
				return new llvm::Triple;
			]"
		end

	ctor_string (string: POINTER): POINTER
		external
			"C++ inline use %"llvm/ADT/Triple.h%""
		alias
			"[
				std::string str ((const char *)$string);
				
				return new llvm::Triple (str);
			]"
		end
end
