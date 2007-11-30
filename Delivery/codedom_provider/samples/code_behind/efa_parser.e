indexing
	description: "Can format Eiffel for ASP.NET page into colored HTML."
	note:	"The page should user lower case for all tags and include: %
					%- <title>...</title: for `page_title' to be initialized properly%
					%- indexing description: %"...%": for `page_description' to be initialized properly"

class
	EFA_PARSER

feature -- Basic Operation(s)

	parse (a_file_path: STRING) is
			-- Parse content of Eiffel for ASP.NET file `a_file_path'.
			-- Set `formatted_html', `page_title' and `page_description' accordingly.
		local
			l_source, l_tag: STRING
			i, l_count, l_index: INTEGER
			l_in_tag, l_retried: BOOLEAN
			l_sample_file: PLAIN_TEXT_FILE
		do
			parse_successful := False
			internal_formatted_html := Void
			internal_page_title := Void
			internal_page_description := Void
			if not l_retried then
				create l_sample_file.make (a_file_path)
				if l_sample_file.exists then
					l_sample_file.open_read
					l_sample_file.read_stream (l_sample_file.count)
					l_source := {WEB_HTTP_UTILITY}.html_encode (l_sample_file.last_string)
					l_sample_file.close
					l_count := l_source.count
					create internal_formatted_html.make (l_count)
					from
						i := 1
					until
						i > l_count
					loop
						if l_in_tag then
							if is_end_tag (l_source, i) then
								l_in_tag := false
								l_tag.append_character (l_source.item (i))
								internal_formatted_html.append (formatted_tag (l_tag))
								if l_tag.is_equal ("&lt;script runat=&quot;server&quot;&gt;") then
									l_index := l_source.substring_index ("&lt;/script&gt;", i + 1)
									if l_index > 0 then
										internal_formatted_html.append (eiffel_format (l_source.substring (i + 1, l_index - 1)))
										i := l_index - 1
									end
								elseif l_tag.is_equal ("&lt;title&gt;") then
									l_index := l_source.substring_index ("&lt;/title&gt;", i + 1)
									if l_index > 0 then
										internal_page_title := l_source.substring (i + 1, l_index - 1)
									end
								end
							else
								l_tag.append_character (l_source.item (i))
							end
						else
							l_in_tag := is_start_tag (l_source, i)
							if l_in_tag then
								create l_tag.make (50)
								l_tag.append ("&lt;")
								internal_formatted_html.keep_head (internal_formatted_html.count - 3) -- Remove "&lt" from `internal_formatted_html'
							else
								internal_formatted_html.append_character (l_source.item (i))
							end
						end
						i := i + 1
					end
					internal_formatted_html.replace_substring_all ("%T", "&nbsp;&nbsp;&nbsp;")
					internal_formatted_html.replace_substring_all ("%R%N", "<br />")
					internal_formatted_html.replace_substring_all ("%N", "<br />")
					internal_page_description := subtext (l_source, "description: %"", "%"")
					if internal_page_title = Void then
						internal_page_title := ""
					end
					parse_successful := True
				end
			end
		ensure
			attached_formatted_html_iff_successful: parse_successful = (formatted_html /= Void)
			attached_page_title_iff_successful: parse_successful = (page_title /= Void)
			attached_page_description_iff_successful: parse_successful = (page_description /= Void)
		rescue
			l_retried := True
			retry
		end

