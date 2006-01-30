indexing
	description: "Object that represents a CONVERT_FEAT_AS list"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERT_FEAT_LIST_AS

inherit
	EIFFEL_LIST [CONVERT_FEAT_AS]
		redefine
			process, first_token
		end

create
	make, make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_convert_feat_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				Result := convert_keyword.first_token (a_list)
			end
		end

feature -- Roundtrip

	convert_keyword: KEYWORD_AS
			-- Keyword "convert" associated with current AST node

	set_convert_keyword (a_keyword: KEYWORD_AS) is
			-- Set `convert_keyword' with `a_keyword'.
		do
			convert_keyword := a_keyword
		ensure
			convert_keyword_set: convert_keyword = a_keyword
		end

end
