

class TEST
inherit
	TEST1

create
	make

feature

	make
		do
			print (Current.weasel);
			io.new_line
		end

end
