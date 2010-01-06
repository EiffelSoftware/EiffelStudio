
class TEST1 [reference G -> PARENT]
feature
	modify
		do
			s := Void
			if s = Void then
				print ("s is Void in TEST1%N")
			end
		end

	s: G
end
