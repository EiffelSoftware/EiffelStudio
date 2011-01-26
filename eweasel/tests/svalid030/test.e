
class TEST
inherit
	-- Note: switching order of inheritance clauses fixes VGCC(6) error
	$(PARENTS)
create
	make
feature
	
	make
		do
			print (y.generating_type); io.new_line
		end

end
