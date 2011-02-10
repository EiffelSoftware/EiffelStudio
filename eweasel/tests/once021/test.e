
class TEST
create
        make

feature
	make
		local
			b: TEST2
		do
			create b
			print (b.weasel); io.new_line
		end


end
