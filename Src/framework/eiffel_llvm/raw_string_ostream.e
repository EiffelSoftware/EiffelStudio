note
	description: "Summary description for {RAW_STRING_OSTREAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_STRING_OSTREAM

inherit
	RAW_OSTREAM

create

	make_from_string,
	make

feature {NONE}

	make_from_string (string_a: CPP_STRING)
		do
			cpp_string := string_a
			item := default_pointer
			item := ctor_string (cpp_string.item)
		end

	make
		do
			make_from_string (create {CPP_STRING}.make)
		end

feature

	string: STRING
		do
			Result := cpp_string.string
		end

feature {NONE} -- Implementation

	cpp_string: CPP_STRING

feature {NONE} -- Externals

	ctor_string (string_a: POINTER): POINTER
		external
			"C++ inline use <llvm/Support/raw_ostream.h>"
		alias
			"[
				return new llvm::raw_string_ostream (*((std::string *)$string_a)); 
			]"
		end
end
