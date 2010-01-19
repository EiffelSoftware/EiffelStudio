
class TEST
inherit
	EXCEPTION_MANAGER
create
	make
feature
	
	make is
		do
		       create x
		       print (x.value.generating_type); io.new_line
		       print (x.value.a); io.new_line
		end

	x: TEST2

end
