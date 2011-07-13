
class TEST2
feature
	
	try (a: separate TEST1 t: separate TEST)
		do
			t.try3 (a, t.y)
		end

end

