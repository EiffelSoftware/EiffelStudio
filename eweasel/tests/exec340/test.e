class TEST

create
	make

feature
	
	make
		local
			i: INTEGER_REF
		do
			create i
			(i + 1).do_nothing
		end

end
