class
	TEST

obsolete
	$OC "Bad use of type qualifier in obsolete message of a class."

create
        make

feature

	make
		do
			foo
		end

	foo
		obsolete
			$OF "Bad use of type qualifier in obsolete message of a feature."
		do
		end

end

