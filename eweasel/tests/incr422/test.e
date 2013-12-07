
expanded class TEST
inherit
	ANY
		redefine
			default_create
		end

create
        make, default_create

feature
	make, default_create
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

