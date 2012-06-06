class
	TEST
inherit
	THREAD
		redefine
			make
		end

create
	make

feature

	make
		do
			Precursor
			io.put_string ("I'm here%N")
			exit
			io.put_string ("I should not be printed%N")
		end

	execute
		do
		end

end
