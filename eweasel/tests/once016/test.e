
class TEST
create
        make
feature
        make
                do
			create b
			a := b.to_val1
			print (a.val); io.new_line
                end

	a: TEST2

	b: TEST2

end
