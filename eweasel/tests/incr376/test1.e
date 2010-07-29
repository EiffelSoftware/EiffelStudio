
class TEST1 [G -> TEST2 create default_create end]
create
	make
feature
	make
		do
			create x.default_create
			print (x.val); io.new_line
		end

	x: G
			
end
