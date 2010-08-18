
deferred class TEST1 [G -> TEST3 create default_create end]
feature
	try
		do
			io.new_line;
                        (agent stoat).call ([(create {G}.default_create).min_value, {G}.max_value])

		end

        stoat (a, b: INTEGER)
                deferred
                end

invariant
	correct: ((agent : G do end).item ([])) = 0
end
