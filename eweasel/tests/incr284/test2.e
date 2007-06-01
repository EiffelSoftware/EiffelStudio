
class TEST2 [G]
 
create
	make, default_create
 
feature
 
	make is
		do
			print (value)
		end
 
	value: BOOLEAN
		do
			Result := a /= Void or else b /= Void
		end

	a: STRING

	b: STRING

end