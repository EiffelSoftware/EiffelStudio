indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALE

creation
	make
	
feature --Initialization

	locale: STRING
	multb_codepage: INTEGER

	make is
			-- 
		local
			loc_ptr: POINTER
		do
			loc_ptr := set_locale(0, "chinese")
			--create locale.make_from_c(loc_ptr)
			multb_codepage := set_multb_char_codepage(950)
		end


	set_locale (category: INTEGER; loc: STRING): POINTER is
		-- 
		local
			l_string: ANY
		once
			l_string := loc.to_c
			Result := cwel_set_locale(category, $l_string)
		end
	
	set_multb_char_codepage(codepage: INTEGER): INTEGER is
			-- 
		once
			Result := cwel_set_multb_char_codepage(codepage)
		end


feature {NONE} --externals

	cwel_set_locale(category: INTEGER; loc: POINTER):POINTER is
		external
			"C"
		end

	cwel_set_multb_char_codepage(codepage: INTEGER): INTEGER is
			-- 
		external
			"C"
		end





end -- class LOCALE
