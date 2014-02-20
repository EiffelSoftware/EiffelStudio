note
	description: "Summary description for {TEST_PARSER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_PARSER

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	file_as_string_mode: BOOLEAN
		do
			Result := attached get ("TEST_XML_PARSER_KIND") as e and then e.is_case_insensitive_equal ("string")
		end

	get_parser_mode
		do
			print ("Executing: " + command_line.command_line + "%N")

			parser_mode := null_mode
			if attached get ("TEST_XML_PARSER") as m then
				m.to_lower
				if m ~ "debug" then
					parser_mode := debug_mode
				elseif m ~ "tree" then
					parser_mode := tree_mode
				elseif m ~ "xml_tree" then
					parser_mode := xml_tree_mode
				elseif m ~ "xml_tree_vis" then
					parser_mode := xml_tree_vis_mode
				end
			end
			print ("Test xml Parser mode: " + parser_mode_meaning + "%N")
			print ("%TSet environment variable TEST_XML_PARSER to change behavior.%N")
			print ("%Tavailable values: null (default), debug, tree, xml_tree, xml_tree_vis%N")

			print ("Xml Parser kind: " + file_as_string_mode_meaning + "%N")
			print ("%TSet environment variable TEST_XML_PARSER_KIND to change behavior.%N")
			print ("%Tavailable values: string, file (default)%N")
			print ("%N")
		end

	short_description: STRING
		local
			s: STRING
		do
			create Result.make_empty
			s := command_line.command_name.string
			Result.append_string (s)
			Result.append_character (':')
			Result.append_character (' ')

			if file_as_string_mode then
				s := "STRING"
			else
				s := "FILE"
			end

			Result.append_string (s)
			Result.append_character ('+')

			inspect
				parser_mode
			when null_mode then
				s := "NULL"
			when debug_mode then
				s := "DEBUG"
			when tree_mode then
				s := "TREE"
			when xml_tree_mode then
				s := "XML_TREE"
			when xml_tree_vis_mode then
				s := "XML_TREE_VIS"
			else
				s := "NULL"
			end
			Result.append_string (s)
		end

	file_as_string_mode_meaning: STRING
		do
			if file_as_string_mode then
				Result := "string: read content of file, then parse string"
			else
				Result := "file: parse file directly"
			end
		end

	parser_mode: INTEGER

	parser_mode_meaning: STRING
		do
			inspect
				parser_mode
			when null_mode then
				Result := "NULL: only parser, no callbacks"
			when debug_mode then
				Result := "DEBUG: callbacks with debug output"
			when tree_mode then
				Result := "TREE: building a tree (document)"
			when xml_tree_mode then
				Result := "XML_TREE: building a (xml_dom) tree (document)"
			when xml_tree_vis_mode then
				Result := "XML_TREE_VIS: building a (xml_dom) tree (document) + print via Visitor"
			else
				Result := "NULL: only parser, no callbacks"
			end
		end

	null_mode: INTEGER = 0

	debug_mode: INTEGER = 1

	tree_mode: INTEGER = 2

	xml_tree_mode: INTEGER = 3

	xml_tree_vis_mode: INTEGER = 4

	filename: detachable STRING
		local
			args: ARGUMENTS
			ht: HASH_TABLE [STRING, INTEGER]
			s: STRING
			i: INTEGER
			dn: DIRECTORY_NAME
		do
			create args
			if args.argument_count > 0 then
				Result := args.argument (1)
			else
				create ht.make (10)
				ht.force ("C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\en\mscorlib.xml", 1)
				ht.force ("C:\temp\test.xml", 2)
				if attached get ("EIFFEL_SRC") as eiffel_src then
					ht.force (eiffel_src + "\Eiffel\Ace\ec.ecf", 3)
				end
				create dn.make_from_string (current_working_directory)
				dn.extend ("data")
				ht.force (dn.string, 4)

