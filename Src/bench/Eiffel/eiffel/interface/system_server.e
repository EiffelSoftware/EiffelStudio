indexing
	description: "All the server used during an Eiffel compilation";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_SERVER

inherit
	SHARED_TMP_SERVER

creation
	make

feature -- Initialization

	make is
			-- Create all the servers.
		do
			!! classes.make
			!! server_controler.make
			!! feat_tbl_server.make
			!! class_comments_server.make
			!! body_server.make
			!! byte_server.make
			!! ast_server.make
			!! class_info_server.make
			!! inv_ast_server.make
			!! inv_byte_server.make
			!! depend_server.make
			!! rep_depend_server.make
			!! m_feat_tbl_server.make
			!! m_feature_server.make
			!! m_rout_id_server.make
			!! m_desc_server.make
		end

feature -- Clean up of the temporary server file

	clear is
				-- Clear the servers
		do
			Tmp_ast_server.clear
			Tmp_feat_tbl_server.clear
			Tmp_body_server.clear
			Tmp_class_info_server.clear
			Tmp_byte_server.clear
			Tmp_inv_byte_server.clear
			Tmp_inv_ast_server.clear
			Tmp_depend_server.clear
			Tmp_rep_depend_server.clear
		end

	tmp_purge is
		do
				-- Removed unused files from EIFGEN
			Tmp_ast_server.files_purge
			Tmp_feat_tbl_server.files_purge
			Tmp_class_info_server.files_purge
			Tmp_byte_server.files_purge
			Tmp_inv_byte_server.files_purge
			Tmp_depend_server.files_purge
			Tmp_rep_depend_server.files_purge

			server_controler.remove_useless_files
		end

feature -- Purge of compilation files

	purge is
			-- Purge compilation files
		do
				-- Removed unused files from EIFGEN
			feat_tbl_server.files_purge
			depend_server.files_purge
			rep_depend_server.files_purge
			class_info_server.files_purge
			inv_byte_server.files_purge
			byte_server.files_purge
			ast_server.files_purge
			m_feat_tbl_server.files_purge
			m_feature_server.files_purge
			m_rout_id_server.files_purge
			m_desc_server.files_purge

			server_controler.remove_useless_files
		end

	prepare_before_saving (normal_compilation: BOOLEAN) is
		do
				-- Purges server files only if it is not a precompilation.
			if normal_compilation then
				purge
			end

			feat_tbl_server.cache.wipe_out
			depend_server.cache.wipe_out
			rep_depend_server.cache.wipe_out
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

	rep_depend_server: REP_DEPEND_SERVER;
			-- Server for dependances for replicated features 

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

end -- class SYSTEM_SERVER
