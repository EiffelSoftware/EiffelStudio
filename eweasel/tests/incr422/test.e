
expanded class TEST
create
        make, default_create

feature
	make
		do
			create x
			try (x)
		end

	x: separate TEST2

	$ATTRIBUTE

	try (a: like x)
	    do
		print (a.y); io.new_line
	    end
end

