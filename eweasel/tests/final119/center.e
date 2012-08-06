
class CENTER

feature

	x: INTEGER
		do
			Result := internal_x
		end
		
	set_x (a_x: like x)
		do
			internal_x := a_x
		end
		
	internal_x: like x

end
