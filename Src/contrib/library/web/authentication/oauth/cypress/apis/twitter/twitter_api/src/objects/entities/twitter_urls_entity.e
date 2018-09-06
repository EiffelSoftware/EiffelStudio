note
	description: "[
		Object that represnet an URL in an array of URLs extracted from the Tweet text.

		Each URL entity comes with the following attributes:

			{
			  ...
			  "text": "Today, Twitter is updating embedded Tweets to enable a richer photo experience: https:\/\/t.co\/XdXRudPXH5",
			  "entities": {
			    "hashtags": [],
			    "symbols": [],
			    "urls": [{
			      "url": "https:\/\/t.co\/XdXRudPXH5",
			      "expanded_url": "https:\/\/blog.twitter.com\/2013\/rich-photo-experience-now-in-embedded-tweets-3",
			      "display_url": "blog.twitter.com\/2013\/rich-phot\u2026",
			      "indices": [80, 103]
			    }],
			    "user_mentions": []
			  }
			}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name? Urls Entity", "src=https://dev.twitter.com/overview/api/entities-in-twitter-objects#the-urls-entity", "protocol=uri"

class
	TWITTER_URLS_ENTITY


feature -- Access

	indices: detachable TUPLE [INTEGER, INTEGER]
			-- The character positions the URL was extracted from.

	expanded_url: detachable STRING
			-- The resolved URL.

	display_url: detachable STRING
			-- Not a valid URL but a string to display instead of the URL.

	url: detachable STRING
			-- The t.co URL that was extracted from the Tweet text.

feature -- Element change

	set_indices (an_indices: like indices)
			-- Assign `indices' with `an_indices'.
		do
			indices := an_indices
		ensure
			indices_assigned: indices = an_indices
		end

	set_expanded_url (an_expanded_url: like expanded_url)
			-- Assign `expanded_url' with `an_expanded_url'.
		do
			expanded_url := an_expanded_url
		ensure
			expanded_url_assigned: expanded_url = an_expanded_url
		end

	set_display_url (a_display_url: like display_url)
			-- Assign `display_url' with `a_display_url'.
		do
			display_url := a_display_url
		ensure
			display_url_assigned: display_url = a_display_url
		end

	set_url (an_url: like url)
			-- Assign `url' with `an_url'.
		do
			url := an_url
		ensure
			url_assigned: url = an_url
		end

end
