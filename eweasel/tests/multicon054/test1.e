
class TEST1 [G -> $(CONSTRAINT)]
feature
	try
		do
			if attached {G} value as x then
				io.put_double (x.a); io.new_line
			end
		end
		
	value: detachable G
	
	set_value (a_value: like value)
		do
			value := a_value
		end

end
