note
	description: "[
		Temporary data structure of a class produced after first pass.
		Instances of `PARENT_AS` produced by Yacc are transformed into instances
		of `PARENT_C`: renamings, redefinings etc.. are inserted into hash table
		for quick interrogations for inheritance analysis and infix/prefix
		notation are interpreted. Those structures are forgotten after second
		pass.

		Attribute `features` is useful for iterating on it during second
		pass in order to analyze local features written in a class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class CLASS_INFO

inherit
	SHARED_ERROR_HANDLER
	SHARED_EXPORT_STATUS

	SHARED_SERVER
		export
			{NONE} all
		end

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

	INTERNAL_COMPILER_STRING_EXPORTER

create
	initialize_from_class_as

feature {NONE} -- Initialization

	initialize_from_class_as (a_class_as: CLASS_AS)
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
			l_conforming_parents, l_non_conforming_parents: like non_conforming_parents
		do
			l_conforming_parents := conforming_parents
			if l_conforming_parents /= Void then
				l_non_conforming_parents := non_conforming_parents
				if l_non_conforming_parents /= Void then
					create Result.make (l_conforming_parents.count + l_non_conforming_parents.count)
					Result.append (l_conforming_parents)
						-- We need to twin the result if appending to avoid side effect.
					Result.append (l_non_conforming_parents)
				else
					Result := l_conforming_parents
				end
			else
				Result := non_conforming_parents
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

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- Feature abstract syntax
		do
			if Tmp_ast_server.has (class_id) then
				Result := Tmp_ast_server.item (class_id).features;
			else
				Result := Ast_server.item (class_id).features;
			end;
		end;

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	creation_table (feat_table: FEATURE_TABLE): like {CLASS_C}.creators
			-- Creation table of the current class.
			-- The function has a side effect: it records creation positions of features in `feat_table`.
		require
			good_argument: feat_table /= Void
		local
			feature_name: ID_AS
			a_class: CLASS_C
			a_feature, l_def_create: FEATURE_I
			c_reation: CREATE_AS
			l_export_status: EXPORT_I
			vgcp1: VGCP1
			vgcp2: VGCP2
			vgcp21: VGCP21
			vgcp3: VGCP3
			vgcp4: VGCP4
			has_default_create: BOOLEAN
			position: like {FEATURE_I}.creator_position
			is_once: BOOLEAN
		do
			a_class := feat_table.associated_class
			is_once := a_class.is_once
			if not attached creators as cs then
					-- Do nothing.
				has_default_create := True
				if a_class.class_id = system.any_id then
					if attached feat_table.item_id (system.names.default_create_name_id) as f then
						f.set_creator_position (1)
					end
				elseif attached feat_table.feature_of_rout_id (system.default_create_rout_id) as f then
					f.set_creator_position (1)
				end
			elseif a_class.is_deferred then
				create vgcp1
				vgcp1.set_class (a_class)
				Error_handler.insert_error (vgcp1)
			else
				create Result.make (cs.count)
				if a_class.is_expanded then
					l_def_create := feat_table.feature_of_rout_id (System.default_create_rout_id)
				end
				position := 1
				across
					cs as c
				loop
					c_reation := c.item
					if attached c_reation.feature_list as feature_list then
						l_export_status :=
							if attached c_reation.clients as clients then
								export_status_generator.export_status (system, a_class, clients)
							else
								export_all
							end
						across
							feature_list as f
						loop
							feature_name := f.item.feature_name
							a_feature := feat_table.item_id (feature_name.name_id)
							if a_feature = Void then
								create vgcp2
								vgcp2.set_class (a_class)
								vgcp2.set_feature_name (feature_name.name)
								vgcp2.set_location (f.item.start_location)
								Error_handler.insert_error (vgcp2)
							else
								if Result.has (feature_name.name_id) then
									create vgcp3
									vgcp3.set_class (a_class)
									vgcp3.set_feature_name (feature_name.name)
									vgcp3.set_location (f.item.start_location)
									Error_handler.insert_error (vgcp3)
								else
									has_default_create := has_default_create or a_feature = l_def_create
									Result [feature_name.name_id] := l_export_status
								end
								if not a_feature.type.is_void then
									create vgcp21
									vgcp21.set_class (a_class)
									vgcp21.set_feature_name (feature_name.name)
									vgcp21.set_location (f.item.start_location)
									Error_handler.insert_error (vgcp21)
								end
								if not is_once then
										-- Skip checks specific to once classes.
								elseif not a_feature.is_once then
									error_handler.insert_error (create {ONCE_CREATION_ERROR}.make ({ONCE_CREATION_ERROR}.reason_non_once, a_feature, a_class, f.item.start_location))
								elseif a_feature.written_in /= class_id then
									error_handler.insert_error (create {ONCE_CREATION_ERROR}.make ({ONCE_CREATION_ERROR}.reason_inherited, a_feature, a_class, f.item.start_location))
								elseif a_feature.is_object_relative_once then
									error_handler.insert_error (create {ONCE_CREATION_ERROR}.make ({ONCE_CREATION_ERROR}.reason_object_relative, a_feature, a_class, f.item.start_location))
								end
								a_feature.set_creator_position (position)
								position := position + 1
							end
						end
					end
				end
			end
			if a_class.is_expanded and not has_default_create then
				create vgcp4
				vgcp4.set_class (a_class)
				vgcp4.set_feature_name ("default_create")
				Error_handler.insert_error (vgcp4)
				Error_handler.checksum
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
