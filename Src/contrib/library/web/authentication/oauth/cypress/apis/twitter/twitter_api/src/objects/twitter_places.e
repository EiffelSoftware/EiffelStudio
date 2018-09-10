note
	description: "[
			Places are specific, named locations with corresponding geo coordinates. They can be attached to Tweets by specifying a place_id when tweeting. 
			Tweets associated with places are not necessarily issued from that location but could also potentially be about that location. Places can be searched for.
			Tweets can also be found by place_id.

			Places also have an attributes field that further describes a Place.
			These attributes are more convention rather than standard practice, and reflect information captured in the Twitter places database.

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS:"name=Twitter Places","src=https://dev.twitter.com/overview/api/places","protocol=uri"

class
	TWITTER_PLACES



feature -- Access

	url: detachable STRING
			--	URL representing the location of additional place metadata for this place. Example:
			-- "url":"https://api.twitter.com/1.1/geo/id/7238f93a3e899af6.json"

	place_type: detachable STRING
			-- The type of location represented by this place. Example:
			-- "place_type":"city"

	name: detachable STRING
			-- Short human-readable representation of the place
			-- "name":"Paris"

	id: detachable STRING
			-- ID representing this place. Note that this is represented as a string, not an integer. Example:
			-- "id":"7238f93a3e899af6"

	full_name: detachable STRING
			-- Full human-readable representation of the place
			-- "full_name":"San Francisco, CA"

	country_code: detachable STRING
			-- Shortened country code representing the country containing this place.
			-- Example:
			-- "country_code":"FR"

	country: detachable STRING
			-- Name of the country containing this place.
			-- Example:
			-- "country":"France"

	bounding_box: detachable TWITTER_BOUNDING_BOX
			-- A bounding box of coordinates which encloses this place.
			-- Example:
			-- "bounding_box":{"coordinates":[ [ [2.2241006,48.8155414], [2.4699099,48.8155414], [2.4699099,48.9021461], [2.2241006,48.9021461] ] ], "type":"Polygon"}

	attributes: detachable TWITTER_PLACE_ATTRIBUTES
			-- Contains a hash of variant information about the place.


feature -- Element change

	set_url (an_url: like url)
			-- Assign `url' with `an_url'.
		do
			url := an_url
		ensure
			url_assigned: url = an_url
		end

	set_place_type (a_place_type: like place_type)
			-- Assign `place_type' with `a_place_type'.
		do
			place_type := a_place_type
		ensure
			place_type_assigned: place_type = a_place_type
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_id (an_id: like id)
			-- Assign `id' with `an_id'.
		do
			id := an_id
		ensure
			id_assigned: id = an_id
		end

	set_full_name (a_full_name: like full_name)
			-- Assign `full_name' with `a_full_name'.
		do
			full_name := a_full_name
		ensure
			full_name_assigned: full_name = a_full_name
		end

	set_country_code (a_country_code: like country_code)
			-- Assign `country_code' with `a_country_code'.
		do
			country_code := a_country_code
		ensure
			country_code_assigned: country_code = a_country_code
		end

	set_country (a_country: like country)
			-- Assign `country' with `a_country'.
		do
			country := a_country
		ensure
			country_assigned: country = a_country
		end

	set_bounding_box (a_bounding_box: like bounding_box)
			-- Assign `bounding_box' with `a_bounding_box'.
		do
			bounding_box := a_bounding_box
		ensure
			bounding_box_assigned: bounding_box = a_bounding_box
		end

	set_attributes (an_attributes: like attributes)
			-- Assign `attributes' with `an_attributes'.
		do
			attributes := an_attributes
		ensure
			attributes_assigned: attributes = an_attributes
		end

end
