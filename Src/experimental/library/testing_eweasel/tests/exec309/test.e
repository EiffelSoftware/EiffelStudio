
class TEST

create
	make


feature

	make
		do
			try (False)
		end
	
	try (b: BOOLEAN)
		do
			if b then
				if attached {TEST2} s then
					print ("Ooooops!  Void object attached to instance of TEST2%N")
				end
			end
		end
	
	s: detachable STRING

end
