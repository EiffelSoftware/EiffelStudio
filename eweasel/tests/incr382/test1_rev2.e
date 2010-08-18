
deferred class TEST1 [G -> INTEGER create default_create end]
feature
	try
		do
			io.new_line;
                        (agent stoat).call ([create {G}, {G}.max_value])

		end

        stoat (a, b: INTEGER)
                deferred
                end

invariant
	correct: ((agent : G do end).item ([])) = 0
end
