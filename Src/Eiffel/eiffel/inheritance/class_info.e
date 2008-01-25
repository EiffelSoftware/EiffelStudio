indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Temporary data structure of a class produced after first pass.
-- Instances of PARENT_AS produced by Yacc are transformed into instances
-- of PARENT_C: renamings, redefinings etc.. are inserted into hash table
-- for quick interrogations for inheritance analysis and infix/prefix
-- notation are interpreted. Those structures are forgotten after second
-- pass.
-- Attribute `features' is useful for iterating on it during second
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

create
	initialize_from_class_as

feature {NONE} -- Initialization

	initialize_from_class_as (a_class_as: CLASS_AS) is
				-- Initialize `Current'.
			require
				a_class_as_not_void: a_class_as /= Void
			do
				class_id := a_class_as.class_id
				conforming_parents := a_class_as.conforming_parents
				non_conforming_parents := a_class_as.non_conforming_parents
				creators := a_class_as.creators
				convertors := a_class_as.convertors
			ensure
				class_id_set: class_id = a_class_as.class_id
				conforming_parents_set: conforming_parents = a_class_as.conforming_parents
				non_conforming_parents_set: non_conforming_parents = a_class_as.non_conforming_parents
				creators_set: creators = a_class_as.creators
				convertors_set: convertors = a_class_as.convertors
			end

feature -- Access

	parents: EIFFEL_LIST [PARENT_AS]
			-- List containing both conforming and non-conforming parents of `Current'.
		local
			l_non_conforming_parents: like non_conforming_parents
		do
			Result := conforming_parents
			l_non_conforming_parents := non_conforming_parents
			if Result /= Void then
				if l_non_conforming_parents /= Void then
					Result := Result.twin
						-- We need to twin the result if appending to avoid side effect.
					Result.append (l_non_conforming_parents)
				end
			else
				Result := l_non_conforming_parents
			end
		end

	conforming_parents: EIFFEL_LIST [PARENT_AS];
			-- List containing only conforming parents of `Current'.

	non_conforming_parents: EIFFEL_LIST [PARENT_AS];
			-- List containing only non-conforming parents of `Current'.

	creators: EIFFEL_LIST [CREATE_AS];
			-- Creators

	convertors: EIFFEL_LIST [CONVERT_FEAT_AS]
			-- Convertors

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
			feature_name: ID_AS;
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
						l_def_create := feat_table.feature_of_rout_id (System.default_create_rout_id)
					end
				until
					creators.after
				loop
					c_reation := creators.item;
					if c_reation.feature_list /= Void then
						from
							clients := c_reation.clients;
							if clients /= Void then
								l_export_status := export_status_generator.export_status (system, a_class, clients)
							else
								l_export_status := Export_all;
							end;
							feature_list := c_reation.feature_list;
							feature_list.start
						until
							feature_list.after
						loop
							feature_name := feature_list.item.internal_name
							a_feature := feat_table.item_id (feature_name.name_id);
							if a_feature = Void then
								create vgcp2;
								vgcp2.set_class (a_class);
								vgcp2.set_feature_name (feature_name.name);
								vgcp2.set_location (feature_list.item.start_location)
								Error_handler.insert_error (vgcp2);
							else
								if Result.has (feature_name.name) then
									create vgcp3;
									vgcp3.set_class (a_class);
									vgcp3.set_feature_name (feature_name.name);
									vgcp3.set_location (feature_list.item.start_location)
									Error_handler.insert_error (vgcp3);
								else
									has_default_create := has_default_create or a_feature = l_def_create
									Result.put (l_export_status, feature_name.name);
								end;
								if not a_feature.type.is_void then
									create vgcp21;
									vgcp21.set_class (a_class);
									vgcp21.set_feature_name (feature_name.name);
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
