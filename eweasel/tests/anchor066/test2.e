
class TEST2 [G -> TEST1 [ANY]]
feature
	try
		do
			print ({NONE}); io.new_line
			print ({like y}); io.new_line
			print ({like {G}.x}); io.new_line
		end

	x: G
	
	y: NONE
end
