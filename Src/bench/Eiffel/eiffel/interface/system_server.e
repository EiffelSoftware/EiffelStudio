indexing
	description: "All the server used during an Eiffel compilation";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_SERVER

inherit
	SHARED_TMP_SERVER

create
	make

feature -- Initialization

	make is
			-- Create all the servers.
		do
			create classes.make
			create unref_classes.make (10)
			create server_controler.make
			create feat_tbl_server.make
			create class_comments_server.make
			create body_server.make
			create byte_server.make
			create ast_server.make
			create class_info_server.make
			create inv_ast_server.make
			create inv_byte_server.make
			create depend_server.make
			create m_feat_tbl_server.make
			create m_feature_server.make
			create m_rout_id_server.make
			create m_desc_server.make
		end

feature -- Purge of compilation files

	prepare_before_saving (normal_compilation: BOOLEAN) is
		do
				-- Purges server files only if it is not a precompilation.
			if normal_compilation then
				server_controler.remove_useless_files
			end

			feat_tbl_server.cache.wipe_out
			depend_server.cache.wipe_out
			class_info_server.cache.wipe_out
			inv_byte_server.cache.wipe_out
			byte_server.cache.wipe_out
			ast_server.cache.wipe_out
			m_feat_tbl_server.cache.wipe_out
			m_feature_server.cache.wipe_out
			m_rout_id_server.cache.wipe_out
			m_desc_server.cache.wipe_out
		end

feature -- Access

	classes: CLASS_C_SERVER;
			-- Server for compiled classes
			--| Reminder: This is not a real server
	
	server_controler: SERVER_CONTROL;
			-- Controler of servers

	feat_tbl_server: FEAT_TBL_SERVER;
			-- Server for feature tables

	body_server: BODY_SERVER;
			-- Server for instances of EIFFEL_FEAT

	ast_server: AST_SERVER;
			-- Server for abstract syntax trees

	byte_server: BYTE_SERVER;
			-- Server for byte code trees

	class_info_server: CLASS_INFO_SERVER;
			-- Server for class information produced bu first pass

	inv_ast_server: INV_AST_SERVER;
			-- Server for abstract syntax description of invariant clause

	inv_byte_server: INV_BYTE_SERVER;
			-- Server for invariant byte code

	depend_server: DEPEND_SERVER;
			-- Server for dependances for incremental type check

	m_feat_tbl_server: M_FEAT_TBL_SERVER;
			-- Server of byte code description of melted feature tables

	m_feature_server: M_FEATURE_SERVER;
			-- Server of melted feature byte code

	m_rout_id_server: M_ROUT_ID_SERVER;
			-- Server for routine id array byte code

	m_desc_server: M_DESC_SERVER;
			-- Server for class type descriptors

	class_comments_server: CLASS_COMMENTS_SERVER;
			-- Server for class comments 

feature {NONE} -- Private access

	unref_classes: ARRAYED_LIST [CLASS_I]
			-- Place holder to keep a class alive although class
			-- is not directly referenced by System. Classes have
			-- been added by one of the compiler tool provider.

invariant
	classes_not_void: classes /= Void
	unref_classes_not_void: unref_classes /= Void
	server_controler_not_void: server_controler /= Void
	feat_tbl_server_not_void: feat_tbl_server /= Void
	class_comments_server_not_void: class_comments_server /= Void
	body_server_not_void: body_server /= Void
	byte_server_not_void: byte_server /= Void
	ast_server_not_void: ast_server /= Void
	class_info_server_not_void: class_info_server /= Void
	inv_ast_server_not_void: inv_ast_server /= Void
	inv_byte_server_not_void: inv_byte_server /= Void
	depend_server_not_void: depend_server /= Void
	m_feat_tbl_server_not_void: m_feat_tbl_server /= Void
	m_feature_server_not_void: m_feature_server /= Void
	m_rout_id_server_not_void: m_rout_id_server /= Void
	m_desc_server_not_void: m_desc_server /= Void

end -- class SYSTEM_SERVER
