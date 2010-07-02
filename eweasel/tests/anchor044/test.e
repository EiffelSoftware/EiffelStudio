
class TEST
create
	make
feature
	make
		do
			create t
			t.try
		end 
    
	t: CHILD [TEST3]

end
