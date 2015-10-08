note
	description: "Summary description for {APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature	-- Initialization

	make
			-- New test routine
		do
			test_file ("data_rss_1_0.rss")
			test_web ("https://bertrandmeyer.com/feed/")
		end

	test_file (fn: READABLE_STRING_GENERAL)
		local
			t: STRING
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_name (fn)
			f.open_read
			create t.make_empty
			from
				f.read_stream_thread_aware (1_024)
			until
				f.last_string.count < 1024
			loop
				t.append (f.last_string)
				f.read_stream_thread_aware (1_024)
			end
			t.append (f.last_string)
			f.close
			test_feed (t)
		end

	test_feed (t: READABLE_STRING_8)
		local
			feed_parser: FEED_DEFAULT_PARSERS
			vis: FEED_TO_STRING_32_DEBUG_VISITOR
			gen: RSS_2_FEED_GENERATOR
			atom_gen: ATOM_FEED_GENERATOR
			s: STRING_32
			s8: STRING_8
			pp: XML_PRETTY_PRINT_FILTER
		do
			create feed_parser
			if attached feed_parser.feed_from_string (t) as l_feed then
				create s.make_empty
				create vis.make (s)
				l_feed.accept (vis)
				print (s)

				create s8.make_empty
				create gen.make (s8)
				l_feed.accept (gen)
				print (s8)

				create s8.make_empty
				create atom_gen.make (s8)
				l_feed.accept (atom_gen)
				print (s8)

			end
		end

	test_web (a_url: READABLE_STRING_8)
		local
			cl: LIBCURL_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
		do
			create cl.make
			sess := cl.new_session (a_url)
			sess.set_is_insecure (True)
			if attached sess.get ("", Void) as resp then
				if
					not resp.error_occurred and then
					attached resp.body as l_feed
				then
					test_feed (l_feed)
				end
			end
		end

end
