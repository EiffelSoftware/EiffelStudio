
deferred class PARENT

feature

	make
		do
			value := 0xDEADBEEF
		end

feature

	name: STRING

	index: INTEGER
		deferred
		end

	position: INTEGER
		do
			Result := value
		end

	value: INTEGER

	item: CHARACTER

end
