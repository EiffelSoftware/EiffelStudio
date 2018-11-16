note
	description: "Summary description for {TEST_TWITTER_PLACES_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TWITTER_PLACES_SET

inherit

	TEST_TWITTER_COMMON


feature -- Test routines

	test_bounding_box
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (bounding_box_json) as l_bounding_box_json then
				if attached {TWITTER_BOUNDING_BOX}  twitter_json.twitter_bounding_box (void, l_bounding_box_json) as l_bounding_box then
					assert ("expected type=polygon", attached l_bounding_box.type as l_type and then l_type.same_string ("Polygon"))
					if attached l_bounding_box.coordinates as l_list then
						assert ("Expected 1", l_list.count = 1)
						if attached l_list.at (1) as l_list_2 then
							assert ("Expected 4", l_list_2.count = 4)
							if attached l_list_2.at (1) as l_list_21 then
								assert ("Expected 2", l_list_21.count = 2)
								assert ("Expected item 1", l_list_21.first =  -122.400612831116)
								assert ("Expected item 2", l_list_21.last =  37.7821120598956)
							end
							if attached l_list_2.at (4) as l_list_24 then
								assert ("Expected 2", l_list_24.count = 2)
								assert ("Expected item 1", l_list_24.first =  -122.400612831116)
								assert ("Expected item 2", l_list_24.last =  37.7821120598956)
							end
						end
					end
				end
			else
				assert("Check implementation", False)
			end
		end


	test_place_attributes
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (attributes_json) as l_attributes_json then
				if attached {TWITTER_PLACE_ATTRIBUTES}  twitter_json.twitter_place_attributes (void, l_attributes_json) as l_attributes then
					assert ("street_address", attached l_attributes.item ("street_address") as l_item and then l_item.same_string ("795 Folsom St"))
					assert ("app:id", attached l_attributes.item ("623:id") as l_item and then l_item.same_string ("210176"))
					assert ("twitter", attached l_attributes.item ("twitter") as l_item and then l_item.same_string ("twitter"))
				end
			else
				assert("Check implementation", False)
			end
		end

	test_twitter_place
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (twitter_places_json) as l_twitter_places_json then
				if attached {TWITTER_PLACES}  twitter_json.twitter_place_attributes (void, l_twitter_places_json) as l_twitter_place_json then

					assert ("name", attached l_twitter_place_json.name as l_name and then l_name.same_string ("Twitter HQ"))
					assert ("country", attached l_twitter_place_json.country as l_country and then l_country.same_string ("United States"))
					assert ("country_code",attached l_twitter_place_json.country_code as l_country_code and then l_country_code.same_string ("wUS") )
					assert ("url", attached l_twitter_place_json.url as l_url and then l_url.same_string ("https://api.twitter.com/1.1/geo/id/247f43d441defc03.json"))
					assert ("id", attached l_twitter_place_json.id as l_id and then l_id.same_string ("247f43d441defc03"))
					assert ("full_name", attached l_twitter_place_json.full_name as l_full_name and then l_full_name.same_string ("Twitter HQ, San Francisco"))
					assert ("place_type", attached l_twitter_place_json.place_type as l_place_type and then l_place_type.same_string ("poi"))

						-- attributes
					if attached l_twitter_place_json.attributes as l_attributes then
						assert ("street_address", attached l_attributes.item ("street_address") as l_item and then l_item.same_string ("795 Folsom St"))
						assert ("app:id", attached l_attributes.item ("623:id") as l_item and then l_item.same_string ("210176"))
						assert ("twitter", attached l_attributes.item ("twitter") as l_item and then l_item.same_string ("twitter"))
					end
						--bounding box
					if attached {TWITTER_BOUNDING_BOX} l_twitter_place_json.bounding_box as l_bounding_box then
						assert ("expected type=polygon", attached l_bounding_box.type as l_type and then l_type.same_string ("Polygon"))
						if attached l_bounding_box.coordinates as l_list then
							assert ("Expected 1", l_list.count = 1)
							if attached l_list.at (1) as l_list_2 then
								assert ("Expected 4", l_list_2.count = 4)
								if attached l_list_2.at (1) as l_list_21 then
									assert ("Expected 2", l_list_21.count = 2)
									assert ("Expected item 1", l_list_21.first =  -122.400612831116)
									assert ("Expected item 2", l_list_21.last =  37.7821120598956)
								end
								if attached l_list_2.at (4) as l_list_24 then
									assert ("Expected 2", l_list_24.count = 2)
									assert ("Expected item 1", l_list_24.first =  -122.400612831116)
									assert ("Expected item 2", l_list_24.last =  37.7821120598956)
								end
							end
						end
					end

				end
			else
				assert("Check implementation", False)
			end
		end

feature -- Json

	bounding_box_json: STRING = "[
			{
			    "coordinates": [
			      [
			        [
			          -122.400612831116,
			          37.7821120598956
			        ],
			        [
			          -122.400612831116,
			          37.7821120598956
			        ],
			        [
			          -122.400612831116,
			          37.7821120598956
			        ],
			        [
			          -122.400612831116,
			          37.7821120598956
			        ]
			      ]
			    ],
			    "type": "Polygon"
			  }
		]"


	attributes_json: STRING = "[
	 	{	
	 	 "attributes": {
		    "street_address": "795 Folsom St",
		    "623:id": "210176",
		    "twitter": "twitter"
		  }
		}

	]"

	twitter_places_json: STRING = "[
			 {
		  "name": "Twitter HQ",
		  "polylines": [

		  ],
		  "country": "United States",
		  "country_code": "wUS",
		  "attributes": {
		    "street_address": "795 Folsom St",
		    "623:id": "210176",
		    "twitter": "twitter"
		  },
		  "url": "https://api.twitter.com/1.1/geo/id/247f43d441defc03.json",
		  "bounding_box": {
		    "coordinates": [
		      [
		        [
		          -122.400612831116,
		          37.7821120598956
		        ],
		        [
		          -122.400612831116,
		          37.7821120598956
		        ],
		        [
		          -122.400612831116,
		          37.7821120598956
		        ],
		        [
		          -122.400612831116,
		          37.7821120598956
		        ]
		      ]
		    ],
		    "type": "Polygon"
		  },
		  "id": "247f43d441defc03",
		  "full_name": "Twitter HQ, San Francisco",
		  "place_type": "poi"
		}
	]"
end
