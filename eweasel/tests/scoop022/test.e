
class TEST
create
       make
feature

	make
		do
			create x
			try (x)
		end

	try (a: like x)
		do
			try2 (a.value)
	    	end

	try2 (a: TEST2)
	    	do
	    	end

	x: separate TEST1

end

