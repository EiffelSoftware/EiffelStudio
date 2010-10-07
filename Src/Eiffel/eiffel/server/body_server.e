note
	description: "Server for routines' body indexed by body index."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BODY_SERVER

inherit
	ANY

	SHARED_SERVER
		export
			{NONE} all
		end

feature

	has (a_class_id, a_body_index: INTEGER): BOOLEAN
			-- Is there `a_body_index' in the associated AST of `a_class_id'?
		local
			l_ast: CLASS_AS
		do
				-- FIXME: Should we first search in the TMP server first and if not found
				-- the non-TMP one? Currently we assume that if there is an AST, we only look
				-- where we got the AST and we skip the other source.
			l_ast := tmp_ast_server.item (a_class_id)
			if l_ast = Void then
				l_ast := ast_server.item (a_class_id)
			end
			if l_ast /= Void then
				Result := l_ast.body_indexes.has (a_body_index)
			end
		end

	server_has (a_class_id, a_body_index: INTEGER): BOOLEAN
			-- Is there `a_body_index' in the associated AST of `a_class_id'?
		do
			if
				attached ast_server.item (a_class_id) as l_ast
			then
				Result := l_ast.body_indexes.has (a_body_index)
			end
		end

	item (a_class_id, a_body_index: INTEGER): detachable FEATURE_AS
			-- Body of id `a_body_index' in the associated AST of `a_class_id'.
		local
			l_ast: CLASS_AS
		do
				-- FIXME: Should we first search in the TMP server first and if not found
				-- the non-TMP one? Currently we assume that if there is an AST, we only look
				-- where we got the AST and we skip the other source.
			l_ast := tmp_ast_server.item (a_class_id)
			if l_ast = Void then
				l_ast := ast_server.item (a_class_id)
			end
			if l_ast /= Void then
				Result := l_ast.body_indexes.item (a_body_index)
			end
		end

	server_item (a_class_id, a_body_index: INTEGER): detachable FEATURE_AS
			-- Body of id `a_body_index' in the associated AST of `a_class_id'.
		do
			if attached ast_server.item (a_class_id) as l_ast then
				Result := l_ast.body_indexes.item (a_body_index)
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
