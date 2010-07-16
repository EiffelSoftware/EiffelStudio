
class TEST
inherit
	MEMORY
create
	make
feature
	make
		do
			print (attached {NONE} (47)); io.new_line
			full_collect
		end
		
end
