note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	MICRODATA_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines


	test_01 do test_microdata (ex_01, ex_01_md) end
	test_02	do test_microdata (ex_02, ex_02_md) end
	test_03	do test_microdata (ex_03, ex_03_md) end
	test_04	do test_microdata (ex_04, ex_04_md) end
	test_05	do test_microdata (ex_05, ex_05_md) end
	test_06	do test_microdata (ex_06, ex_06_md) end
	test_07	do test_microdata (ex_07, ex_07_md) end
	test_07_html
		do
				-- This should fail, since the html parser
				-- is not flexible enough with non-closing element such as dt, dd ..
			test_microdata (ex_07_html, ex_07_html_md)
		end
	test_08	do test_microdata (ex_08, ex_08_md) end
	test_09	do test_microdata (ex_09, ex_09_md) end
	test_10	do test_microdata (ex_10, ex_10_md) end

	test_full_md
		local
			loader: MD_LOADER
		do
			create loader.make_with_string (schema_org_full_md)
			if attached loader.microdata as md then
				test_microdata (schema_org_full_md, md)
			else
				assert ("valid xml", False)
			end
		end

	test_microdata (a_html: STRING; a_md: MD_DOCUMENT)
			-- New test routine
		local
			loader: MD_LOADER
		do
			create loader.make_with_string (a_html)
			if attached loader.microdata as md then
				assert ("ok", same_metadata (md, a_md))
			else
				assert ("valid xml", False)
			end

--			http://www.wdl.org/en/item/1/
		end

	same_metadata (md,md_exp: MD_DOCUMENT): BOOLEAN
		local
			dbg: MD_DEBUG_ITERATOR
			s, s_exp: STRING_32
		do
			create s.make_empty
			create dbg.make (s)
			md.accept (dbg)

			create s_exp.make_empty
			create dbg.make (s_exp)
			md_exp.accept (dbg)

			Result := s.same_string (s_exp)
		end

