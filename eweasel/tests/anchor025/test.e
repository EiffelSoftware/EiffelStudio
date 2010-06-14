class TEST

create
        make

feature

        make
        	local
        		x: X [A]
                do
                	create {X [B]} x.make_attribute
                	io.put_string (x.baz.generating_type)
                	io.put_new_line
                	create {X [B]} x.make_like_attribute
                	io.put_string (x.baz.generating_type)
                	io.put_new_line
                	create {X [B]} x.make_type
                	io.put_string (x.baz.generating_type)
                	io.put_new_line
                end

end
