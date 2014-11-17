class
	BASIC

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			parser: JSON_PARSER
			printer: JSON_PRETTY_STRING_VISITOR
			s: STRING_32
		do
				-- Create parser for content `json_content'
			create parser.make_with_string (json_content)
				-- Parse the content
			parser.parse_content
			if
				parser.is_valid and then
				attached parser.parsed_json_value as jv
			then
					-- Json content is valid, and well parser.
					-- and the parsed json value is `jv'

					-- Let's access the glossary/title value
				if
					attached {JSON_OBJECT} jv as j_object and then
					attached {JSON_OBJECT} j_object.item ("glossary") as j_glossary and then
					attached {JSON_STRING} j_glossary.item ("title") as j_title
				then
					print ("The glossary title is %"" + j_title.unescaped_string_8 + "%".%N")
				else
					print ("The glossary title was not found!%N")
				end

					-- Pretty print the parsed JSON
				create s.make_empty
				create printer.make (s)
				jv.accept (printer)
				print ("The JSON formatted using a pretty printer:%N")
				print (s)
			end
		end

feature -- Status

feature -- Access

	json_content: STRING = "[
{
    "glossary": {
        "title": "example glossary",
		"GlossDiv": {
            "title": "S",
			"GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
					"SortAs": "SGML",
					"GlossTerm": "Standard Generalized Markup Language",
					"Acronym": "SGML",
					"Abbrev": "ISO 8879:1986",
					"GlossDef": {
                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
						"GlossSeeAlso": ["GML", "XML"]
                    },
					"GlossSee": "markup"
                }
            }
        }
    }
}
	]"

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
