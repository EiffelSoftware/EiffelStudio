
class TEST
inherit
	TEST1
		rename 
		       value as weasel 
		select
			weasel
		end
	TEST1
create
        make

feature
	make
		do
			print (value); io.new_line
			print (weasel); io.new_line
		end
end

