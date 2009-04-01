note
	description: "[
		XML Load callback for examining a user timeline twitter feed.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TWITTER_FEED_LOAD_CALLBACKS

inherit
	XM_STATE_LOAD_CALLBACKS
		rename
			make as make_state_callbacks
		end

create
	make

feature {NONE} -- Initialization

	make (a_parser: like xml_parser; a_action: like tweet_action)
			-- Initializes callbacks using an existing XML parser.
			-- Note: Initialization will set the parser's callbacks to Current.
			--
			-- `a_parser': An XML parser Current is used with.
			-- `a_action': An action to report when a new tweet has been generated.
		require
			a_parser_attached: a_parser /= Void
		do
			tweet_action := a_action
			make_state_callbacks (a_parser)
		ensure
			xml_parser_set: xml_parser = a_parser
			xml_parser_callbacks_set: xml_parser.callbacks = Current
			tweet_action_set: tweet_action = a_action
		end

feature -- Access

	tweet_action: PROCEDURE [ANY, TUPLE [tweet: ES_TWEET]]
			-- Action called when a new tweet is generated
			--
			-- 'tweet': A new tweet.

feature {NONE} -- Access

	last_text: detachable STRING_32

	last_source: detachable STRING_32

	last_created_at: detachable STRING_32

	last_screen_name: detachable STRING_32

feature {NONE} -- Status report

	is_strict: BOOLEAN = False
			-- <Precursor>

feature {NONE} -- Basic operation

	construct_tweet
			-- Constructs a tweet with the cached data.
		require
			not_has_error: not has_error
		local
			l_tweet: ES_TWEET
		do
			if
				attached last_text as l_text and then not l_text.is_empty and then
				attached last_screen_name as l_screen_name and then not l_screen_name.is_empty and then
				attached last_created_at as l_created_at and then not l_created_at.is_empty and then
				attached last_source as l_source and then not l_source.is_empty
			then
				create l_tweet.make (l_text, l_screen_name, l_created_at, l_source)
				tweet_action.call ([l_tweet])
			end
			last_text := Void
			last_screen_name := Void
			last_created_at := Void
			last_source := Void
		ensure
			last_text_attached: last_text = Void
			last_screen_name_attached: last_screen_name = Void
			last_created_at_attached: last_created_at = Void
			last_source_attached: last_source = Void
		end

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do

		end

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_status then
				construct_tweet
			when t_created_at then
				last_created_at := current_content
			when t_screen_name then
				last_screen_name := current_content
			when t_source then
				last_source := current_content
			when t_text then
				last_text := current_content
			else

			end
		end

feature {NONE} -- State transistions

	tag_state_transitions: DS_HASH_TABLE [DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- <Precursor>
		local
			l_trans: attached DS_HASH_TABLE [NATURAL_8, STRING]
		once
			create Result.make (8)

				-- XML
				-- => statuses
			create l_trans.make (1)
			l_trans.put (t_statuses, statuses_tag)
			Result.put (l_trans, t_none)

				-- statuses
				-- => status
			create l_trans.make (1)
			l_trans.put (t_status, status_tag)
			Result.put (l_trans, t_statuses)

				-- status
				-- => created_at
				-- => source
				-- => text
				-- => user
			create l_trans.make (4)
			l_trans.put (t_created_at, created_at_tag)
			l_trans.put (t_source, source_tag)
			l_trans.put (t_text, text_tag)
			l_trans.put (t_user, user_tag)
			Result.put (l_trans, t_status)

				-- user
				-- => screen_name
			create l_trans.make (1)
			l_trans.put (t_screen_name, screen_name_tag)
			Result.put (l_trans, t_user)
		end

	attribute_states: detachable DS_HASH_TABLE [DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- <Precursor>
		once
		end

feature {NONE} -- Tag states

	t_statuses: NATURAL_8    = 0x01

	t_status: NATURAL_8      = 0x10
	t_created_at: NATURAL_8  = 0x11
	t_source: NATURAL_8      = 0x12
	t_text: NATURAL_8        = 0x13

	t_user: NATURAL_8        = 0x20
	t_screen_name: NATURAL_8 = 0x21

feature {NONE} -- Constants

	statuses_tag: STRING = "statuses"
	status_tag: STRING = "status"
	created_at_tag: STRING = "created_at"
	source_tag: STRING = "source"
	text_tag: STRING = "text"
	user_tag: STRING = "user"
	screen_name_tag: STRING = "screen_name"

invariant
	tweet_action_attached: tweet_action /= Void

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
