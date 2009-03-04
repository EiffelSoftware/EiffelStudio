
class TEST

create
	default_create, make, make_from_boolean

convert
	make_from_boolean ({ANY, BOOLEAN})

feature

	make
		local
			x: TEST
		do
			create x
			x := True
		end
	
	make_from_boolean (b: ANY)
		do
			print (b); io.new_line
			print (b.generating_type); io.new_line
		end
	
end

