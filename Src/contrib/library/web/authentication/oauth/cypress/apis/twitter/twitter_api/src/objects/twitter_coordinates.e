note
	description: "[
			Represents the geographic location of this Tweet as reported by the user or client application. 
			The inner coordinates array is formatted as geoJSON (longitude first, then latitude). Example:

			"coordinates":
			{
			    "coordinates":
			    [
			        -75.14310264,
			        40.05701649
			    ],
			    "type":"Point"
			}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Twitter Coordinates", "src=https://dev.twitter.com/overview/api/tweets#coordinates",  "protocol=uri"

class
	TWITTER_COORDINATES

feature -- Access

	type: detachable STRING
			-- `type'

	coordinates: detachable LIST [REAL]
		-- The longitude and latitude of the Tweet
		-- Example:
		-- "coordinates":[-97.51087576,35.46500176]

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
