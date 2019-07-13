class TEST

create
        make

feature {NONE} -- Creation

        make is
                local
                	t: TYPED_POINTER [TEST]
                do
                	io.put_string (t.generator)
                	io.put_new_line
                	io.put_string (t.generating_type.name_32.to_string_8)
                	io.put_new_line
                end

end
