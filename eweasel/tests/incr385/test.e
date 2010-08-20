
class TEST
inherit
	TEST1
create
	make
feature
	make
		local
			tried: BOOLEAN
		do
			if not tried then
				create x
				Current.x.try
			end
		rescue
			tried := True
			retry
		end 
    
	x: TEST1

end
