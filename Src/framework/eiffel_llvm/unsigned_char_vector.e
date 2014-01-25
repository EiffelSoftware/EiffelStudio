note
	description: "Summary description for {UNSIGNED_CHAR_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNSIGNED_CHAR_VECTOR

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

	count: NATURAL_32
		do
			Result := count_external (item)
		end

	front: POINTER
		do
			Result := front_external (item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	front_external (item_a: POINTER): POINTER
		external
			"C++ inline use <vector>"
		alias
			"[
				return &(((std::vector <unsigned char> *)$item_a)->front ());
			]"
		end

	count_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use <vector>"
		alias
			"[
				return ((std::vector <unsigned char> *)$item_a)->size ();
			]"
		end

	push_back_external (item_a: POINTER; v: NATURAL_32)
		external
			"C++ inline use <vector>"
		alias
			"[
				((std::vector <unsigned char> *)$item_a)->push_back ($v);
			]"
		end

	make_external: POINTER
		external
			"C++ inline use <vector>"
		alias
			"[
				return new std::vector <unsigned char>;
			]"
		end

end
