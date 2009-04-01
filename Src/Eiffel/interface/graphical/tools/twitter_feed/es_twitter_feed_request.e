note
	description: "[
		A utility class to request a
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TWITTER_FEED_REQUEST

inherit
	THREAD
		export
			{NONE} all
		end

feature {NONE} -- Access

	responder: detachable PROCEDURE [ANY, TUPLE [tweet: ES_TWEET]]
			-- Responder to call when a tweet has been generated.

	completed_responder: detachable PROCEDURE [ANY, TUPLE]
			-- Responder to call when all tweets have been generated.

	xml_parser: XM_EIFFEL_PARSER
			-- XML parser to parse reponse strings.
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Measurements

	maximum_tweets: NATURAL_8
			-- Maximum number of tweets to retrieve.

feature -- Status report

	is_processing_request: BOOLEAN
			-- Indicates if a request for tweets is currently being processed.

feature -- Basic operations

	request_tweets (a_count: NATURAL_8): ARRAYED_LIST [ES_TWEET]
			-- Requests the tweets synchronusly.
			--
			-- `a_count': Maximum number of tweets to retrieve or 0 to retrieve all.
		require
			not_is_processing_request: not is_processing_request
		do
			create Result.make (0)
			request_tweets_aync (a_count, agent Result.extend, Void)
			if {PLATFORM}.is_thread_capable then
				join
			end
		ensure
			result_attached: Result /= Void
		end

	request_tweets_aync (a_count: NATURAL_8; a_responder: PROCEDURE [ANY, TUPLE [ES_TWEET]]; a_completed: detachable PROCEDURE [ANY, TUPLE])
			-- Requests the tweets synchronusly.
			--
			-- `a_count': Maximum number of tweets to retrieve or 0 to retrieve all.
			-- `a_responder': A callback agent to callback when a tweet is generated,
			-- `a_completed': A callback agent when all tweets have been generated.
		require
			not_is_processing_request: not is_processing_request
			a_responder_attached: a_responder /= Void
		do
			responder := a_responder
			completed_responder := a_completed
			maximum_tweets := a_count
			if {PLATFORM}.is_thread_capable then
				launch
			else
				execute
			end
		end

feature {NONE} -- Query

	url_response (a_url: READABLE_STRING_8; a_args: detachable HASH_TABLE [STRING, STRING]): detachable STRING
			-- Fetch contents of a URL.
			--
			-- `a_url': A request URL to fetch the contents for.
			-- `a_args': Any URL parameters.
			-- `Result': The response of the URL.
		require
			a_url_attached: a_url /= Void
			not_a_url_is_empty: not a_url.is_empty
			a_url_is_correct: (create {HTTP_URL}.make (a_url.as_string_8)).is_correct
			not_a_args_is_empty: a_args /= Void implies not a_args.is_empty
		local
			l_url_string: STRING
			l_protcol: HTTP_PROTOCOL
			l_url: HTTP_URL
			retried: BOOLEAN
		do
			if not retried then
					-- Create URL string
				create l_url_string.make_from_string (a_url)
				if a_args /= Void and then not a_args.is_empty then
					l_url_string.append_character ('?')
					from a_args.start until a_args.after loop
						if attached a_args.item_for_iteration as l_value then
							l_url_string.append_string (a_args.key_for_iteration)
							l_url_string.append_character ('=')
							l_url_string.append_string (l_value)
							l_url_string.append_character ('&')
						end
						a_args.forth
					end
				end

				create l_url.make (l_url_string)
				create l_protcol.make (l_url)
				l_protcol.set_connect_timeout (30)
				l_protcol.set_timeout (60)
				l_protcol.set_port (80)
				l_protcol.set_read_mode
				l_protcol.open
				if l_protcol.is_open then
					l_protcol.initiate_transfer
					if l_protcol.transfer_initiated then
						create Result.make (256)
						l_protcol.set_read_buffer_size (256)
						from l_protcol.read until l_protcol.error or not l_protcol.is_packet_pending loop
							if attached l_protcol.last_packet as l_packet then
								Result.append (l_packet)
							end
							if l_protcol.is_packet_pending then
								l_protcol.read
							end
						end
						if attached l_protcol.last_packet as l_packet then
							Result.append (l_packet)
						end
					else
						-- Not good
					end
					l_protcol.close
				else
					-- Time out
				end
			end
		rescue
			if attached l_protcol and then l_protcol.is_open then
				l_protcol.close
			end
			retried := True
			retry
		end

feature {NONE} -- Basic operations

	execute
			-- <Precursor>
		local
			l_count: like maximum_tweets
			l_args: detachable HASH_TABLE [STRING, STRING]
			l_response: like url_response
		do
				-- Call Twitter API via a URL.
			l_count := maximum_tweets
			if l_count > 0 then
				create l_args.make (1)
				l_args.put (l_count.out, count_arg)
			end
			l_response := url_response (xml_timeline_url, l_args)
			if attached l_response and not l_response.is_empty then
				extract_tweets (l_response)
			end
			if attached completed_responder as l_responder then
				l_responder.call (Void)
			end
		end

feature {NONE} -- Basic operations: Extraction

	extract_tweets (a_string: READABLE_STRING_GENERAL)
			-- Extracts Tweets from a XML response string.
			--
			-- `a_string': A XML string to extract tweets from.
			-- `a_responder': A callback agent for every tweet generated.
		require
			a_string_attached: a_string /= Void
			not_a_string_is_empty: not a_string.is_empty
			responder_attached: responder /= Void
		local
			l_parser: like xml_parser
			l_extracts: ES_TWITTER_FEED_LOAD_CALLBACKS
			l_responder: like responder
		do
			l_parser := xml_parser
			l_responder := responder
			check l_responder_attached: l_responder /= Void end
			create l_extracts.make (l_parser, l_responder)
			l_parser.parse_from_string (a_string.as_string_8)
		end

feature {NONE} -- Constants

	xml_timeline_url: STRING = "http://twitter.com/statuses/user_timeline/eiffelstudio.xml"
			-- URL for XML query for twitter time line

	count_arg: STRING = "count"
			-- Count argument for XML queries

invariant
	responder_attached: is_processing_request implies responder /= Void

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
