
class TEST
inherit
	EXCEPTION_MANAGER
create
	make
feature
	
	make is
		local
			tried: BOOLEAN
		do
			if not tried then
			       print (x.value); io.new_line
			else
				print (last_exception.meaning); io.new_line
			end
		rescue
			tried := True
			retry
		end

	x: TEST2

end
