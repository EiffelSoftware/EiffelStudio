
class TEST1 [G]
inherit
	TEST2 [G]
		redefine
			try 
		end

feature
	try
		do
			print ({like {G}.default}); io.new_line
		end

end

