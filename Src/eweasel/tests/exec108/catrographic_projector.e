
deferred class

        CARTOGRAPHIC_PROJECTOR

feature -- Access

        ellipsoid: ELLIPSOID is
                        -- Ellipsoid approximation for planet.
                deferred
                end

feature -- Element change

        set_ellipsoid (new_ellipsoid: ELLIPSOID) is
                        -- Set the ellipsoid approximation for the planet.
                deferred
                ensure
                        ellipsoid_set: ellipsoid = new_ellipsoid
                end

end -- class CARTOGRAPHIC_PROJECTOR

