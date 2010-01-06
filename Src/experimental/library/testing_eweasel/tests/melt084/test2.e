
expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end
	TEST1
		undefine
			default_create
		end

create
        default_create

feature

        default_create
                do
			print ("Starting%N")
			try
                end

end
