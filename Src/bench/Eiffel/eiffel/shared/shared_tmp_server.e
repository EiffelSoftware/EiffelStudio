-- Shared access to temporary servers

class SHARED_TMP_SERVER
	
feature {NONE}

	Tmp_ast_server: TMP_AST_SERVER is
			-- Server for recompilation. Will be merge into server
			-- `Ast_server' after a successful recompilation.
			-- Is not an attribute of SYSTEM_I because it won't be saved
			-- on the disk. We need a new one at each workbench session.
		once
			!!Result.make;
		end;

	Tmp_feat_tbl_server: TMP_FEAT_TBL_SERVER is
			-- Server of feature table during recompilation. Will be
			-- merge into `Feat_tbl_server' after a successful 
			-- recompilation.
		once
			!!Result.make;
		end;

	Tmp_body_server: TMP_BODY_SERVER is
			-- Server for instance of FEATURE_AS during recompilation.
			-- Will be useful to update the body server `Body_server'
			-- in case of successful recompilation
		once
			!!Result.make;
		end;

	Tmp_class_info_server: TMP_CLASS_INFO_SERVER is
			-- Server fo instance of CLASS_INFO during recompilation.
			-- Will be useful to update the server `Class_info_server'
			-- in case of successful recompilation
		once
			!!Result.make;
		end;

	Tmp_byte_server: TMP_BYTE_SERVER is
			-- Server for byte code. Will be useful to update the byte code
			-- server after a successful recompilation
		once
			!!Result.make;
		end;

	Tmp_inv_ast_server: TMP_INV_AST_SERVER is
			-- Temporary server for invariant clauses. Will be useful to
			-- update the invariant server after a successful
			-- recompilation
		once
			!!Result.make;
		end;

	Tmp_inv_byte_server: TMP_INV_BYTE_SERVER is
			-- Temporary server for invariant byte code. Will be useful to
			-- update the invariant byte code server after a successful
			-- recompilation
		once
			!!Result.make;
		end;

	Tmp_depend_server: TMP_DEPEND_SERVER is
			-- Temporary server of class dependances for incremental type
			-- check. Will be useful to update the system dependance server
			-- after a successful recompilation
		once
			!!Result.make;
		end;

	Tmp_m_feat_tbl_server: TMP_M_FEAT_TBL_SERVER is
			-- Temporary server of melted feature table (Useful for
			-- purging the system melted feature table server).
		once
			!!Result.make;
		end;

	Tmp_m_feature_server: TMP_M_FEATURE_SERVER is
			-- Temporary server of melted feature byte code (Useful for
			-- purging the system melted feature byte code server).
		once
			!!Result.make;
		end;

	Tmp_opt_byte_server: TMP_OPT_BYTE_SERVER is
		once
			!!Result.make;
		end;

	Tmp_poly_server: TMP_POLY_SERVER is
		once
			!!Result.make;
		end;

	Tmp_m_rout_id_server: TMP_M_ROUT_ID_SERVER is
		once
			!!Result.make;
		end;

	Tmp_m_desc_server: TMP_M_DESC_SERVER is
		once
			!!Result.make;
		end;

	Tmp_class_comments_server: TMP_CLASS_COMMENTS_SERVER is
		once
			!!Result.make;
		end;

end
