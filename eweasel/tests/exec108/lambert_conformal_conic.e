
class

        LAMBERT_CONFORMAL_CONIC

inherit

        CARTOGRAPHIC_PROJECTOR

creation

        make

feature -- Initialization

        make (initial_ellipsoid: ELLIPSOID) is
                        -- Make with given ellipsoid.
                do
                        set_ellipsoid (initial_ellipsoid)
                end

feature -- Access

        ellipsoid: ELLIPSOID
                        -- Ellipsoid approximation for planet.

feature -- Element change

        set_ellipsoid (new_ellipsoid: ELLIPSOID) is
                        -- Set the ellipsoid approximation for the planet.
                do
                        ellipsoid := new_ellipsoid
---print (new_ellipsoid)
---print (ellipsoid)
check ellipsoid = new_ellipsoid end
                end

end -- class LAMBERT_CONFORMAL_CONIC

