class
	TEST

obsolete
	{STRING_32} "Bad use of type qualifier in obsolete message of a class."

create
        make

feature

	make
		do
			foo
		end

	foo
		obsolete
			{STRING_32} "Bad use of type qualifier in obsolete message of a feature."
		do
		end

end

