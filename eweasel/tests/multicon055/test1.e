
class TEST1 [G -> {G, DOUBLE}]
feature
	try
		do
			if attached {like {G}.default} value as x then
				print (x); io.new_line
			end
		end
	
	value: detachable G

end
