note
	description: "[
			Tweets are the basic atomic building block of all things Twitter. Tweets are also known as status updates. 
			Tweets can be embedded, replied to, liked, unliked and deleted.
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Tweets", "src=https://dev.twitter.com/overview/api/tweets", "protocol=uri"

class
	TWITTER_TWEETS

feature -- Access

	-- TODO complete.

	text: detachable STRING
			-- The actual UTF-8 text of the status update.

	user: detachable TWITTER_USER
			-- The user who posted this Tweet.

	created_at: detachable STRING
			-- UTC time when this Tweet was created
			--| Example:
			--| "created_at":"Wed Aug 27 13:08:45 +0000 2008"

feature -- Out

	full_out: STRING
			-- <Precursor>
		local
			l_offset: STRING
		do
			l_offset := "  "

			create Result.make_from_string ("")
			Result.append_string ("%N")

			if attached text as l_text then
				Result.append_string (l_offset)
				Result.append_string ("text=")
				Result.append_string (l_text)
				Result.append_string ("%N")
			end
			if attached created_at as l_created_at then
				Result.append_string (l_offset)
				Result.append_string ("created_at=")
				Result.append_string (l_created_at)
				Result.append_string ("%N")
			end

			if attached user as l_user then
				Result.append_string (l_offset)
				Result.append_string ("user=[")
				Result.append_string (l_user.short_out)
				Result.append_string ("]%N")
			end
		end


feature -- Element change

	set_text (a_text: like text)
			-- Assign `text' with `a_text'.
		do
			text := a_text
		ensure
			text_assigned: text = a_text
		end

	set_user (an_user: like user)
			-- Assign `user' with `an_user'.
		do
			user := an_user
		ensure
			user_assigned: user = an_user
		end

	set_created_at (a_created_at: like created_at)
			-- Assign `created_at' with `a_created_at'.
		do
			created_at := a_created_at
		ensure
			created_at_assigned: created_at = a_created_at
		end

end
