
class TEST2

feature

	try
		do
			print (is_valid); io.new_line
			print ((agent {like Current}.is_valid).item ([Current])); io.new_line
		end

	is_valid: INTEGER
		once
		     Result := 29
		end

end
