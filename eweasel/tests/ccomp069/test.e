class TEST
creation 
	make
feature 
	make is
		do
			if io = Void then
			elseif io.default /= Void then
			else
				io.put_integer (47)
				io.new_line
			end
  		end
	
end
