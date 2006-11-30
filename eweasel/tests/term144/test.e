
class TEST
create
	make

feature {NONE}

	make is
		do
			inspect 1
			when {TEST}.weasel then
				print ("1")
			end
		end

feature

	weasel is
		do
		end

end
