
deferred class TEST1 -- [G]
feature
	try
		do
		end

invariant
	correct: ((agent : TEST3 do end).item ([])) = Void
end
