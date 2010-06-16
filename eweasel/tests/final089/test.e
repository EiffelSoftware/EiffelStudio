
class TEST

create
       make
feature

	make
		local 
			y: like {TEST2 [DOUBLE]}.value
		do
			if attached {like {TEST2 [BOOLEAN]}.value} y then
				print ("Error"); io.new_line
			else
				print ("OK"); io.new_line
			end
		end

end

