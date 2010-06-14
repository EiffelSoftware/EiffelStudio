class TEST

create
        make

feature

        make
        	local
        		x: X [A]
                do
                	create {X [B]} x.make
                	io.put_string (x.baz.generating_type)
                	io.put_new_line
                	io.put_string (x.quux.generating_type)
                	io.put_new_line
                end

end
