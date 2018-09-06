note
	description: "[
		An array of hashtags extracted from the Tweet text. Each hashtag entity comes with the following attributes:

		text	The hashtag text
		indices	The character positions the hashtag was extracted from
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Hashtags", "src=https://dev.twitter.com/overview/api/entities-in-twitter-objects#the-hashtags-entity", "protocol=uri"

class
	TWITTER_HASHTAGS_ENTITY


feature -- Access

	indices: detachable TUPLE [INTEGER, INTEGER]
			-- The character positions the hashtag was extracted from

	text: detachable STRING
			-- The hashtag text

feature -- Element change

	set_indices (an_indices: like indices)
			-- Assign `indices' with `an_indices'.
		do
			indices := an_indices
		ensure
			indices_assigned: indices = an_indices
		end

	set_text (a_text: like text)
			-- Assign `text' with `a_text'.
		do
			text := a_text
		ensure
			text_assigned: text = a_text
		end

end
