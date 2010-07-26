
class TEST2 [G -> {TEST3 rename default_create as weasel end, ANY} create default_create end]
feature
	weasel: like {G}.default
		do
			create Result
		end
	
end
