
class TEST

create
	make


feature

	make
		do
			if attached {HASH_TABLE [STRING, like n]} s then
				print ("Error%N")
			end
		end
	
	n: NONE
	
	s:  detachable STRING

end
