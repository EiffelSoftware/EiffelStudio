
class TEST1
create
	make
feature
	make
		do
		end

	x: INTEGER assign set_x

feature {NONE}

	set_x (val: like x)
	      require
		   negative_val: valid_value (val)
	      do
			x := val
	      end

	valid_value (n: INTEGER): BOOLEAN
	      do
			Result := n < 0
	      end
end
