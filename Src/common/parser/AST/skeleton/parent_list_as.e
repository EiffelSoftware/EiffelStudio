indexing
	description: "Object that represents a list of PARENT_AS nodes"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARENT_LIST_AS

inherit
	EIFFEL_LIST [PARENT_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parent_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				check
					inherit_keyword /= Void
				end
				Result := inherit_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				Result := Precursor (a_list)
				if Result = Void or else Result.is_null then
					Result := inherit_keyword.last_token (a_list)
				end
			end
		end

feature -- Roundtrip

	inherit_keyword: KEYWORD_AS
			-- Keyword "inherit" associated with current AST node

	set_inherit_keyword (a_keyword: KEYWORD_AS) is
			-- Set `inherit_keyword' with `a_keyword'.
		do
			inherit_keyword := a_keyword
		ensure
			inherit_keyword_set: inherit_keyword = a_keyword
		end

end
