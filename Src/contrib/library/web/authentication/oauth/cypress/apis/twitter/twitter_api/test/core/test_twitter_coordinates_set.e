note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TWITTER_COORDINATES_SET

inherit

	TEST_TWITTER_COMMON

feature -- Test routines

	test_place_attributes
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (coordinates_json) as l_coordinates_json then
				if attached {TWITTER_COORDINATES} twitter_json.twitter_coordinates (void, l_coordinates_json) as l_coordinates then
					assert ("type", attached l_coordinates.type as l_type and then l_type.same_string ("Point"))
					if attached l_coordinates.coordinates as l_list then
						assert ("Count", l_list.count = 2)
						assert ("Item 1", attached l_list.at (1) as l_item1 and then l_item1 = -75.14310264 )
						assert ("Item 2", attached l_list.at (2) as l_item2 and then l_item2 = 40.05701649 )
					end
				end
			else
				assert ("Check implementation", False)
			end
		end

feature -- JSON

	coordinates_json: STRING = "[
			{
			    "coordinates":
			    [
			        -75.14310264,
			        40.05701649
			    ],
			    "type":"Point"
			}
		]"

end
