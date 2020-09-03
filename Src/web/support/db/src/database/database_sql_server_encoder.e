note
	description: "Help to encode sql queries, to prevent sql injections."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "SQL server injection", "src=http://blogs.msdn.com/b/raulga/archive/2007/01/04/dynamic-sql-sql-injection.aspx", "protocol=url"
expanded class
	DATABASE_SQL_SERVER_ENCODER

feature -- Escape SQL input

	encoded_string (a_string: READABLE_STRING_GENERAL): STRING_32
			-- Escape single quote (') and braces ([,]).
		do
			create Result.make_from_string_general (a_string)
			if not Result.is_empty then
				Result.replace_substring_all ({STRING_32} "[", {STRING_32} "[[")
				Result.replace_substring_all ({STRING_32} "]", {STRING_32} "]]")
				if Result.index_of ('%'', 1) > 0 then
					Result.replace_substring ({STRING_32} "[", 1, Result.index_of ('%'', 1))
				end
				if Result.last_index_of ('%'', Result.count) > 0 then
					Result.replace_substring ({STRING_32} "]", Result.last_index_of ('%'', Result.count), Result.count)
				end
			end
		end
end
