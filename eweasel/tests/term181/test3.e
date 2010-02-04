
class TEST3 [G -> TEST1 [ANY] create default_create end]
	
create
	default_create
feature
	hamster
		do
			create x.default_create
		end
			
	x: G
end
