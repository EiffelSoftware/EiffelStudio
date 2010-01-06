
class TEST
inherit	
	TEST1 
		redefine
			value
		end
create
	make

feature
	
	value (n: INTEGER): INTEGER
		do
			Result := 2 * n
		end

end
