class
	TEST2 [G -> $CONSTRAINT]

inherit
	TEST1

create
	make

feature

	make
		do
			a := {$CONSTRAINT} "my_string"
		end

	a: ANY

end
