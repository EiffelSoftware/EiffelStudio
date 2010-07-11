
class TEST1
feature
	set_x (a_val: like x)
	       do
			x := a_val
	       end

	 x: like {TEST2}.x
end

