
class TEST1
feature
	x: like y
		once ("OBJECT")
			create Result.make (0)
		end

	y: STRING
	
end
