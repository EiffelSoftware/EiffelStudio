note
	description: "Help to encode sql queries, to prevent sql injections."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "SQL server injection", "src=http://blogs.msdn.com/b/raulga/archive/2007/01/04/dynamic-sql-sql-injection.aspx", "protocol=url"
expanded class
	DATABASE_SQL_SERVER_ENCODER

inherit

	SHARED_LOGGER

feature -- Escape SQL input

	encode (a_string:READABLE_STRING_GENERAL): READABLE_STRING_32
			-- Escape single quote (') and braces ([,]).
		local
			l_string: STRING_32
		do
			l_string := a_string.twin
			if not l_string.is_empty then
				l_string.replace_substring_all ("[", "[[")
				l_string.replace_substring_all ("]", "]]")
				if l_string.index_of ('%'', 1) > 0 then
					l_string.replace_substring ("[", 1, l_string.index_of ('%'', 1))
				end
				if l_string.last_index_of ('%'', l_string.count) > 0 then
					l_string.replace_substring ("]", l_string.last_index_of ('%'', l_string.count), l_string.count)
				end
			end
			Result := l_string
		end
end
