
class TEST2

create
	default_create, make, make_from_boolean

convert
	make_from_boolean ({BOOLEAN})

feature

	make
		local
			x: like Current
		do
			create x
			x := True
		end
	
	make_from_boolean (b: BOOLEAN)
		do
		end
	
end

