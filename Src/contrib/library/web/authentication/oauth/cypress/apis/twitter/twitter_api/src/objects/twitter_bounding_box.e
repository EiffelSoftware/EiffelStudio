note
	description: "Summary description for {TWITTER_BOUNDING_BOX}."
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_BOUNDING_BOX

feature -- Access

	type: detachable STRING
			-- The type of data encoded in the coordinates property.
			-- This will be “Polygon” for bounding boxes.
			-- Example:
			-- "type":"Polygon"

	coordinates: detachable LIST [LIST [LIST [REAL]]]
			-- A series of longitude and latitude points, defining a box which will contain the Place entity this bounding box is related to.
			-- Each point is an array in the form of [longitude, latitude]. Points are grouped into an array per bounding box.
			-- Bounding box arrays are wrapped in one additional array to be compatible with the polygon notation. Example:
			-- "coordinates":[ [ [2.2241006,48.8155414], [2.4699099,48.8155414], [2.4699099,48.9021461], [2.2241006,48.9021461] ] ]
			-- TODO: it seems we can represent it as a List of tuples.


feature -- Element change

	set_type (a_type: like type)
			-- Assign `type' with `a_type'.
		do
			type := a_type
		ensure
			type_assigned: type = a_type
		end

	set_coordinates (a_coordinates: like coordinates)
			-- Assign `coordinates' with `a_coordinates'.
		do
			coordinates := a_coordinates
		ensure
			coordinates_assigned: coordinates = a_coordinates
		end

end
