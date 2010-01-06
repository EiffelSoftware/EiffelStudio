
class TEST

create
        make

feature
        make
                do
                        create r.make
                        create s.make
                        create t.make

                        print ({TEST}); io.new_line
                        print ({DOUBLE}); io.new_line
                        print ({NONE}); io.new_line
                end


        r: TEST1 [TEST]

        s: TEST1 [DOUBLE]

        t: TEST1 [NONE]
end

