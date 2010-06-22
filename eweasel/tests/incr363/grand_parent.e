
class GRAND_PARENT

create
	make
feature
	
	make
		do
			create a
			print (a.generating_type); io.new_line
		end

	a: like {TEST1 [like {like Current}.b]}.default
	
	b: $(ATTRIBUTE_TYPE)
end
