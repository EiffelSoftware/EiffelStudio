
class TEST2
inherit
	MEMORY
feature
	to_val1: STRING
		local
			s: STRING
			n: INTEGER
		once ("OBJECT")
			inspect n
			when 0 then
				Result := "Weasel"
				Result := s.as_upper
			when 1 then
				full_collect
				-- Result := s.as_upper
			-- when 2 then
				-- full_collect
			end
		rescue
			n := n + 1
			-- full_collect
			retry
		end

	val: DOUBLE

end
