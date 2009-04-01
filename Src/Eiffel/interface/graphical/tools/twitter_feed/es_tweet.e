note
	description: "[
		A simple encapsulation of a twitter "tweet", used by the twitter feed tool ({ES_TWITTER_FEED_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TWEET

create
	make

feature {NONE} -- Initialization

	make (a_text: READABLE_STRING_32; a_user: READABLE_STRING_32; a_date: READABLE_STRING_32; a_source: READABLE_STRING_32)
			-- Initializes a tweet.
			--
			-- `a_text': Tweet text.
			-- `a_user': Tweet posting user/screen name.
			-- `a_date': A date string indicating when the tweet was posted.
			-- `a_source': Source medium used to post the tweet.
		require
			a_text_attached: a_text /= Void
			a_user_attached: a_user /= Void
			not_a_user_is_empty: not a_user.is_empty
			a_date_attached: a_date /= Void
			not_a_date_is_empty: not a_date.is_empty
			a_source_attached: a_source /= Void
			not_a_source_is_empty: not a_source.is_empty
		do
			create text.make_from_string (a_text)
			create user.make_from_string (a_user)
			create date.make_from_string (a_date)
			create source.make_from_string (a_source)
		ensure
			text_set: text.same_string (a_text)
			user_set: user.same_string (a_user)
			date_set: date.same_string (a_date)
			source_set: source.same_string (a_source)
		end

feature -- Access

	text: IMMUTABLE_STRING_32
			-- Actual tweet text.

	user: IMMUTABLE_STRING_32
			-- Username/scree name of the user who posted the tweet.

	date: IMMUTABLE_STRING_32
			-- Date time stamp when the tweet was posted.

	source: IMMUTABLE_STRING_32
			-- Source medium used to post the tweet.

invariant
	text_attached: text /= Void
	user_attached: user /= Void
	not_user_is_empty: not user.is_empty
	date_attached: date /= Void
	not_date_is_empty: not date.is_empty
	source_attached: source /= Void
	not_source_is_empty: not source.is_empty

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
