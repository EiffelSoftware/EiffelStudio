
class TEST
create
        make
feature
        make
                do
			create a
			create b
			
			a := b.to_test1
			print (a.value); io.new_line
			a := b.to_test1
			print (a.value); io.new_line
                end

	a: TEST1

	b: TEST1

end
