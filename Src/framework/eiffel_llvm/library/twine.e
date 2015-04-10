note
	description: "Summary description for {TWINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWINE

create

	make_from_pointer,
	make,
	make_string,
	make_readable_string_general

convert
	make_readable_string_general ({READABLE_STRING_GENERAL}),
	make_string ({STRING})

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make
		do
			item := make_external
		end

	make_string (str_a: STRING)
		do
			make_readable_string_general (str_a)
		end

	make_readable_string_general (str_a: READABLE_STRING_GENERAL)
		local
			str_c_string: C_STRING
		do
			create str_c_string.make (str_a)
			item := make_string_external (str_c_string.item)
		end

feature

	str: STRING_8
		local
			result_string: C_STRING
		do
			create result_string.own_from_pointer (str_external (item))
			Result := result_string.string
		end

	item: POINTER

feature {NONE} -- Externals

	str_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/ADT/Twine.h%""
		alias
			"[
				std::string result_str;
				size_t result_size;
				char * result;

				result_str = ((llvm::Twine *)$item_a)->str ();
				result_size = result_str.length () + 1;
				result = (char *)malloc (result_size);
				strncpy (result, result_str.c_str (), result_size);
				return result;
			]"
		end

	make_string_external (str_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/ADT/Twine.h%""
		alias
			"[
				return new llvm::Twine ((const char *)$str_a);
			]"
		end

	make_external: POINTER
		external
			"C++ inline use %"llvm/ADT/Twine.h%""
		alias
			"[
				return new llvm::Twine;
			]"
		end
end
