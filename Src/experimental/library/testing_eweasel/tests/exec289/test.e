class TEST
create
	make

feature

	make is
		do
			s := ""
		end

	is_successful: BOOLEAN
		do
			Result := s.is_empty
		end

	s: STRING

invariant
	success: is_successful

end
