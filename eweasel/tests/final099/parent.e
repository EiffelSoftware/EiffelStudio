
deferred class PARENT

feature

	make
		do
			position := 0xDEADBEEF
		end

feature

	name: STRING

	index: INTEGER
		deferred
		end

	position: INTEGER

	item: CHARACTER

end
