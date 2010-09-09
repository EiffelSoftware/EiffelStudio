
class TEST3
inherit
        TEST4
feature
        c: TEST4
                once ("OBJECT")
                        create Result
                end
end
