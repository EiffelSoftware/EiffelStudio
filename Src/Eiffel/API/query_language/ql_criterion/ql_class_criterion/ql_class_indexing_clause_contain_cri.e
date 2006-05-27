indexing
	description: "Criterion to test if indexing clause of a class contain certain text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CLASS_INDEXING_CLAUSE_CONTAIN_CRI

inherit
	QL_CLASS_INDEXING_CRI
		rename
			name as text
		redefine
			class_ast
		end

feature{NONE} -- Implementation

	indexing_clause_contain_text (a_indexing_clause: INDEXING_CLAUSE_AS; a_match_list: LEAF_AS_LIST): BOOLEAN is
			-- Is `a_indexing_clause' contain text `text'?
			-- Text of `a_indexing_clause' will be retrieved from `a_match_list'.
		require
			a_indexing_clause_attached: a_indexing_clause /= Void
			a_match_list_attached: a_match_list /= Void
		local
			l_text: STRING
			l_index_list: EIFFEL_LIST [ATOMIC_AS]
		do
			if not a_indexing_clause.is_empty then
				from
					a_indexing_clause.start
				until
					a_indexing_clause.after or Result
				loop
					l_index_list := a_indexing_clause.item.index_list
					if l_index_list /= Void then
						l_text := l_index_list.original_text (a_match_list)
						Result := is_name_same_as (l_text)
					end
					a_indexing_clause.forth
				end
			end
		end

	roundtrip_pure_eiffel_parser: EIFFEL_PARSER is
			-- Pure Eiffel parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
		end

	roundtrip_il_eiffel_parser: EIFFEL_PARSER is
			-- IL Eiffel parser.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser
		end

feature{NONE} -- Implementation

	class_ast (a_item: QL_CLASS): CLASS_AS is
			-- CLASS_AS of `a_item'.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				if a_item.is_compiled then
					Result := a_item.class_c.ast
					match_list := match_list_server.item (a_item.class_c.class_id)
				else
					roundtrip_eiffel_parser.parse_from_string (a_item.class_i.text)
					Result := roundtrip_eiffel_parser.root_node
					match_list := roundtrip_eiffel_parser.match_list
				end
			end
		rescue
			Result := Void
			match_list := Void
			l_retried := True
			retry
		end

	match_list: LEAF_AS_LIST
			-- Match list of last class parsed by `roundtrip_eiffel_parser'

end
