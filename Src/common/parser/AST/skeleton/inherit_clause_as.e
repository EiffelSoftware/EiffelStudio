indexing
	description: "Object that represents an inherit clause: rename, export, undefine, redefine or select"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INHERIT_CLAUSE_AS

inherit
	AST_EIFFEL

feature{NONE} -- Initialization

	make (l: like content; k_as: KEYWORD_AS) is
			-- Initialize.
		require
			l_valid: l /= Void implies not l.is_empty
		do
			content := l
			clause_keyword := k_as
		ensure
			content_set: content = l
			clause_keyword_set: clause_keyword = k_as
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if content /= Void then
					Result := content.first_token (a_list)
				end
			else
				Result := clause_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if content /= Void then
				Result := content.last_token (a_list)
			end
			if (Result = Void or Result.is_null) and a_list /= Void then
				check
					clause_keyword /= Void
				end
				Result := clause_keyword.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if content = Void then
				Result := other.content = Void
			else
				Result := content.is_equivalent (other.content)
			end
		end

feature -- Roundtrip

	clause_keyword: KEYWORD_AS
			-- Keyword "rename", "export", "undefine", "redefine" or "select" associated with current AST node

feature -- Clause content

	content: EIFFEL_LIST [AST_EIFFEL]
			-- Content of current inherit clause
end
