
class TEST
create
	make

feature {NONE}

	make is
		do
			io.put_string (s); io.new_line
		end

	s: STRING
		attribute
			Result := "Weasel"
		end

end
