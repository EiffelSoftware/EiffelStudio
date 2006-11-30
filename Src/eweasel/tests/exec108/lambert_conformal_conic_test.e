
class

        LAMBERT_CONFORMAL_CONIC_TEST

creation

        make

feature -- Initialization

        make is
                        -- Test driver.
                local
                        wgs_1984: ELLIPSOID
                        lambert: LAMBERT_CONFORMAL_CONIC
                do
                        create lambert.make (wgs_1984)
                end

end -- class LAMBERT_CONFORMAL_CONIC_TEST

