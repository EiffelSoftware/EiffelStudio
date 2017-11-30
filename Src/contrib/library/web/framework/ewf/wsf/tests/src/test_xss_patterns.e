note
	description: "Summary description for {TEST_XSS_PATTERNS}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=XSS Filter Evasion Cheat Sheet", "src=https://www.owasp.org/index.php/XSS_Filter_Evasion_Cheat_Sheet", "protocol=uri"

class
	TEST_XSS_PATTERNS

inherit
	EQA_TEST_SET

feature -- Tests

	test_xss_locator
		local
			xss: WSF_XSS_REQUEST
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:= "[
';alert(String.fromCharCode(88,83,83))//';alert(String.fromCharCode(88,83,83))//";
alert(String.fromCharCode(88,83,83))//";alert(String.fromCharCode(88,83,83))//--
></SCRIPT>">'><SCRIPT>alert(String.fromCharCode(88,83,83))</SCRIPT>
			]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("XSS locator", r.has_matched)
		end

	test_xss_locator_short
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
'';!--"<XSS>=&{()}
			]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("XSS locator short", r.has_matched)
		end

	test_no_filter_evasion
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<SCRIPT SRC=http://xss.rocks/xss.js></SCRIPT>
			]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("No filter evasion", r.has_matched)
		end

	test_filter_bypass_based_polyglot
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
'">><marquee><img src=x onerror=confirm(1)></marquee>"></plaintext\></|\><plaintext/onmouseover=prompt(1)>
<script>prompt(1)</script>@gmail.com<isindex formaction=javascript:alert(/XSS/) type=submit>'-->"></script>
<script>alert(document.cookie)</script>">
<img/id="confirm&lpar;1)"/alt="/"src="/"onerror=eval(id)>'">
<img src="http://www.shellypalmer.com/wp-content/images/2015/07/hacked-compressor.jpg">
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Filter bypass based polyglot", r.has_matched)
		end


	test_image_xss_js_directive
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC="javascript:alert('XSS');">
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Image XSS using the JavaScript directive", r.has_matched)
		end


	test_no_quotes_no_semicolon
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC=javascript:alert('XSS')>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("No quotes and no semicolon", r.has_matched)
		end


	test_case_insensitive_xss_vector
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC=JaVaScRiPt:alert('XSS')>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Case insensitive XSS attack vector", r.has_matched)
		end


	test_html_entities
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC=javascript:alert(&quot;XSS&quot;)>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("HTML entities", r.has_matched)
		end

	test_grave_accent_obfuscation
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC=`javascript:alert("RSnake says, 'XSS'")`>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Grave accent obfuscation", r.has_matched)
		end


	test_malformed_a_tags
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
				-- Skip the HREF attribute and get to the meat of the XXS... Submitted by David Cross ~ Verified on Chrome
			s:="[
<a onmouseover="alert(document.cookie)">xxs link</a>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Malformed A tags", r.has_matched)
		end

	test_malformed_a_tags_2
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
				-- Chrome loves to replace missing quotes for you... if you ever get stuck just leave them off and Chrome will put them
				-- in the right place and fix your missing quotes on a URL or script.
			s:="[
<a onmouseover=alert(document.cookie)>xxs link</a>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Malformed A tags", r.has_matched)
		end


	test_malformed_img
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG """><SCRIPT>alert("XSS")</SCRIPT>">
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Malformed IMG tags", r.has_matched)
		end


	test_from_char_code
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("fromCharCode", r.has_matched)
		end


	test_default_src_tag
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC=# onmouseover="alert('xxs')">
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Default SRC tag to get past filters that check SRC domain", r.has_matched)
		end


	test_default_src_tag_2
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG SRC= onmouseover="alert('xxs')">
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Default SRC tag by leaving it empty", r.has_matched)
		end

	test_default_src_tag_3
		local
			r: REGULAR_EXPRESSION
			s: STRING
		do
			s:="[
<IMG onmouseover="alert('xxs')">
]"
			r:= xss_pattern.XSS.regexp
			r.match (s)
			assert ("Default SRC tag by leaving it out entirely", r.has_matched)
		end







feature {NONE} -- Implementation

	xss_pattern: WSF_PROTECTIONS

end
