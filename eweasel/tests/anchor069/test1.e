
class TEST1 [G -> TEST2 [TEST3]]
feature
	value: like {G}.a
		do
			create Result
		end
end

