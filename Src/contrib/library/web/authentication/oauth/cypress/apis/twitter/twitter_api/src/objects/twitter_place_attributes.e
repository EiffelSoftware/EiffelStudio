note
	description: "[
		Place Attributes are metadata about places. An attribute is a key-value pair of arbitrary strings, but with some conventions.
		Below are a number of well-known place attributes which may, or may not exist in the returned data. 
		These attributes are provided when the place was created in the Twitter places database.
				
		Key							Description
		street_address	 
		locality					the city the place is in
		region						the administrative region the place is in
		iso3						the country code
		postal_code					in the preferred local format for the place
		phone						in the preferred local format for the place, include long distance code
		twitter						twitter screen-name, without @
		url							official/canonical URL for place
		app:id						An ID or comma separated list of IDs representing the place in the applications place database.

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_PLACE_ATTRIBUTES

inherit

	STRING_TABLE [STRING]


create
	make, make_equal, make_caseless, make_equal_caseless

end
