indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LANGUAGE_IDENTIFIERS
	
feature {NONE} -- Language Identifiers 

	identifiers: HASH_TABLE [INTEGER, STRING] is
			-- 
		once
			create Result.make(0)
			Result.extend (1033, "English (United States)")
			Result.extend (2057, "English (United Kingdom)")
			Result.extend (3076, "Chinese (Hong Kong)")
			Result.extend (1037, "Hebrew")
			Result.extend (2049, "Arabic (Iraq)")
			Result.extend (0x1004, "Chinese (Macau)")
			Result.extend (0x1404, "Chinese (Singapore)")
--			Result.extend (00000409, "English (United States)")
--			Result.extend (00000809, "English (United Kingdom)")
--			Result.extend (00000C04, "Chinese (Hong Kong)")
--			Result.extend (0000040D, "Hebrew")
--			Result.extend (00000801, "Arabic (Iraq)")
--			Result.extend (00001004, "Chinese (Macau)")
--			Result.extend (00001404, "Chinese (Singapore)")
		end
		

end -- class WEL_LANGUAGE_IDENTIFIERS
