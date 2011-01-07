
class TEST
create
        make
feature
        make
                do
			print (x.generating_type); io.new_line
                end

	x: like {TEST2 [TEST3]}.y
		do
			create Result
		end

end
