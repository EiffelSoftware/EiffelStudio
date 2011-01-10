
class TEST
create
        make
feature
        make
                do
			create a
			create b
			create c
			create d
			
			a := b.to_val1
			print (a.val); io.new_line
			a := b.to_val1
			print (a.val); io.new_line
			b := a.to_val2
			print (b.val); io.new_line
			b := a.to_val2
			print (b.val); io.new_line
			
			a := c.to_val1
			print (a.val); io.new_line
			a := c.to_val1
			print (a.val); io.new_line
			c := a.to_val3
			print (c.val); io.new_line
			c := a.to_val3
			print (c.val); io.new_line
			
			b := c.to_val2
			print (b.val); io.new_line
			b := c.to_val2
			print (b.val); io.new_line
			c := b.to_val3
			print (c.val); io.new_line
			c := b.to_val3
			print (c.val); io.new_line
			
			d := c.to_val4
			print (d.val); io.new_line
			d := c.to_val4
			print (d.val); io.new_line
			c := d.to_val3
			print (c.val); io.new_line
			c := d.to_val3
			print (c.val); io.new_line
                end

	a: TEST1 [INTEGER]

	b: TEST1 [BOOLEAN]

	c: TEST1 [CHARACTER_32]

	d: TEST1 [DOUBLE]

end
