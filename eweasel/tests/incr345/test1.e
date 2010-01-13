
deferred class TEST1 [G]
feature
	try
		do
		end

invariant
	correct: ((agent : G do end).item ([])) = Void
end
