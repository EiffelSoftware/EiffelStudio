indexing
	description: "Code sets, only two byte and four byte encoding codeset are listed. The rest are granted as one byte encoding."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SETS

feature -- Access

	two_byte_codesets: HASH_TABLE [STRING, STRING] is
		once
			create Result.make (20)

			Result.put ("UCS-2", "UCS-2")
			Result.put ("ISO-10646-UCS-2", "ISO-10646-UCS-2") -- Alias
			Result.put ("csUnicode", "csUnicode") -- Alias

			Result.put ("UCS-2BE", "UCS-2BE")
			Result.put ("UNICODEBIG", "UNICODEBIG") -- Alias
			Result.put ("UNICODE-1-1", "UNICODE-1-1") -- Alias
			Result.put ("csUnicode11", "csUnicode11") -- Alias

			Result.put ("UCS-2LE", "UCS-2LE")
			Result.put ("UNICODELITTLE", "UNICODELITTLE") -- Alias

			Result.put ("UTF-16", "UTF-16")
			Result.put ("UTF-16BE", "UTF-16BE")
			Result.put ("UTF-16LE", "UTF-16LE")

			Result.put ("UCS-2-INTERNAL", "UCS-2-INTERNAL")
			Result.put ("UCS-2-SWAPPED", "UCS-2-SWAPPED")

			Result.put ("JAVA", "JAVA")
		end

	four_byte_codesets: HASH_TABLE [STRING, STRING] is
		once
			create Result.make (10)
			Result.put ("UCS-4", "UCS-4")
			Result.put ("ISO-10646-UCS-4", "ISO-10646-UCS-4") -- Alias
			Result.put ("csUCS4", "csUCS4") -- Alias

			Result.put ("UCS-4BE", "UCS-4BE")
			Result.put ("UCS-4LE", "UCS-4LE")

			Result.put ("UTF-32", "UTF-32")
			Result.put ("UTF-32BE", "UTF-32BE")
			Result.put ("UTF-32LE", "UTF-32LE")

			Result.put ("UCS-4-INTERNAL", "UCS-4-INTERNAL")
			Result.put ("UCS-4-SWAPPED", "UCS-4-SWAPPED")
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
