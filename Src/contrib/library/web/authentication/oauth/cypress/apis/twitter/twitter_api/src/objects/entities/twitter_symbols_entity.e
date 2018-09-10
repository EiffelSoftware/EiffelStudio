note
	description: "[
			Object that represent a symbol in an array of financial symbols starting with the dollar sign extracted from the Tweet text. 
			Similar to hashtags, an entity comes with the following attributes:

			text	The symbol text
			indices	The character positions the symbol was extracted from
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Symbols Entity", "src=https://dev.twitter.com/overview/api/entities-in-twitter-objects#the-symbols-entity", "protocol=uri"

class
	TWITTER_SYMBOLS_ENTITY

feature -- Access

	indices: detachable TUPLE [INTEGER, INTEGER]
			-- The character positions the symbol was extracted from.

	text: detachable STRING
			-- The symbol text.

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
