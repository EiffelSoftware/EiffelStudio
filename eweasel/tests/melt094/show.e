
class SHOW

feature

	show (p: POINTER)
		do
			
			if p = default_pointer then
				print ("Failed: p = " + p.out + " (but default_pointer = " + default_pointer.out + ")"); io.new_line
			else
				print ("OK"); io.new_line
			end
		end

end
