note
	description: "Summary description for {FORMATTED_RAW_OSTREAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMATTED_RAW_OSTREAM

inherit

	RAW_OSTREAM

create

	make_raw_ostream

feature {NONE}

	make_raw_ostream (stream: RAW_OSTREAM)
		do
			item := ctor_raw_ostream (stream.item)
		end

feature {NONE} -- Externals

	ctor_raw_ostream (stream: POINTER): POINTER
		external
			"C++ inline use %"llvm/Support/FormattedStream.h%""
		alias
			"[
				return new llvm::formatted_raw_ostream (*((llvm::raw_ostream *)$stream));
			]"
		end
end
