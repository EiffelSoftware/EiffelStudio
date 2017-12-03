class TEST

create
        make

feature

        make
        	local
        		x: X [A]
                do
                	create {X [B]} x.make_attribute
                	print (x.baz.generating_type)
                	io.put_new_line
                	create {X [B]} x.make_like_attribute
                	print (x.baz.generating_type)
                	io.put_new_line
                	create {X [B]} x.make_type
                	print (x.baz.generating_type)
                	io.put_new_line
                end

end
