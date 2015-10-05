note
	description: "Summary description for {RSS_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RSS_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_rss_2
			-- New test routine
		local
			feed_parser: FEED_DEFAULT_PARSERS
			vis: FEED_TO_STRING_32_VISITOR
			s: STRING_32
		do
			create feed_parser
			if attached feed_parser.feed_from_string (rss_2_string_1) as l_feed then
				create s.make_empty
				create vis.make (s)
				l_feed.accept (vis)
				print (s)
				assert ("not_implemented", False)
			end
			assert ("not_implemented", False)
		end

feature {NONE} -- Data

	rss_2_string_1: STRING = "[
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
    <channel>
        <title>Mon site</title>
        <description>Ceci est un exemple de flux RSS 2.0</description>
        <lastBuildDate>Sat, 07 Sep 2002 00:00:01 GMT</lastBuildDate>
        <link>http://www.example.org</link>
        <item>
            <title>Post N1</title>
            <description>This is my first post</description>
            <pubDate>Sat, 07 Sep 2002 00:00:01 GMT</pubDate>
            <link>http://www.example.org/actu1</link>
        </item>
        <item>
            <title>Post N2</title>
            <description>This is my second post</description>
            <pubDate>Sat, 07 Sep 2002 00:00:01 GMT</pubDate>
            <link>http://www.example.org/actu2</link>
        </item>
    </channel>
</rss>
	]"
end


