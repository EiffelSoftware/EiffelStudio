note
	description: "[
		{WSF_PROTECTIONS}
		Provide application security parterns to assist in Cross Site Scripting
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OWASP XSS", "src=https://www.owasp.org/index.php/XSS_Filter_Evasion_Cheat_Sheet", "protocol=uri"
	EIS: "name=Regular expression protection", "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"

expanded class
	WSF_PROTECTIONS

feature -- XSS patterns

	XSS: WSF_PROTECTION_REGEXP
		note
			EIS: "name= XSS", "src=https://community.apigee.com/questions/27198/xss-threat-protection-patterns.html#answer-27465", "protocol=uri"
		once
			create Result.make_caseless ("((\%%3C)|<)[^\n]+((\%%3E)|>)")
		ensure
			is_compiled: Result.is_compiled
		end

	XSS_javascript: WSF_PROTECTION_REGEXP
		note
			EIS: "name=JavaScript Injection", "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"
		once
			Result := compiled_regexp ("<\s*script\b[^>]*>[^<]+<\s*/\s*script\s*>", True)
		ensure
			is_compiled: Result.is_compiled
		end

feature -- XPath injections Patterns

	XPath_abbreviated: WSF_PROTECTION_REGEXP
		note
			EIS: "name=XPath Abbreviated Syntax Injection", "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"
		once
			Result := compiled_regexp ("(/(@?[\w_?\w:\*]+(\[[^]]+\])*)?)+", True)
		ensure
			is_compiled: Result.is_compiled
		end

	XPath_expanded: WSF_PROTECTION_REGEXP
		note
			EIS: "name=XPath Expanded Syntax Injection", "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"
		once
			Result := compiled_regexp ("/?(ancestor(-or-self)?|descendant(-or-self)?|following(-sibling))", True)
		ensure
			is_compiled: Result.is_compiled
		end

feature -- Server side injection

	Server_side: WSF_PROTECTION_REGEXP
		note
			EIS: "name=Server-Side Include Injection", "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"
		once

			Result := compiled_regexp ("<!--#(include|exec|echo|config|printenv)\s+.*", True)
		ensure
			is_compiled: Result.is_compiled
		end

feature -- SQL injection Patterns

	SQL_injection: WSF_PROTECTION_REGEXP
		note
			EIS: "name= SQL Injection",  "src=https://docs.apigee.com/api-services/reference/regular-expression-protection", "protocol=uri"
		once
			Result := compiled_regexp ("[\s]*((delete)|(exec)|(drop\s*table)|(insert)|(shutdown)|(update)|(\bor\b))", True)
		ensure
			is_compiled: Result.is_compiled
		end

feature {NONE} -- Implementation

	compiled_regexp (p: STRING; caseless: BOOLEAN): REGULAR_EXPRESSION
		require
			p /= Void
		do
			create Result
			Result.set_caseless (caseless)
			Result.compile (p)
		ensure
			is_compiled: Result.is_compiled
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
