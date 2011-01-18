class PRODUCER

create
	make

feature

	make
		do
			has_something := False
			value := 0
		end

	has_something: BOOLEAN

	make_something
		require
			has_nothing: not has_something
		do
			has_something := True
			value := value + 1
			io.put_string ("Produced: " + value.out + "%N")
		end

	get_something: INTEGER
		require
			is_ready: has_something
		do
			has_something := False
			Result := value
		end

feature {NONE}

	value: INTEGER

end
