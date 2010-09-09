
class TEST2
inherit
        TEST3
feature
        b: TEST3
                once ("OBJECT")
                        create Result
                end
end