--				ht.force ("C:\_dev\trunk\Src\framework\xml\tests\data\xmlconf\xmltest\valid\sa\087.xml", 5)


				from
					ht.start
				until
					ht.after
				loop
					print (ht.key_for_iteration.out + ": " + ht.item_for_iteration + "%N")
					ht.forth
				end
				from
					i := 0
				until
					i /= 0
				loop
					print (" Choice? ")
					io.read_line
					s := io.last_string
					if s.is_integer then
						i := s.to_integer
						if ht.has (i) then
							Result := ht.item (i)
						else
							i := 0
						end
					end
				end
			end
		end

	file_content (fn: STRING): STRING
		local
			f: RAW_FILE
			p: INTEGER
		do
			create f.make (fn)
			f.open_read
			f.read_stream (f.count)
			Result := f.last_string
			f.close
			p := Result.index_of ('<', 1)
			Result := Result.substring (p, Result.count)
		end

	t1, t2: detachable TIME

	report_chrono
		local
			duration: TIME_DURATION
		do
			if attached t1 as l_t1 and attached t2 as l_t2 then
				duration := l_t2.relative_duration (l_t1)
				print ("CHRONO " + short_description + " " + duration.minute.out + " minutes " + duration.fine_second.out + " fine seconds.%N")
			end
		end

	start_chrono
		do
			create t1.make_now
			t2 := Void
		end

	stop_chrono
		do
			create t2.make_now
		end

feature -- Test

	test (fn: STRING)
		local
			dir: DIRECTORY
		do
			create dir.make (fn)
			if dir.exists then
				if attached xml_files (fn) as filenames then
					from
						filenames.start
					until
						filenames.after
					loop
						test_entry (filenames.item)
						filenames.forth
					end
				end
			else
				test_entry (fn)
			end
		end

	test_entry (fn: STRING)
		local
			vis: detachable XML_NODE_VISITOR_PRINT
		do
			if file_as_string_mode then
				test_file_content (fn)
			else
				test_file (fn)
			end

			after_test_entry (fn)

			report_chrono
		end

	after_test_entry (fn: STRING)
		deferred
		end

	test_file (fn: STRING)
		deferred
		end

	test_file_content (fn: STRING)
		deferred
		end

feature -- Files

	xml_files (n: READABLE_STRING_GENERAL): ARRAYED_LIST [STRING]
		local
			d: DIRECTORY
			fn: PATH
		do
			create d.make (n)
			if d.exists then
				create Result.make (10)
				d.open_read
				from
					d.start
					d.readentry
				until
					d.lastentry = Void
				loop
					if
						attached d.lastentry as i and then
						not i.is_empty and then
						i.item (1) /= '.'
					then
						create fn.make_from_string (n)
						fn := fn.extended (i)
						Result.append (xml_files (fn.name))
					end
					d.readentry
				end
				d.close
			elseif n.substring (n.count - 3, n.count).same_string (".xml") then
				create Result.make (1)
				Result.extend (n.to_string_8)
			else
				create Result.make (0)
			end
		end

