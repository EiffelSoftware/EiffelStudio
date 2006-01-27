indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Shared access to servers

class SHARED_SERVER

inherit
	SHARED_WORKBENCH

	SHARED_TMP_SERVER

feature {NONE}

	Feat_tbl_server: FEAT_TBL_SERVER is
			-- Server for feature tables
		once
			Result := System.feat_tbl_server
		end

	Body_server: BODY_SERVER is
			-- Server for instances of CONTENT_AS
		once
			Result := System.body_server
		end

	Ast_server: AST_SERVER is
			-- Server for abstract syntax trees
		once
			Result := System.ast_server
		end

	Byte_server: BYTE_SERVER is
			-- Server for byte code trees
		once
			Result := System.byte_server
		end

	Class_info_server: CLASS_INFO_SERVER is
			-- Server for parent lists
		once
			Result := System.class_info_server
		end

	Inv_ast_server: INV_AST_SERVER is
			-- Server for invariant clause
		once
			Result := System.inv_ast_server
		end

	Inv_byte_server: INV_BYTE_SERVER is
			-- Server for invariant byte code
		once
			Result := System.inv_byte_server
		end

	Depend_server: DEPEND_SERVER is
			-- Server for dependances for incremental type check
		once
			Result := System.depend_server
		end

	M_feat_tbl_server: M_FEAT_TBL_SERVER is
			-- Server for byte code descirption of melted feature tables
		once
			Result := System.m_feat_tbl_server
		end

	M_feature_server: M_FEATURE_SERVER is
			-- Server of melted feature byte code
		once
			Result := System.m_feature_server
		end

	M_desc_server: M_DESC_SERVER is
		once
			Result := System.m_desc_server
		end

	Match_list_server: MATCH_LIST_SERVER is
			-- Server for the match list
		once
			Result := System.Match_list_server
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