feature -- Data		

	ex_01_md: MD_DOCUMENT
		local
			i,subi: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make ("http://schema.org/Product")
			Result.put (i)
			create p.make ("name", "Panasonic White 60L Refrigerator", Void)
			i.put (p)
			create subi.make_with_name ("aggregateRating", "http://schema.org/AggregateRating")
			i.put (subi)
			create p.make ("ratingValue", "Rated 3.5/5", Void)
			subi.put (p)
			create p.make ("reviewCount", "11", Void)
			subi.put (p)
		end

	ex_01: STRING
		do
			Result := "[
						<html>
						<body>
						 <div itemscope itemtype='http://schema.org/Product'>
						  <span itemprop="name">Panasonic White 60L Refrigerator</span>
						  <img src="panasonic-fridge-60l-white.jpg" alt="">
						   <div itemprop="aggregateRating"
						       itemscope itemtype="http://schema.org/AggregateRating">
						    <meter itemprop="ratingValue" min=0 value=3.5 max=5>Rated 3.5/5</meter>
						    (based on <span itemprop="reviewCount">11</span> customer reviews)
						   </div>
						 </div>
						 </body>
						</html>
			]"
		end

	ex_02_md: MD_DOCUMENT
		local
			i, subi: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make (Void)
			Result.put (i)

			create p.make ("name", "Amanda", Void)
			i.put (p)
			create subi.make_with_name ("band", Void)
			i.put (subi)

			create p.make ("name", "Jazz Band", Void)
			subi.put (p)
			create p.make ("size", "12", Void)
			subi.put (p)
		end

	ex_02: STRING
		do
			Result := "[
						<div itemscope>
 							<p>Name: <span itemprop="name">Amanda</span></p>
 							<p>Band: <span itemprop="band" itemscope> <span itemprop="name">Jazz Band</span> (<span itemprop="size">12</span> players)</span></p>
						</div>
					]"
		end

	ex_03_md: MD_DOCUMENT
		local
			i: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make (Void)
			Result.put (i)

			create p.make ("birthday", "2009-05-10", Void)
			i.put (p)
		end


	ex_03: STRING
		do
			Result := "[
						<div itemscope>
 							I was born on <time itemprop="birthday" datetime="2009-05-10">May 10th 2009</time>.
						</div>
					]"
		end

	ex_04_md: MD_DOCUMENT
		local
			i: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make (Void)
			Result.put (i)

			create p.make ("favorite-color", "orange", Void)
			i.put (p)
			create p.make ("favorite-fruit", "orange", Void)
			i.put (p)
		end

	ex_04: STRING
		do
			Result := "[
						<div itemscope>
 							<span itemprop="favorite-color favorite-fruit">orange</span>
						</div>
					]"
		end

	ex_05_md: MD_DOCUMENT
		local
			i: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make (Void)
			Result.put (i)

			create p.make ("flavor", "Lemon sorbet", Void)
			i.put (p)
			create p.make ("flavor", "Apricot sorbet", Void)
			i.put (p)
		end

	ex_05: STRING
		do
			Result := "[
						<div itemscope>
						 <p>Flavors in my favorite ice cream:</p>
						 <ul>
						  <li itemprop="flavor">Lemon sorbet</li>
						  <li itemprop="flavor">Apricot sorbet</li>
						 </ul>
						</div>
					]"
		end

	ex_06_md: MD_DOCUMENT
		local
			i: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make ("http://example.org/animals#cat")
			Result.put (i)

			create p.make ("name", "Hedral", Void)
			i.put (p)
			create p.make ("desc", "Hedral is a male american domestic shorthair, with a fluffy black fur with white paws and belly.", Void)
			i.put (p)
			create p.make ("img", "hedral.jpeg", Void)
			i.put (p)
		end

	ex_06: STRING
		do
			Result := "[		
						<section itemscope itemtype="http://example.org/animals#cat">
						 <h1 itemprop="name">Hedral</h1>
						 <p itemprop="desc">Hedral is a male american domestic shorthair, with a fluffy black fur with white paws and belly.</p>
						 <img itemprop="img" src="hedral.jpeg" alt="" title="Hedral, age 18 months">
						</section>
					]"
		end

	ex_07_md, ex_07_html_md: MD_DOCUMENT
		local
			i: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make ("http://vocab.example.net/book")
			i.set_identifier ("urn:isbn:0-330-34032-8")
			Result.put (i)

			create p.make ("title", "The Reality Dysfunction", Void)
			i.put (p)
			create p.make ("author", "Peter F. Hamilton", Void)
			i.put (p)
			create p.make ("pubdate", "1996-01-26", Void)
			i.put (p)
		end

	ex_07_html: STRING
		do
			Result := "[		
						<dl itemscope
						    itemtype="http://vocab.example.net/book"
						    itemid="urn:isbn:0-330-34032-8">
						 <dt>Title
						 <dd itemprop="title">The Reality Dysfunction
						 <dt>Author
						 <dd itemprop="author">Peter F. Hamilton
						 <dt>Publication date
						 <dd><time itemprop="pubdate" datetime="1996-01-26">26 January 1996</time>
						</dl>
					]"
		end

	ex_07: STRING
		do
			Result := "[		
						<dl itemscope
						    itemtype="http://vocab.example.net/book"
						    itemid="urn:isbn:0-330-34032-8">
						 <dt>Title</dt>
						 <dd itemprop="title">The Reality Dysfunction</dd>
						 <dt>Author</dt>
						 <dd itemprop="author">Peter F. Hamilton</dd>
						 <dt>Publication date</dt>
						 <dd><time itemprop="pubdate" datetime="1996-01-26">26 January 1996</time></dd>
						</dl>
					]"
		end

	ex_08_md: MD_DOCUMENT
		local
			i, subi: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make ("http://vocab.example.net/book")
			i.set_identifier ("urn:isbn:0-330-34032-8")
			Result.put (i)

			create p.make ("title", "The Reality Dysfunction", Void)
			i.put (p)
			create subi.make_with_name ("author", Void)
			i.put (subi)

			create p.make ("name", "Peter F. Hamilton", Void)
			subi.put (p)
			create p.make ("country", "UK", Void)
			subi.put (p)

			subi := subi.deep_twin
			subi.set_name ("writer")
			i.put (subi)

			create p.make ("pubdate", "1996-01-26", Void)
			i.put (p)
		end

	ex_08: STRING
		do
			Result := "[		
						<dl itemscope
						    itemtype="http://vocab.example.net/book"
						    itemid="urn:isbn:0-330-34032-8">
						 <dt>Title</dt>
						 <dd itemprop="title">The Reality Dysfunction</dd>
						 <dt>Author</dt>
						 <dd itemscope itemprop="author writer">
						 	<span itemprop="name">Peter F. Hamilton</span>
						 	<span itemprop="country">UK</span>
						 </dd>
						 <dt>Publication date</dt>
						 <dd><time itemprop="pubdate" datetime="1996-01-26">26 January 1996</time></dd>
						</dl>
					]"
		end

	ex_09_md: MD_DOCUMENT
		local
			i, subi: MD_ITEM
			p: MD_PROPERTY
		do
			create Result.make
			create i.make ("http://vocab.example.net/book")
			i.set_identifier ("urn:isbn:0-330-34032-8")
			Result.put (i)

			create p.make ("title", "The Reality Dysfunction", Void)
			i.put (p)

			create subi.make (Void)
			Result.put (subi)
			create p.make ("name", "Peter F. Hamilton", Void)
			subi.put (p)
			create p.make ("country", "UK", Void)
			subi.put (p)

			create p.make ("pubdate", "1996-01-26", Void)
			i.put (p)
		end

	ex_09: STRING
		do
			Result := "[		
						<dl itemscope
						    itemtype="http://vocab.example.net/book"
						    itemid="urn:isbn:0-330-34032-8">
						 <dt>Title</dt>
						 <dd itemprop="title">The Reality Dysfunction</dd>
						 <dt>Author</dt>
						 <dd itemscope>
						 	<span itemprop="name">Peter F. Hamilton</span>
						 	<span itemprop="country">UK</span>
						 </dd>
						 <dt>Publication date</dt>
						 <dd><time itemprop="pubdate" datetime="1996-01-26">26 January 1996</time></dd>
						</dl>
					]"
		end

	ex_10_md: MD_DOCUMENT
		local
			i: MD_ITEM
			p: MD_PROPERTY
			id_node: MD_ID_NODE
		do
			create Result.make
			create i.make ("http://n.whatwg.org/work")
			i.add_reference ("licenses")
			Result.put (i)
			create p.make ("work", "images/house.jpeg", Void)
			i.put (p)
			create p.make ("title", "The house I found.", Void)
			i.put (p)

			create i.make ("http://n.whatwg.org/work")
			i.add_reference ("licenses")
			Result.put (i)
			create p.make ("work", "images/mailbox.jpeg", Void)
			i.put (p)
			create p.make ("title", "The mailbox.", Void)
			i.put (p)

			create id_node.make ("licenses")
			Result.register_id_node (id_node)
			create p.make ("license", "http://www.opensource.org/licenses/mit-license.php", Void)
			id_node.put (p)
		end

	ex_10: STRING
		do
			Result := "[
						<!DOCTYPE HTML>
						<html>
						 <head>
						  <title>Photo gallery</title>
						 </head>
						 <body>
						  <h1>My photos</h1>
						  <figure itemscope itemtype="http://n.whatwg.org/work" itemref="licenses">
						   <img itemprop="work" src="images/house.jpeg" alt="A white house, boarded up, sits in a forest."/>
						   <figcaption itemprop="title">The house I found.</figcaption>
						  </figure>
						  <figure itemscope itemtype="http://n.whatwg.org/work" itemref="licenses">
						   <img itemprop="work" src="images/mailbox.jpeg" alt="Outside the house is a mailbox. It has a leaflet inside."/>
						   <figcaption itemprop="title">The mailbox.</figcaption>
						  </figure>
						  <footer>
						   <p id="licenses">All images licensed under the <a itemprop="license"
						   href="http://www.opensource.org/licenses/mit-license.php">MIT
						   license</a>.</p>
						  </footer>
						 </body>
						</html>
				]"
		end

	schema_org_full_md: STRING
		local
			f: PLAIN_TEXT_FILE
		do
			create Result.make_empty
			Result.append ("<div>")

			create f.make_with_name ("schema_org_full_md.html")
			if f.exists then
				f.open_read
				from

				until
					f.exhausted
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
			Result.append ("</div>")
		end


	ex_0: STRING
		do
			Result := "[
					]"
		end

end


