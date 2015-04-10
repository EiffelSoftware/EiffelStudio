note
	description: "Summary description for {UNSIGNED_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNSIGNED_VECTOR

create

	make

feature {NONE}

	make
		do
			item := make_external
		end

feature

	push_back (v: NATURAL_32)
		do
			push_back_external (item, v)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	push_back_external (item_a: POINTER; v: NATURAL_32)
		external
			"C++ inline use <vector>"
		alias
			"[
				((std::vector <unsigned> *)$item_a)->push_back ($v);
			]"
		end

	make_external: POINTER
		external
			"C++ inline use <vector>"
		alias
			"[
				return new std::vector <unsigned>;
			]"
		end
end
