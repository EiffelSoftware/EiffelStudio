-- Shared access to servers

class SHARED_SERVER

inherit

	SHARED_WORKBENCH;
	SHARED_TMP_SERVER;

	
feature {NONE}

	Feat_tbl_server: FEAT_TBL_SERVER is
			-- Server for feature tables
		once
			Result := System.feat_tbl_server;
		end;

	Body_server: BODY_SERVER is
			-- Server for instances of CONTENT_AS
		once
			Result := System.body_server;
		end;

	Ast_server: AST_SERVER is
			-- Server for abstract syntax trees
		once
			Result := System.ast_server;
		end;

	Byte_server: BYTE_SERVER is
			-- Server for byte code trees
		once
			Result := System.byte_server;
		end;

	Class_info_server: CLASS_INFO_SERVER is
			-- Server for parent lists
		once
			Result := System.class_info_server;
		end;

	Inv_ast_server: INV_AST_SERVER is
			-- Server for invariant clause
		once
			Result := System.inv_ast_server;
		end;

	Inv_byte_server: INV_BYTE_SERVER is
			-- Server for invariant byte code
		once
			Result := System.inv_byte_server;
		end;

	Depend_server: DEPEND_SERVER is
			-- Server for dependances for incremental type check
		once
			Result := System.depend_server;
		end;

	M_feat_tbl_server: M_FEAT_TBL_SERVER is
			-- Server for byte code descirption of melted feature tables
		once
			Result := System.m_feat_tbl_server;
		end;

	M_feature_server: M_FEATURE_SERVER is
			-- Server of melted feature byte code
		once
			Result := System.m_feature_server;
		end;

	M_rout_tbl_server: M_ROUT_TBL_SERVER is
			-- Server of melted routine table byte code
		once
			Result := System.m_rout_tbl_server;
		end;
 
	M_rout_id_server: M_ROUT_ID_SERVER is
			-- Server of mleted routine id array byte code
		once
			Result := System.m_rout_id_server;
		end;
 
	Poly_server: POLY_SERVER is
			-- Server of polymorphic unit tables
		once
			Result := System.poly_server;
		end;

end
