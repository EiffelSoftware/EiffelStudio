
class PARENT

feature
	
	try
		local
			s: STRING
		do
			create {like x.out} s.make (0)
			print (s.generating_type); io.new_line
		end

	x: PARENT

end
