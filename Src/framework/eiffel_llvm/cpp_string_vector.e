note
	description: "Summary description for {CPP_STRING_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPP_STRING_VECTOR

create

	make

feature {NONE}

	make
		do
			item := ctor_external
		end
		
feature

	push_back (v: CPP_STRING)
		do
			push_back_external (item, v.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use <vector>"
		alias
			"[
				((std::vector <std::string> *)$item_a)->push_back (*((std::string *)$v));	
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use <vector>"
		alias
			"[
				return new std::vector <std::string>;		
			]"
		end

end
