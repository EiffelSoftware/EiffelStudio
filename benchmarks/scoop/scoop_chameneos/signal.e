class SIGNAL

create make

feature
	count: INTEGER
	done: BOOLEAN

	make
		do
			count := 0
			done := False
		end

	signal
		do
			count := count + 1
			if count = 2 then
				done := True
			end
		end
end
