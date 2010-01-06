
class TEST
inherit
	TEST1
		redefine
			s
		end

create
	make
feature
	make 
		local
			x: TEST1
		do
			print (s); io.new_line
			create x
			print (x.s); io.new_line
		end
   
     s: STRING
     	attribute
		Result := precursor
	end

end
