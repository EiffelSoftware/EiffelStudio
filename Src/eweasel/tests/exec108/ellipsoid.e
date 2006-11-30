
expanded class

        ELLIPSOID

inherit

        ANY
                redefine
                        default_create
                end

feature -- Initialization

        default_create is
                        -- Initialize to WGS_1984 approximation of Earth.
                do
                        major_semiaxis := 6378165.0
                        minor_semiaxis := 6356783.0
                ensure then
                        major_semiaxis_set: major_semiaxis = 6378165.0
                        minor_semiaxis_set: minor_semiaxis = 6356783.0
                end

feature -- Access

        major_semiaxis: DOUBLE
                        -- Ellipsoid's mean major radius - typically from
			-- the center
                        -- of the planet to the equator in units of meters.

        minor_semiaxis: DOUBLE
                        -- Ellipsoid's mean minor radius - typically from
			-- the center
                        -- of the planet to the geographic north pole in
			-- units of meters.

invariant

                major_semiaxis_valid: major_semiaxis > 0.0
                minor_semiaxis_valid: minor_semiaxis > 0.0
                ordered_semiaxes: major_semiaxis >= minor_semiaxis

end -- class ELLIPSOID

