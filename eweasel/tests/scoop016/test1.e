
class TEST1
feature
	
	try (a: separate TEST2 t: separate TEST)
		do
			t.try3 (t.x, a)
		end

end

