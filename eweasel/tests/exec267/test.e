class TEST

create
        make

feature {NONE} -- Creation

        make is
                local
                	a: A [INTEGER]
                do
                	create a
					a.test (73)
					io.put_new_line
                end

end