feature -- Access

	char (c: INTEGER): CHARACTER
		do
			Result := c.to_character_8
		end

	html_entity_mapping: HASH_TABLE [CHARACTER, STRING]
		local
			map: like html_entity_mapping
		once
			create map.make (101)
				-- Required
			map.force ('&', "&amp;")
			map.force ('"', "&quot;")
			map.force ('<', "&lt;")
			map.force ('>', "&gt;")

				-- Optional
			map.force (char(128), "&euro;")
			map.force (char(156), "&oelig;")
			map.force (char(159), "&Yuml;")
			map.force (char(160), "&nbps;")
			map.force (char(161), "&iexcl;")
			map.force (char(162), "&cent;")
			map.force (char(163), "&pound;")
			map.force (char(164), "&curren;")
			map.force (char(165), "¥")
			map.force (char(166), "&brvbar;")
			map.force (char(167), "&sect;")
			map.force (char(168), "&uml;")
			map.force (char(169), "&copy;")
			map.force (char(170), "&ordf;")
			map.force (char(171), "&laquo;")
			map.force (char(172), "&not;")
			map.force (char(173), "&shy;")
			map.force (char(174), "&reg;")
			map.force (char(175), "&masr;")
			map.force (char(176), "&deg;")
			map.force (char(177), "&plusmn;")
			map.force (char(178), "&sup2;")
			map.force (char(179), "&sup3;")
			map.force (char(180), "&acute;")
			map.force (char(181), "&micro;")
			map.force (char(182), "&para;")
			map.force (char(183), "&middot;")
			map.force (char(184), "&cedil;")
			map.force (char(185), "&sup1;")
			map.force (char(186), "&ordm;")
			map.force (char(187), "&raquo;")
			map.force (char(188), "&frac14;")
			map.force (char(189), "&frac12;")
			map.force (char(190), "&frac34;")
			map.force (char(191), "&iquest;")
			map.force (char(192), "&Agrave;")
			map.force (char(193), "&Aacute;")
			map.force (char(194), "&Acirc;")
			map.force (char(195), "&Atilde;")
			map.force (char(196), "&Auml;")
			map.force (char(197), "&Aring;")
			map.force (char(198), "&AElig")
			map.force (char(199), "&Ccedil;")
			map.force (char(200), "&Egrave;")
			map.force (char(201), "&Eacute;")
			map.force (char(202), "&Ecirc;")
			map.force (char(203), "&Euml;")
			map.force (char(204), "&Igrave;")
			map.force (char(205), "&Iacute;")
			map.force (char(206), "&Icirc;")
			map.force (char(207), "&Iuml;")
			map.force (char(208), "&eth;")
			map.force (char(209), "&Ntilde;")
			map.force (char(210), "&Ograve;")
			map.force (char(211), "&Oacute;")
			map.force (char(212), "&Ocirc;")
			map.force (char(213), "&Otilde;")
			map.force (char(214), "&Ouml;")
			map.force (char(215), "&times;")
			map.force (char(216), "&Oslash;")
			map.force (char(217), "&Ugrave;")
			map.force (char(218), "&Uacute;")
			map.force (char(219), "&Ucirc;")
			map.force (char(220), "&Uuml;")
			map.force (char(221), "&Yacute;")
			map.force (char(222), "&thorn;")
			map.force (char(223), "&szlig;")
			map.force (char(224), "&agrave;")
			map.force (char(225), "&aacute;")
			map.force (char(226), "&acirc;")
			map.force (char(227), "&atilde;")
			map.force (char(228), "&auml;")
			map.force (char(229), "&aring;")
			map.force (char(230), "&aelig;")
			map.force (char(231), "&ccedil;")
			map.force (char(232), "&egrave;")
			map.force (char(233), "&eacute;")
			map.force (char(234), "&ecirc;")
			map.force (char(235), "&euml;")
			map.force (char(236), "&igrave;")
			map.force (char(237), "&iacute;")
			map.force (char(238), "&icirc;")
			map.force (char(239), "&iuml;")
			map.force (char(240), "&eth;")
			map.force (char(241), "&ntilde;")
			map.force (char(242), "&ograve;")
			map.force (char(243), "&oacute;")
			map.force (char(244), "&ocirc;")
			map.force (char(245), "&otilde;")
			map.force (char(246), "&ouml;")
			map.force (char(247), "&divide;")
			map.force (char(248), "&oslash;")
			map.force (char(249), "&ugrave;")
			map.force (char(250), "&uacute;")
			map.force (char(251), "&ucirc;")
			map.force (char(252), "&uuml;")
			map.force (char(253), "&yacute;")
			map.force (char(254), "&thorn;")
			map.force (char(255), "&yuml;")
			Result := map
		end

	text: STRING = "[
<document>
	<section name="test" format="foo&gt;bar">
		<title format="foobar"   >This is a title &amp; &quot;nothing&quot; else !</title>
		<!-- test comments "toto" <tralala> This is a comment &amp; &quot;nothing&quot; else !  <//>
		char123={=&#123;
		char64=@=&#64;

				-- Required
			map.force ('&', "&amp;")
			map.force ('"', "&quot;")
			map.force ('<', "&lt;")
			map.force ('>', "&gt;")


		-->
		<test/>
		<foobar1/>
		<foobar2 />
		<foobar3></foobar3>
	</section>
</document>
	]"

	text_entity: STRING = "[
