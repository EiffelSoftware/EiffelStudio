
class GRAND_PARENT [G]

feature
	
	try
		do
			create {like a} a.make_empty
			print (a.generating_type); io.new_line
		end

	a: like {ARRAY [like b]}.default
	
	b: like Current

end
