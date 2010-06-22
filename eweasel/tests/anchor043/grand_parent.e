
class GRAND_PARENT [G]

feature
	
	try
		do
			create {like a} a.make (1, 2)
			print (a.generating_type); io.new_line
		end

	a: like {ARRAY [like b]}.default
	
	b: like Current

end
