note
	description: "Object representing available sizes for the media file."
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_SIZES_ENTITY

feature -- Access

	small: detachable TWITTER_SIZE_ENTITY
			--Information for a small-sized version of the media. Example:
			--"small":{"h":238, "resize":"fit", "w":226}

	medium: detachable TWITTER_SIZE_ENTITY
			-- Information for a medium-sized version of the media. Example:
			-- "medium":{"h":238, "resize":"fit", "w":226}

	large: detachable TWITTER_SIZE_ENTITY
			--	Information for a large-sized version of the media. Example:
			-- "large":{"h":238, "resize":"fit", "w":226}

	thumb: detachable TWITTER_SIZE_ENTITY
			-- Information for a thumbnail-sized version of the media.
			-- Example:
			-- "thumb":{"h":150, "resize":"crop", "w":150}

feature -- Element change

	set_small (a_small: like small)
			-- Assign `small' with `a_small'.
		do
			small := a_small
		ensure
			small_assigned: small = a_small
		end

	set_medium (a_medium: like medium)
			-- Assign `medium' with `a_medium'.
		do
			medium := a_medium
		ensure
			medium_assigned: medium = a_medium
		end

	set_large (a_large: like large)
			-- Assign `large' with `a_large'.
		do
			large := a_large
		ensure
			large_assigned: large = a_large
		end

	set_thumb (a_thumb: like thumb)
			-- Assign `thumb' with `a_thumb'.
		do
			thumb := a_thumb
		ensure
			thumb_assigned: thumb = a_thumb
		end

end
