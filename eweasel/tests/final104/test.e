
expanded class TEST

create
        make, default_create
feature

        make
                do
                        print (a.generating_type); io.new_line
                        print (b.generating_type); io.new_line
                        print (value.generating_type); io.new_line
                end

        value: like a
               do
                        Result := a
               end

        a: like b
               do
                        Result := b
               end

        b: like Current
               do
                        create Result
               end
end
