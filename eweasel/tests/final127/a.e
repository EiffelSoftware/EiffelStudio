deferred class A

feature

        is_less_equal alias "<=" (other: like Current): BOOLEAN
                do
                        Result := is_less (other) or is_equal (other)
                end

        is_less (other: like Current): BOOLEAN
                deferred
                end

end