feature -- Status Report

	parse_successful: BOOLEAN
			-- Was last call to `parse' successful?

feature -- Access
		
	formatted_html: STRING is
			-- HTML page representing source code
		require
			parsed: parse_successful
		do
			Result := internal_formatted_html
		end

	page_title: STRING is
			-- Last parsed page title
		require
			parsed: parse_successful
		do
			Result := internal_page_title
		end

	page_description: STRING is
			-- Last parsed page description
		require
			parsed: parse_successful
		do
			Result := internal_page_description
		end

feature {NONE} -- Implementation

	internal_formatted_html, internal_page_title, internal_page_description: STRING
			-- Parse results

	is_end_tag (a_source: STRING; a_index: INTEGER): BOOLEAN is
			-- Is character at index `a_index' in `a_source' closing html tag?
		require
			attached_source: a_source /= void
			valid_index: a_index > 0 and a_index <= a_source.count
		do
			if a_index > 3 then
				Result := a_source.item (a_index) = ';' and
							a_source.item (a_index - 1) = 't' and
							a_source.item (a_index - 2) = 'g' and
							a_source.item (a_index - 3) = '&'
			end
		end

	is_start_tag (a_source: STRING; a_index: INTEGER): BOOLEAN is
			-- Is character at index `a_index' in `a_source' opening html tag?
		require
			attached_source: a_source /= void
			valid_index: a_index > 0 and a_index <= a_source.count
		do
			if a_index > 3 then
				Result := a_source.item (a_index) = ';' and
							a_source.item (a_index - 1) = 't' and
							a_source.item (a_index - 2) = 'l' and
							a_source.item (a_index - 3) = '&'
			end
		end

	formatted_tag (a_tag: STRING): STRING is
			-- Use `Html_formats' to format tag.
			-- `a_tag' can be of the form '!doctype' or '/table' or 'br /' or 'a href=...'
		require
			attached_tag: a_tag /= void
			valid_tag: a_tag.substring (1, 4).is_equal ("&lt;") and 
					a_tag.substring (a_tag.count - 3, a_tag.count).is_equal ("&gt;")
		local
			i, l_count, l_index: INTEGER
			c: CHARACTER
			l_tag: STRING
			l_in_tag: BOOLEAN
		do
			l_count := a_tag.count
			if a_tag.substring (1, 7).is_equal ("&lt;!--") and
						a_tag.substring (l_count - 5, l_count).is_equal ("--&gt;") then
					-- Special case for comments
				create Result.make (a_tag.count + 30)
				Result.append ("<span class=%"comments%">")
				Result.append (a_tag)
				Result.append ("</span>")
			else
				create Result.make (l_count + 30)
				if a_tag.item (5) = '/' then
					Result.append ("<span class=%"html_1%">&lt;/</span>")
					i := 6
				else
					Result.append ("<span class=%"html_1%">&lt;</span>")
					i := 5
				end
				from
				until
					i > l_count - 4
				loop
					c := a_tag.item (i)
					if l_in_tag then
						if is_quote_start (a_tag, i) then
							l_index := a_tag.substring_index ("&quot;", i + 1)
							if l_index > 0 then
								Result.keep_head (Result.count - 1) -- Remove "&" from Result
								Result.append ("<span class=%"quote%">&quot;")
								Result.append (a_tag.substring (i + 1, l_index - 1))
								Result.append ("&quot;</span>")
								i := l_index + 5
							end
							l_tag.wipe_out -- Remove "quot" from tag content
						elseif not c.is_alpha_numeric and c /= '!' and c /= '-' then
							l_in_tag := false
							Html_formats.search (l_tag)
							if Html_formats.found then
								Result.append (Html_formats.found_item)
							else
								Result.append (l_tag)
							end
							Result.append_character (c)
						else
							l_tag.append_character (c)
						end
					else
						l_in_tag := c.is_alpha_numeric or c = '!' or c = '-'
						if l_in_tag then
							create l_tag.make (50)
							l_tag.append_character (c)
						else
							Result.append_character (c)
						end
					end
					i := i + 1
				end
				if l_in_tag then
					Html_formats.search (l_tag)
					if Html_formats.found then
						Result.append (Html_formats.found_item)
					else
						Result.append (l_tag)
					end
				end
				Result.append ("<span class=%"html_1%">&gt;</span>")
			end
		end

	is_quote_start (a_tag: STRING; a_index: INTEGER): BOOLEAN is
			-- Does character at index `a_index' in `a_tag' correspond to start of HTML quote?
		require
			attached_tag: a_tag /= Void
			valid_index: a_index > 0 and a_index <= a_tag.count
		do
			if a_index > 5 then
				Result := a_tag.item (a_index) = ';' and
						a_tag.item (a_index - 1) = 't' and
						a_tag.item (a_index - 2) = 'o' and
						a_tag.item (a_index - 3) = 'u' and
						a_tag.item (a_index - 4) = 'q' and
						a_tag.item (a_index - 5) = '&' and
						a_tag.item (a_index - 6) /= '%''
			end
		end

	eiffel_format (a_source: STRING): STRING is
			-- HTML code with added css styles to HTML encoded Eiffel source `a_source'
		require
			attached_source: a_source /= void
		local
			l_in_word, l_found: BOOLEAN
			i, j, l_count, l_index: INTEGER
			c: CHARACTER
			l_word: STRING
		do
			l_count := a_source.count
			create Result.make (l_count * 2)
			create l_word.make (128)
			from
				i := 1
			until
				i > l_count
			loop
				c := a_source.item (i)
				if is_quote_start (a_source, i) then
					from
						l_index := i
						l_found := False
					until
						l_found or l_index = 0
					loop
						l_index := a_source.substring_index ("&quot;", l_index + 1)
						l_found := l_index > 0 and then a_source.item (l_index - 1) /= '%%'
					end
					
					if l_found then
						Result.keep_head (Result.count - 1) -- Remove "&" from Result
						create l_word.make (128) -- Reset content of `l_word'
						Result.append ("<span class=%"equote%">&quot;")
						Result.append (a_source.substring (i + 1, l_index - 1))
						Result.append ("&quot;</span>")
						i := l_index + 5
					end
				elseif l_in_word then
					if not c.is_alpha_numeric and c /= '_' then
						l_in_word := False
						Eiffel_formats.search (l_word)
						if Eiffel_formats.found then
							Result.append (Eiffel_formats.found_item)
						elseif l_word.is_integer then
							Result.append ("<span class=%"econstant%">")
							Result.append (l_word)
							Result.append ("</span>")
						elseif l_word.as_upper.is_equal (l_word) then
							Result.append ("<span class=%"eclass%">")
							Result.append (l_word)
							Result.append ("</span>")
						else
							Result.append (l_word)
						end
						if c = '.' then
							Result.append ("<span class=%"edot%">")
							Result.append_character ('.')
							Result.append ("</span>")
						else
							Result.append_character (c)
						end
					else
						l_word.append_character (c)
					end
				elseif c = '-' and a_source.item (i - 1) = '-' then
					j := a_source.index_of ('%N', i + 1)
					if j > 0 then
						Result.keep_head (Result.count - 1) -- Remove "-" from Result
						Result.append ("<span class=%"ecomment%">--")
						Result.append (a_source.substring (i + 1, j - 1))
						Result.append ("</span><br />")
						i := j
					else
						Result.append_character (c)
					end
				else
					l_in_word := c.is_alpha_numeric
					if l_in_word then
						create l_word.make (80)
						l_word.append_character (c)
					elseif c = '.' then
						Result.append ("<span class=%"edot%">")
						Result.append_character ('.')
						Result.append ("</span>")
					else
						Result.append_character (c)
					end
				end
				i := i + 1
			end
		ensure
			attached_code: Result /= void
		end

	subtext (a_source, a_start_tag, a_end_tag: STRING): STRING is
			-- Text in `a_source' in between `a_start_tag' and `a_end_tag'
		require
			attached_source: a_source /= void
			attached_start_tag: a_start_tag /= void
			attached_end_tag: a_end_tag /= void
		local
			l_index, l_index_2: integer
		do
			l_index := a_source.substring_index (a_start_tag, 1)
			if l_index > 0 then
				l_index_2 := a_source.substring_index (a_end_tag, l_index + a_start_tag.count)
				if l_index_2 > 0 then
					Result := a_source.substring (l_index + a_start_tag.count, l_index_2 - 1)
				end
			end
			if Result = void then
				Result := ""
			end
		ensure
			attached_text: Result /= void
		end

	Eiffel_formats: HASH_TABLE [STRING, STRING] is
			-- Eiffel keywords and corresponding formatting
		once
			create Result.make (66)

			-- Keywords
			Result.put ("<span class=%"eiffel_1%">class</span>", "class")
			Result.put ("<span class=%"eiffel_1%">deferred</span>", "deferred")
			Result.put ("<span class=%"eiffel_1%">expanded</span>", "expanded")
			Result.put ("<span class=%"eiffel_1%">feature</span>", "feature")
			Result.put ("<span class=%"eiffel_1%">indexing</span>", "indexing")
			Result.put ("<span class=%"eiffel_1%">inherit</span>", "inherit")
			Result.put ("<span class=%"eiffel_1%">separate</span>", "separate")
			Result.put ("<span class=%"eiffel_1%">agent</span>", "agent")
			Result.put ("<span class=%"eiffel_1%">alias</span>", "alias")
			Result.put ("<span class=%"eiffel_1%">all</span>", "all")
			Result.put ("<span class=%"eiffel_1%">and</span>", "and")
			Result.put ("<span class=%"eiffel_1%">as</span>", "as")
			Result.put ("<span class=%"eiffel_1%">assertion</span>", "assertion")
			Result.put ("<span class=%"eiffel_1%">create</span>", "create")
			Result.put ("<span class=%"eiffel_1%">creation</span>", "creation")
			Result.put ("<span class=%"eiffel_1%">debug</span>", "debug")
			Result.put ("<span class=%"eiffel_1%">do</span>", "do")
			Result.put ("<span class=%"eiffel_1%">exclude</span>", "exclude")
			Result.put ("<span class=%"eiffel_1%">else</span>", "else")
			Result.put ("<span class=%"eiffel_1%">elseif</span>", "elseif")
			Result.put ("<span class=%"eiffel_1%">end</span>", "end")
			Result.put ("<span class=%"eiffel_1%">export</span>", "export")
			Result.put ("<span class=%"eiffel_1%">external</span>", "external")
			Result.put ("<span class=%"eiffel_1%">from</span>", "from")
			Result.put ("<span class=%"eiffel_1%">frozen</span>", "frozen")
			Result.put ("<span class=%"eiffel_1%">if</span>", "if")
			Result.put ("<span class=%"eiffel_1%">implies</span>", "implies")
			Result.put ("<span class=%"eiffel_1%">include</span>", "include")
			Result.put ("<span class=%"eiffel_1%">infix</span>", "infix")
			Result.put ("<span class=%"eiffel_1%">inspect</span>", "inspect")
			Result.put ("<span class=%"eiffel_1%">is</span>", "is")
			Result.put ("<span class=%"eiffel_1%">like</span>", "like")
			Result.put ("<span class=%"eiffel_1%">local</span>", "local")
			Result.put ("<span class=%"eiffel_1%">loop</span>", "loop")
			Result.put ("<span class=%"eiffel_1%">not</span>", "not")
			Result.put ("<span class=%"eiffel_1%">obsolete</span>", "obsolete")
			Result.put ("<span class=%"eiffel_1%">old</span>", "old")
			Result.put ("<span class=%"eiffel_1%">once</span>", "once")
			Result.put ("<span class=%"eiffel_1%">or</span>", "or")
			Result.put ("<span class=%"eiffel_1%">override_cluster</span>", "override_cluster")
			Result.put ("<span class=%"eiffel_1%">prefix</span>", "prefix")
			Result.put ("<span class=%"eiffel_1%">redefine</span>", "redefine")
			Result.put ("<span class=%"eiffel_1%">rename</span>", "rename")
			Result.put ("<span class=%"eiffel_1%">rescue</span>", "rescue")
			Result.put ("<span class=%"eiffel_1%">retry</span>", "retry")
			Result.put ("<span class=%"eiffel_1%">select</span>", "select")
			Result.put ("<span class=%"eiffel_1%">strip</span>", "strip")
			Result.put ("<span class=%"eiffel_1%">then</span>", "then")
			Result.put ("<span class=%"eiffel_1%">undefine</span>", "undefine")
			Result.put ("<span class=%"eiffel_1%">unique</span>", "unique")
			Result.put ("<span class=%"eiffel_1%">until</span>", "until")
			Result.put ("<span class=%"eiffel_1%">visible</span>", "visible")
			Result.put ("<span class=%"eiffel_1%">when</span>", "when")
			Result.put ("<span class=%"eiffel_1%">xor</span>", "xor")

			-- DBC
			Result.put ("<span class=%"eiffel_2%">check</span>", "check")
			Result.put ("<span class=%"eiffel_2%">ensure</span>", "ensure")
			Result.put ("<span class=%"eiffel_2%">invariant</span>", "invariant")
			Result.put ("<span class=%"eiffel_2%">require</span>", "require")
			Result.put ("<span class=%"eiffel_2%">variant</span>", "variant")

			-- Reserved words
			Result.put ("<span class=%"eiffel_3%">Current</span>", "Current")
			Result.put ("<span class=%"eiffel_3%">False</span>", "False")
			Result.put ("<span class=%"eiffel_3%">Precursor</span>", "Precursor")
			Result.put ("<span class=%"eiffel_3%">Result</span>", "Result")
			Result.put ("<span class=%"eiffel_3%">True</span>", "True")
			Result.put ("<span class=%"eiffel_3%">Void</span>", "Void")
		end
	
	Html_formats: HASH_TABLE [STRING, STRING] is
			-- HTML keywords and corresponding formatting
		once
			create Result.make (224)

			-- HTML keywords
			Result.put ("<span class=%"html_1%">!doctype</span>", "!doctype")
			Result.put ("<span class=%"html_1%">a</span>", "a")
			Result.put ("<span class=%"html_1%">abbr</span>", "abbr")
			Result.put ("<span class=%"html_1%">acronym</span>", "acronym")
			Result.put ("<span class=%"html_1%">address</span>", "address")
			Result.put ("<span class=%"html_1%">applet</span>", "applet")
			Result.put ("<span class=%"html_1%">area</span>", "area")
			Result.put ("<span class=%"html_1%">b</span>", "b")
			Result.put ("<span class=%"html_1%">base</span>", "base")
			Result.put ("<span class=%"html_1%">basefont</span>", "basefont")
			Result.put ("<span class=%"html_1%">bdo</span>", "bdo")
			Result.put ("<span class=%"html_1%">bgsound</span>", "bgsound")
			Result.put ("<span class=%"html_1%">big</span>", "big")
			Result.put ("<span class=%"html_1%">blink</span>", "blink")
			Result.put ("<span class=%"html_1%">blockquote</span>", "blockquote")
			Result.put ("<span class=%"html_1%">body</span>", "body")
			Result.put ("<span class=%"html_1%">br</span>", "br")
			Result.put ("<span class=%"html_1%">button</span>", "button")
			Result.put ("<span class=%"html_1%">caption</span>", "caption")
			Result.put ("<span class=%"html_1%">center</span>", "center")
			Result.put ("<span class=%"html_1%">cite</span>", "cite")
			Result.put ("<span class=%"html_1%">code</span>", "code")
			Result.put ("<span class=%"html_1%">col</span>", "col")
			Result.put ("<span class=%"html_1%">colgroup</span>", "colgroup")
			Result.put ("<span class=%"html_1%">dd</span>", "dd")
			Result.put ("<span class=%"html_1%">del</span>", "del")
			Result.put ("<span class=%"html_1%">dfn</span>", "dfn")
			Result.put ("<span class=%"html_1%">dir</span>", "dir")
			Result.put ("<span class=%"html_1%">div</span>", "div")
			Result.put ("<span class=%"html_1%">dl</span>", "dl")
			Result.put ("<span class=%"html_1%">dt</span>", "dt")
			Result.put ("<span class=%"html_1%">em</span>", "em")
			Result.put ("<span class=%"html_1%">embed</span>", "embed")
			Result.put ("<span class=%"html_1%">fieldset</span>", "fieldset")
			Result.put ("<span class=%"html_1%">font</span>", "font")
			Result.put ("<span class=%"html_1%">form</span>", "form")
			Result.put ("<span class=%"html_1%">frame</span>", "frame")
			Result.put ("<span class=%"html_1%">frameset</span>", "frameset")
			Result.put ("<span class=%"html_1%">h1</span>", "h1")
			Result.put ("<span class=%"html_1%">h2</span>", "h2")
			Result.put ("<span class=%"html_1%">h3</span>", "h3")
			Result.put ("<span class=%"html_1%">h4</span>", "h4")
			Result.put ("<span class=%"html_1%">h5</span>", "h5")
			Result.put ("<span class=%"html_1%">h6</span>", "h6")
			Result.put ("<span class=%"html_1%">head</span>", "head")
			Result.put ("<span class=%"html_1%">hr</span>", "hr")
			Result.put ("<span class=%"html_1%">html</span>", "html")
			Result.put ("<span class=%"html_1%">http-equiv</span>", "http-equiv")
			Result.put ("<span class=%"html_1%">i</span>", "i")
			Result.put ("<span class=%"html_1%">iframe</span>", "iframe")
			Result.put ("<span class=%"html_1%">ilayer</span>", "ilayer")
			Result.put ("<span class=%"html_1%">img</span>", "img")
			Result.put ("<span class=%"html_1%">input</span>", "input")
			Result.put ("<span class=%"html_1%">ins</span>", "ins")
			Result.put ("<span class=%"html_1%">isindex</span>", "isindex")
			Result.put ("<span class=%"html_1%">kbd</span>", "kbd")
			Result.put ("<span class=%"html_1%">keygen</span>", "keygen")
			Result.put ("<span class=%"html_1%">label</span>", "label")
			Result.put ("<span class=%"html_1%">layer</span>", "layer")
			Result.put ("<span class=%"html_1%">legend</span>", "legend")
			Result.put ("<span class=%"html_1%">li</span>", "li")
			Result.put ("<span class=%"html_1%">link</span>", "link")
			Result.put ("<span class=%"html_1%">listing</span>", "listing")
			Result.put ("<span class=%"html_1%">map</span>", "map")
			Result.put ("<span class=%"html_1%">menu</span>", "menu")
			Result.put ("<span class=%"html_1%">meta</span>", "meta")
			Result.put ("<span class=%"html_1%">multicol</span>", "multicol")
			Result.put ("<span class=%"html_1%">nobr</span>", "nobr")
			Result.put ("<span class=%"html_1%">noembed</span>", "noembed")
			Result.put ("<span class=%"html_1%">noframes</span>", "noframes")
			Result.put ("<span class=%"html_1%">nolayer</span>", "nolayer")
			Result.put ("<span class=%"html_1%">noscript</span>", "noscript")
			Result.put ("<span class=%"html_1%">object</span>", "object")
			Result.put ("<span class=%"html_1%">ol</span>", "ol")
			Result.put ("<span class=%"html_1%">optgroup</span>", "optgroup")
			Result.put ("<span class=%"html_1%">option</span>", "option")
			Result.put ("<span class=%"html_1%">p</span>", "p")
			Result.put ("<span class=%"html_1%">param</span>", "param")
			Result.put ("<span class=%"html_1%">plaintext</span>", "plaintext")
			Result.put ("<span class=%"html_1%">pre</span>", "pre")
			Result.put ("<span class=%"html_1%">q</span>", "q")
			Result.put ("<span class=%"html_1%">ruby</span>", "ruby")
			Result.put ("<span class=%"html_1%">s</span>", "s")
			Result.put ("<span class=%"html_1%">samp</span>", "samp")
			Result.put ("<span class=%"html_1%">script</span>", "script")
			Result.put ("<span class=%"html_1%">select</span>", "select")
			Result.put ("<span class=%"html_1%">server</span>", "server")
			Result.put ("<span class=%"html_1%">small</span>", "small")
			Result.put ("<span class=%"html_1%">sound</span>", "sound")
			Result.put ("<span class=%"html_1%">spacer</span>", "spacer")
			Result.put ("<span class=%"html_1%">span</span>", "span")
			Result.put ("<span class=%"html_1%">strike</span>", "strike")
			Result.put ("<span class=%"html_1%">strong</span>", "strong")
			Result.put ("<span class=%"html_1%">style</span>", "style")
			Result.put ("<span class=%"html_1%">sub</span>", "sub")
			Result.put ("<span class=%"html_1%">sup</span>", "sup")
			Result.put ("<span class=%"html_1%">tbody</span>", "tbody")
			Result.put ("<span class=%"html_1%">textarea</span>", "textarea")
			Result.put ("<span class=%"html_1%">title</span>", "title")
			Result.put ("<span class=%"html_1%">tt</span>", "tt")
			Result.put ("<span class=%"html_1%">u</span>", "u")
			Result.put ("<span class=%"html_1%">ul</span>", "ul")
			Result.put ("<span class=%"html_1%">var</span>", "var")
			Result.put ("<span class=%"html_1%">wbr</span>", "wbr")
			Result.put ("<span class=%"html_1%">xmp</span>", "xmp")
			Result.put ("<span class=%"html_1%">table</span>", "table")
			Result.put ("<span class=%"html_1%">td</span>", "td")
			Result.put ("<span class=%"html_1%">tfoot</span>", "tfoot")
			Result.put ("<span class=%"html_1%">th</span>", "th")
			Result.put ("<span class=%"html_1%">thead</span>", "thead")
			Result.put ("<span class=%"html_1%">tr</span>", "tr")

			-- HTML Attributes
			Result.put ("<span class=%"html_2%">accesskey</span>", "accesskey")
			Result.put ("<span class=%"html_2%">action</span>", "action")
			Result.put ("<span class=%"html_2%">align</span>", "align")
			Result.put ("<span class=%"html_2%">alink</span>", "alink")
			Result.put ("<span class=%"html_2%">alt</span>", "alt")
			Result.put ("<span class=%"html_2%">background</span>", "background")
			Result.put ("<span class=%"html_2%">balance</span>", "balance")
			Result.put ("<span class=%"html_2%">behavior</span>", "behavior")
			Result.put ("<span class=%"html_2%">bgcolor</span>", "bgcolor")
			Result.put ("<span class=%"html_2%">bgproperties</span>", "bgproperties")
			Result.put ("<span class=%"html_2%">border</span>", "border")
			Result.put ("<span class=%"html_2%">bordercolor</span>", "bordercolor")
			Result.put ("<span class=%"html_2%">bordercolordark</span>", "bordercolordark")
			Result.put ("<span class=%"html_2%">bordercolorlight</span>", "bordercolorlight")
			Result.put ("<span class=%"html_2%">bottommargin</span>", "bottommargin")
			Result.put ("<span class=%"html_2%">cellpadding</span>", "cellpadding")
			Result.put ("<span class=%"html_2%">cellspacing</span>", "cellspacing")
			Result.put ("<span class=%"html_2%">checked</span>", "checked")
			Result.put ("<span class=%"html_2%">class</span>", "class")
			Result.put ("<span class=%"html_2%">classid</span>", "classid")
			Result.put ("<span class=%"html_2%">clear</span>", "clear")
			Result.put ("<span class=%"html_2%">code</span>", "code")
			Result.put ("<span class=%"html_2%">codebase</span>", "codebase")
			Result.put ("<span class=%"html_2%">codetype</span>", "codetype")
			Result.put ("<span class=%"html_2%">color</span>", "color")
			Result.put ("<span class=%"html_2%">cols</span>", "cols")
			Result.put ("<span class=%"html_2%">colspan</span>", "colspan")
			Result.put ("<span class=%"html_2%">compact</span>", "compact")
			Result.put ("<span class=%"html_2%">content</span>", "content")
			Result.put ("<span class=%"html_2%">controls</span>", "controls")
			Result.put ("<span class=%"html_2%">coords</span>", "coords")
			Result.put ("<span class=%"html_2%">datafld</span>", "datafld")
			Result.put ("<span class=%"html_2%">dataformatas</span>", "dataformatas")
			Result.put ("<span class=%"html_2%">datasrc</span>", "datasrc")
			Result.put ("<span class=%"html_2%">direction</span>", "direction")
			Result.put ("<span class=%"html_2%">disabled</span>", "disabled")
			Result.put ("<span class=%"html_2%">dynsrc</span>", "dynsrc")
			Result.put ("<span class=%"html_2%">enctype</span>", "enctype")
			Result.put ("<span class=%"html_2%">event</span>", "event")
			Result.put ("<span class=%"html_2%">face</span>", "face")
			Result.put ("<span class=%"html_2%">for</span>", "for")
			Result.put ("<span class=%"html_2%">frame</span>", "frame")
			Result.put ("<span class=%"html_2%">frameborder</span>", "frameborder")
			Result.put ("<span class=%"html_2%">framespacing</span>", "framespacing")
			Result.put ("<span class=%"html_2%">height</span>", "height")
			Result.put ("<span class=%"html_2%">hidden</span>", "hidden")
			Result.put ("<span class=%"html_2%">href</span>", "href")
			Result.put ("<span class=%"html_2%">hspace</span>", "hspace")
			Result.put ("<span class=%"html_2%">ismap</span>", "ismap")
			Result.put ("<span class=%"html_2%">lang</span>", "lang")
			Result.put ("<span class=%"html_2%">language</span>", "language")
			Result.put ("<span class=%"html_2%">leftmargin</span>", "leftmargin")
			Result.put ("<span class=%"html_2%">link</span>", "link")
			Result.put ("<span class=%"html_2%">loop</span>", "loop")
			Result.put ("<span class=%"html_2%">lowsrc</span>", "lowsrc")
			Result.put ("<span class=%"html_2%">marginheight</span>", "marginheight")
			Result.put ("<span class=%"html_2%">marginwidth</span>", "marginwidth")
			Result.put ("<span class=%"html_2%">maxlength</span>", "maxlength")
			Result.put ("<span class=%"html_2%">mayscript</span>", "mayscript")
			Result.put ("<span class=%"html_2%">method</span>", "method")
			Result.put ("<span class=%"html_2%">methods</span>", "methods")
			Result.put ("<span class=%"html_2%">multiple</span>", "multiple")
			Result.put ("<span class=%"html_2%">name</span>", "name")
			Result.put ("<span class=%"html_2%">nohref</span>", "nohref")
			Result.put ("<span class=%"html_2%">noresize</span>", "noresize")
			Result.put ("<span class=%"html_2%">noshade</span>", "noshade")
			Result.put ("<span class=%"html_2%">nowrap</span>", "nowrap")
			Result.put ("<span class=%"html_2%">palette</span>", "palette")
			Result.put ("<span class=%"html_2%">pluginspage</span>", "pluginspage")
			Result.put ("<span class=%"html_2%">public</span>", "public")
			Result.put ("<span class=%"html_2%">rb</span>", "rb")
			Result.put ("<span class=%"html_2%">rbc</span>", "rbc")
			Result.put ("<span class=%"html_2%">readonly</span>", "readonly")
			Result.put ("<span class=%"html_2%">rel</span>", "rel")
			Result.put ("<span class=%"html_2%">rev</span>", "rev")
			Result.put ("<span class=%"html_2%">rightmargin</span>", "rightmargin")
			Result.put ("<span class=%"html_2%">rows</span>", "rows")
			Result.put ("<span class=%"html_2%">rowspan</span>", "rowspan")
			Result.put ("<span class=%"html_2%">rp</span>", "rp")
			Result.put ("<span class=%"html_2%">rt</span>", "rt")
			Result.put ("<span class=%"html_2%">rtc</span>", "rtc")
			Result.put ("<span class=%"html_2%">rules</span>", "rules")
			Result.put ("<span class=%"html_2%">scroll</span>", "scroll")
			Result.put ("<span class=%"html_2%">scrollamount</span>", "scrollamount")
			Result.put ("<span class=%"html_2%">scrolldelay</span>", "scrolldelay")
			Result.put ("<span class=%"html_2%">scrolling</span>", "scrolling")
			Result.put ("<span class=%"html_2%">selected</span>", "selected")
			Result.put ("<span class=%"html_2%">shape</span>", "shape")
			Result.put ("<span class=%"html_2%">size</span>", "size")
			Result.put ("<span class=%"html_2%">span</span>", "span")
			Result.put ("<span class=%"html_2%">src</span>", "src")
			Result.put ("<span class=%"html_2%">start</span>", "start")
			Result.put ("<span class=%"html_2%">style</span>", "style")
			Result.put ("<span class=%"html_2%">tabindex</span>", "tabindex")
			Result.put ("<span class=%"html_2%">target</span>", "target")
			Result.put ("<span class=%"html_2%">text</span>", "text")
			Result.put ("<span class=%"html_2%">title</span>", "title")
			Result.put ("<span class=%"html_2%">topmargin</span>", "topmargin")
			Result.put ("<span class=%"html_2%">truespeed</span>", "truespeed")
			Result.put ("<span class=%"html_2%">type</span>", "type")
			Result.put ("<span class=%"html_2%">url</span>", "url")
			Result.put ("<span class=%"html_2%">urn</span>", "urn")
			Result.put ("<span class=%"html_2%">usemap</span>", "usemap")
			Result.put ("<span class=%"html_2%">valign</span>", "valign")
			Result.put ("<span class=%"html_2%">value</span>", "value")
			Result.put ("<span class=%"html_2%">vlink</span>", "vlink")
			Result.put ("<span class=%"html_2%">volume</span>", "volume")
			Result.put ("<span class=%"html_2%">vrml</span>", "vrml")
			Result.put ("<span class=%"html_2%">vspace</span>", "vspace")
			Result.put ("<span class=%"html_2%">width</span>", "width")
			Result.put ("<span class=%"html_2%">wrap</span>", "wrap")

			-- ASP.NET
			Result.put ("<span class=%"html_3%">page</span>", "page")
			Result.put ("<span class=%"html_3%">asp</span>", "asp")
			Result.put ("<span class=%"html_3%">Label</span>", "Label")
			Result.put ("<span class=%"html_3%">Textbox</span>", "Textbox")
			Result.put ("<span class=%"html_3%">RequiredFieldValidator</span>", "RequiredFieldValidator")
			Result.put ("<span class=%"html_3%">CustomValidator</span>", "CustomValidator")
			Result.put ("<span class=%"html_3%">Button</span>", "Button")
			Result.put ("<span class=%"html_3%">DataList</span>", "DataList")
			Result.put ("<span class=%"html_3%">Hyperlink</span>", "Hyperlink")

			-- ASP.NET Controls properties
			Result.put ("<span class=%"html_4%">runat</span>", "runat")
			Result.put ("<span class=%"html_4%">id</span>", "id")
			Result.put ("<span class=%"html_4%">Text</span>", "Text")
			Result.put ("<span class=%"html_4%">OnServerValidate</span>", "OnServerValidate")
			Result.put ("<span class=%"html_4%">OnClick</span>", "OnClick")
			Result.put ("<span class=%"html_4%">Display</span>", "Display")
			Result.put ("<span class=%"html_4%">ControlToValidate</span>", "ControlToValidate")
			Result.put ("<span class=%"html_4%">DataList</span>", "DataList")
			Result.put ("<span class=%"html_4%">BorderColor</span>", "BorderColor")
			Result.put ("<span class=%"html_4%">BorderWidth</span>", "BorderWidth")
			Result.put ("<span class=%"html_4%">CellPadding</span>", "CellPadding")
			Result.put ("<span class=%"html_4%">CellSpacing</span>", "CellSpacing")
			Result.put ("<span class=%"html_4%">GridLines</span>", "GridLines")
			Result.put ("<span class=%"html_4%">ItemTemplate</span>", "ItemTemplate")
			Result.put ("<span class=%"html_4%">CssClass</span>", "CssClass")
		end

end -- class CODE_FORMATTER

--+--------------------------------------------------------------------
--| Eiffel for ASP.NET 5.6
--| Copyright (c) 2005-2006 Eiffel Software
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
