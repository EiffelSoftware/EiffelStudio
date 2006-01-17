indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Temporary data structure of a class produced after first pass.
-- Instances of PARENT_AS produced by Yacc are transformed into instances
-- of PARENT_C: renamings, redefinings etc.. are inserted into hash table
-- for quick interrogations for inheritance analysis and infix/prefix
-- notation are interpreted. Those structures are forgotten after second
-- pass.
-- Attribute `features' is useful for iteratiing on it during second
-- pass in order to analyze local features written in a class.

class CLASS_INFO 

inherit
	SHARED_ERROR_HANDLER;
	SHARED_EXPORT_STATUS;
	SHARED_SERVER
		export
			{NONE} all
		end;
	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	COMPILER_EXPORTER

feature -- Access

	parents: EIFFEL_LIST [PARENT_AS];
			-- Parents
			
	index: HASH_TABLE [READ_INFO, INTEGER];
			-- Indexes left by the server `Tmp_ast_server' during
			-- execution of feature `pass1' of CLASS_C. Useful
			-- for second pass

	invariant_info: READ_INFO;
			-- Index of invariant clause

	creators: EIFFEL_LIST [CREATE_AS];
			-- Creators
			
	convertors: EIFFEL_LIST [CONVERT_FEAT_AS]
			-- Convertors

	unique_values: HASH_TABLE [INTEGER, STRING];
			-- Stores the values of the unique attributes

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS] is
			-- Feature abstract syntax
		do
			if Tmp_ast_server.has (class_id) then
				Result := Tmp_ast_server.item (class_id).features;
			else
				Result := Ast_server.item (class_id).features;
			end;
		end;

	creation_table (feat_table: FEATURE_TABLE): HASH_TABLE [EXPORT_I, STRING] is
			-- Creators table
		require
			good_argument: feat_table /= Void;
		local
			feature_name: STRING;
			a_class: CLASS_C;
			a_feature, l_def_create: FEATURE_I;
			feature_list: EIFFEL_LIST [FEATURE_NAME];
			clients: CLIENT_AS;
			c_reation: CREATE_AS;
			l_export_status: EXPORT_I;
			vgcp1: VGCP1;
			vgcp2: VGCP2;
			vgcp21: VGCP21;
			vgcp3: VGCP3;
			vgcp4: VGCP4;
			has_default_create: BOOLEAN
		do
			a_class := feat_table.associated_class;
			if creators = Void then
				-- Do nothing
				has_default_create := True
			elseif a_class.is_deferred then
				create vgcp1;
				vgcp1.set_class (a_class);
				Error_handler.insert_error (vgcp1);
			else
				from
					create Result.make (creators.count);
					creators.start;
					if a_class.is_expanded then
						l_def_create := feat_table.feature_of_rout_id (System.default_create_id)
					end
				until
					creators.after
				loop
					c_reation := creators.item;
					if c_reation.feature_list /= Void then
						from
							clients := c_reation.clients;
							if clients /= Void then
								l_export_status := export_status_generator.export_status (a_class, clients)
							else
								l_export_status := Export_all;
							end;
							feature_list := c_reation.feature_list;
							feature_list.start
						until
							feature_list.after
						loop
							feature_name := feature_list.item.internal_name;
							a_feature := feat_table.item (feature_name);
							if a_feature = Void then
								create vgcp2;
								vgcp2.set_class (a_class);
								vgcp2.set_feature_name (feature_name);
								vgcp2.set_location (feature_list.item.start_location)
								Error_handler.insert_error (vgcp2);
							else
								if Result.has (feature_name) then
									create vgcp3;
									vgcp3.set_class (a_class);
									vgcp3.set_feature_name (feature_name);
									vgcp3.set_location (feature_list.item.start_location)
									Error_handler.insert_error (vgcp3);
								else
									has_default_create := has_default_create or a_feature = l_def_create
									Result.put (l_export_status, feature_name);
								end;
								if not a_feature.type.is_void then
									create vgcp21;
									vgcp21.set_class (a_class);
									vgcp21.set_feature_name (feature_name);
									vgcp21.set_location (feature_list.item.start_location)
									Error_handler.insert_error (vgcp21);
								end;
							end;
							feature_list.forth;
						end;
					end
					creators.forth;
				end;
			end;
			if a_class.is_expanded and not has_default_create then
				create vgcp4;
				vgcp4.set_class (a_class);
				vgcp4.set_feature_name ("default_create")
				Error_handler.insert_error (vgcp4);
				Error_handler.checksum
			end
		end;

feature -- Settings

	set_invariant_info (i: like invariant_info) is
			-- Assign `i' to `invariant_info'.
		do
			invariant_info := i;
		end;

	set_parents (p: like parents) is
			-- Assign `p' to `parents'.
		do	
			parents := p;
		end;

	set_index (i: like index) is
			-- Assign `i' to `index'.
		do
			index := i;
		end;

	set_creators (c: like creators) is
			-- Assign `c' to `creators'.
		do
			creators := c;
		end;

	set_unique_values (u: HASH_TABLE [INTEGER, STRING]) is
			-- Assign `u' to `unique_values'.
		do
			unique_values := u;
		end;
		
	set_convertors (c: like convertors) is
			-- Assign `c' to `convertors'.
		require
			c_valid: c /= Void implies not c.is_empty
		do
			convertors := c
		ensure
			convertors_set: convertors = c
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