<document>
	<section name="test" format="foo&gt;bar">
		<title format="foobar"   >This is a title &amp; &quot;nothing&quot; else !</title>
		<!-- test comments "toto" <tralala> This is a comment &amp; &quot;nothing&quot; else !  <//>
		char123={=&#123;
		char64=@=&#64;

				-- Required
			map.force ('&', "&amp;")
			map.force ('"', "&quot;")
			map.force ('<', "&lt;")
			map.force ('>', "&gt;")

				-- Optional
			map.force (char(128), "&euro;")
			map.force (char(156), "&oelig;")
			map.force (char(159), "&Yuml;")
			map.force (char(160), "&nbps;")
			map.force (char(161), "&iexcl;")
			map.force (char(162), "&cent;")
			map.force (char(163), "&pound;")
			map.force (char(164), "&curren;")
			map.force (char(165), "¥")
			map.force (char(166), "&brvbar;")
			map.force (char(167), "&sect;")
			map.force (char(168), "&uml;")
			map.force (char(169), "&copy;")
			map.force (char(170), "&ordf;")
			map.force (char(171), "&laquo;")
			map.force (char(172), "&not;")
			map.force (char(173), "&shy;")
			map.force (char(174), "&reg;")
			map.force (char(175), "&masr;")
			map.force (char(176), "&deg;")
			map.force (char(177), "&plusmn;")
			map.force (char(178), "&sup2;")
			map.force (char(179), "&sup3;")
			map.force (char(180), "&acute;")
			map.force (char(181), "&micro;")
			map.force (char(182), "&para;")
			map.force (char(183), "&middot;")
			map.force (char(184), "&cedil;")
			map.force (char(185), "&sup1;")
			map.force (char(186), "&ordm;")
			map.force (char(187), "&raquo;")
			map.force (char(188), "&frac14;")
			map.force (char(189), "&frac12;")
			map.force (char(190), "&frac34;")
			map.force (char(191), "&iquest;")
			map.force (char(192), "&Agrave;")
			map.force (char(193), "&Aacute;")
			map.force (char(194), "&Acirc;")
			map.force (char(195), "&Atilde;")
			map.force (char(196), "&Auml;")
			map.force (char(197), "&Aring;")
			map.force (char(198), "&AElig;")
			map.force (char(199), "&Ccedil;")
			map.force (char(200), "&Egrave;")
			map.force (char(201), "&Eacute;")
			map.force (char(202), "&Ecirc;")
			map.force (char(203), "&Euml;")
			map.force (char(204), "&Igrave;")
			map.force (char(205), "&Iacute;")
			map.force (char(206), "&Icirc;")
			map.force (char(207), "&Iuml;")
			map.force (char(208), "&eth;")
			map.force (char(209), "&Ntilde;")
			map.force (char(210), "&Ograve;")
			map.force (char(211), "&Oacute;")
			map.force (char(212), "&Ocirc;")
			map.force (char(213), "&Otilde;")
			map.force (char(214), "&Ouml;")
			map.force (char(215), "&times;")
			map.force (char(216), "&Oslash;")
			map.force (char(217), "&Ugrave;")
			map.force (char(218), "&Uacute;")
			map.force (char(219), "&Ucirc;")
			map.force (char(220), "&Uuml;")
			map.force (char(221), "&Yacute;")
			map.force (char(222), "&thorn;")
			map.force (char(223), "&szlig;")
			map.force (char(224), "&agrave;")
			map.force (char(225), "&aacute;")
			map.force (char(226), "&acirc;")
			map.force (char(227), "&atilde;")
			map.force (char(228), "&auml;")
			map.force (char(229), "&aring;")
			map.force (char(230), "&aelig;")
			map.force (char(231), "&ccedil;")
			map.force (char(232), "&egrave;")
			map.force (char(233), "&eacute;")
			map.force (char(234), "&ecirc;")
			map.force (char(235), "&euml;")
			map.force (char(236), "&igrave;")
			map.force (char(237), "&iacute;")
			map.force (char(238), "&icirc;")
			map.force (char(239), "&iuml;")
			map.force (char(240), "&eth;")
			map.force (char(241), "&ntilde;")
			map.force (char(242), "&ograve;")
			map.force (char(243), "&oacute;")
			map.force (char(244), "&ocirc;")
			map.force (char(245), "&otilde;")
			map.force (char(246), "&ouml;")
			map.force (char(247), "&divide;")
			map.force (char(248), "&oslash;")
			map.force (char(249), "&ugrave;")
			map.force (char(250), "&uacute;")
			map.force (char(251), "&ucirc;")
			map.force (char(252), "&uuml;")
			map.force (char(253), "&yacute;")
			map.force (char(254), "&thorn;")
			map.force (char(255), "&yuml;")


		-->
		<test/>
		<foobar1/>
		<foobar2 />
		<foobar3></foobar3>
	</section>
</document>
	]"


	text_ecf: STRING = "[
<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-6-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-6-0 http://www.eiffel.com/developers/xml/configuration-1-6-0.xsd" name="xml_parser" uuid="40FBC226-EDFE-4C19-B0C0-8AD8AF17AD05">
	<target name="xml_parser">
		<root class="XML_PARSER" feature="make"/>
		<setting name="console_application" value="true"/>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
		<cluster name="xml_parser" location=".\"/>
	</target>
</system>
	]"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
