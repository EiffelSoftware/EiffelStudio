note
	description: "Summary description for {TWITTER_STATUS}."
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_STATUS

feature -- Access

	id: INTEGER
			-- a permanent unique id referencing an object, such as user or status
			-- Examples: 1145445329 (status)

	created_at: detachable STRING
			-- timestamp of element creation, either status or user
			-- Example: Sat Jan 24 22:14:29 +0000 2009

	text: detachable STRING
			-- escaped and HTML encoded status body
			-- Examples: I am eating oatmeal, The first tag is always <html>	

	source: detachable STRING
			-- application that sent a status
			-- Examples: web	

	truncated: BOOLEAN
			-- boolean indicating if a status required shortening	

	in_reply_to_status_id: INTEGER
			-- unique id for the status a status replies to (see id)
			-- Examples: empty, 1047468972	

	in_reply_to_user_id: INTEGER
			-- unique id for the user that wrote the status a status replies to (see id)
			-- Examples: empty, 14597523	

	in_reply_to_screen_name: detachable STRING
			-- display name for the user that wrote the status a status replies to (see screen_name)
			-- Examples: empty, tweetybird

	favorited: detachable BOOLEAN
			-- boolean indicating if a status has been marked as a favorite	

	user: detachable TWITTER_USER
			-- Associated user

feature -- Access

	short_out: STRING
			-- <Precursor>
		do
			create Result.make_from_string ("STATUS: ")
			if favorited then
				Result.append_string ("(*) ")
			end

			Result.append_string ("id=")
			Result.append_integer (id)
			Result.append_string (" ")

			if attached source as l_source then
				Result.append_string ("source=")
				Result.append_string (l_source)
				Result.append_string (" ")
			end

			if attached user as l_user then
				Result.append_string ("user=[")
				Result.append_string (l_user.short_out)
				Result.append_string ("] ")
			end

			if attached created_at as l_created_at then
				Result.append_string ("created_at=")
				Result.append_string (created_at)
				Result.append_string (" ")
			end
		end

	full_out: STRING
			-- <Precursor>
		local
			l_offset: STRING
		do
			l_offset := "  "

			create Result.make_from_string (short_out)
			Result.append_string ("%N")

			if in_reply_to_status_id > 0 then
				Result.append_string (l_offset)
				Result.append_string ("in_reply_to_status_id=")
				Result.append_integer (in_reply_to_status_id)
				Result.append_string ("%N")
			end

			if in_reply_to_user_id > 0 then
				Result.append_string (l_offset)
				Result.append_string ("in_reply_to_user_id=")
				Result.append_integer (in_reply_to_user_id)
				Result.append_string ("%N")
			end

			if attached in_reply_to_screen_name as l_in_reply_to_screen_name then
				Result.append_string (l_offset)
				Result.append_string ("in_reply_to_screen_name=")
				Result.append_string (l_in_reply_to_screen_name)
				Result.append_string ("%N")
			end

			Result.append_string (l_offset)
			if truncated then
				Result.append_string ("(truncated)")
			end
			Result.append_string ("text=")
			Result.append_string (text)
			Result.append_string ("%N")
		end

feature -- Element change

	set_id (a_id: like id)
			-- Set `id' to `a_id'
		do
			id := a_id
		end

	set_created_at (a_created_at: like created_at)
			-- Set `created_at' to `a_created_at'
		do
			created_at := a_created_at
		end

	set_text (a_text: like text)
			-- Set `text' to `a_text'
		do
			text := a_text
		end

	set_source (a_source: like source)
			-- Set `source' to `a_source'
		do
			source := a_source
		end

	set_truncated (a_truncated: like truncated)
			-- Set `truncated' to `a_truncated'
		do
			truncated := a_truncated
		end

	set_in_reply_to_status_id (a_in_reply_to_status_id: like in_reply_to_status_id)
			-- Set `in_reply_to_status_id' to `a_in_reply_to_status_id'
		do
			in_reply_to_status_id := a_in_reply_to_status_id
		end

	set_in_reply_to_user_id (a_in_reply_to_user_id: like in_reply_to_user_id)
			-- Set `in_reply_to_user_id' to `a_in_reply_to_user_id'
		do
			in_reply_to_user_id := a_in_reply_to_user_id
		end

	set_in_reply_to_screen_name (a_in_reply_to_screen_name: like in_reply_to_screen_name)
			-- Set `in_reply_to_screen_name' to `a_in_reply_to_screen_name'
		do
			in_reply_to_screen_name := a_in_reply_to_screen_name
		end

	set_favorited (a_favorited: like favorited)
			-- Set `favorited' to `a_favorited'
		do
			favorited := a_favorited
		end

	set_user (a_user: like user)
			-- Set `user' to `a_user'
		do
			user := a_user
		end

note
	copyright: "Copyright (c) 2003-2009, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
