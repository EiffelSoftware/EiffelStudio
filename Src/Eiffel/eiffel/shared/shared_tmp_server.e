note
	description: "Shared access to temporary servers."

class SHARED_TMP_SERVER

feature {NONE}

	Tmp_ast_server: TMP_AST_SERVER
			-- Server for recompilation. Will be merge into server
			-- `Ast_server', `Body_server' and `Inv_ast_server' after a
			-- successful recompilation.
			-- Is not an attribute of SYSTEM_I because it won't be saved
			-- on the disk. We need a new one at each workbench session.
		once
			create Result.make
		end

	Tmp_feature_server: TMP_FEATURE_SERVER
			-- Server of features during recompilation. Will be
			-- merge into `Feature_server' after a successful
			-- recompilation.
		once
			create Result.make
		end

	Tmp_byte_server: TMP_BYTE_SERVER
			-- Server for byte code. Will be useful to update the byte code
			-- server after a successful recompilation
		once
			create Result.make
		end

	Tmp_inv_byte_server: TMP_INV_BYTE_SERVER
			-- Temporary server for invariant byte code. Will be useful to
			-- update the invariant byte code server after a successful
			-- recompilation
		once
			create Result.make
		end

	Tmp_depend_server: TMP_DEPEND_SERVER
			-- Temporary server of class dependances for incremental type
			-- check. Will be useful to update the system dependance server
			-- after a successful recompilation
		once
			create Result.make
		end

	Tmp_creation_server: TMP_CREATION_SERVER
			-- Temporary server of class creation dependances for incremental
			-- validity check. It is used to update the system dependance server
			-- after a successful recompilation.
		once
			create Result.make
		end

	Tmp_m_feat_tbl_server: TMP_M_FEAT_TBL_SERVER
			-- Temporary server of melted feature table (Useful for
			-- purging the system melted feature table server).
		once
			create Result.make
		end

	Tmp_m_feature_server: TMP_M_FEATURE_SERVER
			-- Temporary server of melted feature byte code (Useful for
			-- purging the system melted feature byte code server).
		once
			create Result.make
		end

	Tmp_opt_byte_server: TMP_OPT_BYTE_SERVER
		once
			create Result.make
		end

	Tmp_poly_server: TMP_POLY_SERVER
		once
			create Result.make
		end

	Tmp_m_rout_id_server: TMP_M_ROUT_ID_SERVER
		once
			create Result.make
		end

	Tmp_m_desc_server: TMP_M_DESC_SERVER
		once
			create Result.make
		end

	feature_table_cache: CACHE [COMPUTED_FEATURE_TABLE]
			-- Cache for features
		once
			create Result.make
		ensure
			cache_not_void: Result /= Void
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
