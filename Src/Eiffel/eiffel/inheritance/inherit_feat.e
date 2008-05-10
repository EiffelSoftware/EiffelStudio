indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Class for analysis of instances of FEATURE_I inherited under the
-- same final name. Those features are divided into the sublists:
-- the deferred features and the non-deferred features.

class INHERIT_FEAT

inherit
	PREDEFINED_NAMES
	SHARED_INHERITED
	SHARED_WORKBENCH
	SHARED_SERVER
	SHARED_ERROR_HANDLER
	SHARED_EXPORT_STATUS
	COMPILER_EXPORTER

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature

	deferred_features: LINKED_LIST [INHERIT_INFO]
			-- List of deferred inherited features informations

	features: LINKED_LIST [INHERIT_INFO]
			-- List of informations on non-deferred inherited features

	inherited_info: INHERIT_INFO
			-- Feature inherited chosen among the deferred features and
			-- the non-deferred.  If a redefinition is expected, this
			-- attribute will be Void after feature `process'.

	rout_id_set: ROUT_ID_SET
			-- Set of routine ids computed for the inherited feature

	make is
			-- Lists creation
		do
			create deferred_features.make
			create features.make
			create rout_id_set.make
		end

--| FIXME IEK: The following two features are currently unused.
	has_assertion: BOOLEAN is
			-- Do deferred_features or features have assertions?
			-- (for Merging)
		do
			Result := check_assertion (deferred_features) or else
						check_assertion (features)
		end

	check_assertion (list: LINKED_LIST [INHERIT_INFO]): BOOLEAN is
			-- Check to see if list has assertion
			-- (for merging)
		do
			from
				list.start
			until
				list.after or Result
			loop
				Result := list.item.inherited_assertion;
				list.forth
			end
		end

	wipe_out is
			-- Clear the structure
		do
			deferred_features.wipe_out
			features.wipe_out
			inherited_info := Void
			rout_id_set.wipe_out
		end

	set_inherited_info (f: INHERIT_INFO) is
			-- Assign `f' to `inherited_info'.
		do
			inherited_info := f
		end

	is_empty: BOOLEAN is
			-- Are the feature info lists empty ?
		do
			Result := features.count = 0 and then deferred_features.count = 0
		end

	insert (info: INHERIT_INFO) is
			-- Insert `info' in one of the two lists.
		require
			info_not_void: info /= Void
			a_feature_set: info.a_feature /= Void
		do
				-- The position of the list of features must not change
				-- as `treat_renamings' may call it.
			if not info.a_feature.is_deferred then
				features.put_front (info)
			else
				deferred_features.put_front (info)
			end
		end

	inherited_feature: FEATURE_I is
			-- Feature in information `inherited_info'
		require
			inherited_info_exists: inherited_info /= Void
		do
			Result := inherited_info.a_feature
		end

	process_renamings is
			-- Check renaming in both effective and deferred features.
		do
			if deferred_features.count > 0 then
				treat_renamings (deferred_features)
			end
			if features.count > 0 then
				treat_renamings (features)
			end
		end

	treat_renamings (feat: LINKED_LIST [INHERIT_INFO]) is
			-- Check renamings in the feature list `feat'.
		require
			good_argument: feat /= Void
		local
			next: INHERIT_INFO
			replication: FEATURE_I
			feature_name_id: INTEGER
			extended_feature_name: RENAMING
			new_name_id: INTEGER
			new_alias_name_id: INTEGER
			names: like Names_heap
		do
			from
				feat.start
				names := Names_heap
			until
				feat.after
			loop
				next := feat.item
				if next.renaming_processed then
					feat.forth
				else
					feature_name_id :=  next.a_feature.feature_name_id
					if next.parent.renaming /= Void then
						extended_feature_name := next.parent.renaming.item (feature_name_id)
						if extended_feature_name /= Void then

							new_name_id := extended_feature_name.feature_name_id
							new_alias_name_id := extended_feature_name.alias_name_id

								-- We only need a twin so as to not unnecessarily duplicate
								-- arguments and type for some feature_i descendents.
								--| Aliasing products unexpected results so a twin is needed.
							replication := next.a_feature.twin
								-- Mark it as processed
							next.set_renaming_processed
								-- Move the inherit feature information under
								-- 'new_name'.
							replication.set_renamed_name_id (new_name_id, new_alias_name_id)
							replication.set_has_convert_mark (extended_feature_name.has_convert_mark)

								-- Update feature flags
							if is_mangled_name (names.item (new_name_id)) then
								if replication.argument_count = 0 then
										-- Prefix feature
									replication.set_is_infix (False)
									replication.set_is_prefix (True)
								else
										-- Infix feature
									replication.set_is_infix (True)
									replication.set_is_prefix (False)
								end
							else
									-- Identifier feature
								replication.set_is_infix (False)
								replication.set_is_prefix (False)
							end
							if new_alias_name_id > 0 then
								if new_alias_name_id = bracket_symbol_id then
										-- Bracket alias
									replication.set_is_binary (False)
									replication.set_is_bracket (True)
									replication.set_is_unary (False)
								elseif replication.argument_count = 0 then
										-- Unary operator
									replication.set_is_binary (False)
									replication.set_is_bracket (False)
									replication.set_is_unary (True)
								else
										-- Binary operator
									replication.set_is_binary (True)
									replication.set_is_bracket (False)
									replication.set_is_unary (False)
								end
							else
								replication.set_is_binary (False)
								replication.set_is_bracket (False)
								replication.set_is_unary (False)
							end
							next.set_a_feature (replication)
							Inherit_table.add_renamed_feature (next, new_name_id)
								-- Remove the information, this will move the cursor to the next item
							feat.remove
								-- Remove empty structure
							if is_empty then
									-- If there are no longer any features using that name then we remove the reference to the feature name.
								Inherit_table.remove (feature_name_id)
							end
						else
							feat.forth
						end
					else
						feat.forth
					end
				end
			end
		end

	process (cl: CLASS_C; feature_name_id: INTEGER) is
			-- Process the features inherited under the same final name
		require
			inherited_info = Void
		do
			process_undefinition (cl, feature_name_id)
			if deferred_features.count > 0 then
				check_deferred (cl)
			end
			if features.count > 0 then
				check_features (cl, feature_name_id)
			end
		end

	process_undefinition (cl: CLASS_C; feature_name_id: INTEGER) is
			-- Process possible undefinitions
		require
			cl_not_void: cl /= Void
			positive_feature_name_id: feature_name_id > 0
		local
			info, new_info: INHERIT_INFO;
			a_feature, new_deferred: FEATURE_I;
			vdus2: VDUS2;
			vdus3: VDUS3;
		do
			from
					-- Check unvalid undefintions of deferred features
				deferred_features.start
			until
				deferred_features.after
			loop
				info := deferred_features.item;
				if info.parent.is_undefining (feature_name_id) then
					create vdus3;
					vdus3.set_class (System.current_class);
					vdus3.set_parent (info.parent.parent);
					vdus3.set_a_feature (info.a_feature);
					Error_handler.insert_error (vdus3);
				end;
				deferred_features.forth;
			end;
			from
				features.start
			until
				features.after
			loop
				info := features.item;
				if info.parent.is_undefining (feature_name_id) then
					a_feature := info.a_feature;
					if not a_feature.undefinable then
						create vdus2;
						vdus2.set_class (System.current_class);
						vdus2.set_parent (info.parent.parent);
						vdus2.set_a_feature (a_feature);
						Error_handler.insert_error (vdus2);
						features.forth;
					else
						new_deferred := a_feature.new_deferred;
						create new_info.make (new_deferred)
						new_info.set_parent (info.parent);
						insert (new_info);
						features.remove;
					end;
				else
					features.forth;
				end;
			end;
		end;

	check_deferred (cl: CLASS_C) is
			-- Process the deferred features
		require
			deferred_features.count > 0
		do
				-- Update `rout_id_set'.
			rout_id_set.update (deferred_features)
		end

	check_features (cl: CLASS_C; feature_name_id: INTEGER) is
			-- Process the non-deferred inherited features.
		require
			features /= Void;
			features.count > 0;
		local
			encapsulated_i: ENCAPSULATED_I
			vmfn2: VMFN2;
		do
			if features_all_redefined (feature_name_id) then
					-- To be redefined later
			elseif features_all_the_same then
					-- Shared features
				inherited_info := features.first;
				encapsulated_i ?= inherited_info.a_feature
				if encapsulated_i /= Void and then encapsulated_i.generate_in = 0 then
					from
						features.start
						inherited_info := Void
					until
						features.after or else inherited_info /= Void
					loop
						encapsulated_i ?= features.item.a_feature
						if encapsulated_i /= Void and then encapsulated_i.generate_in /= 0 then
							inherited_info := features.item
						end
						features.forth
					end
					if inherited_info = Void then
						inherited_info := features.first;
					end
				end
			else
					-- Name clash
				create vmfn2;
				vmfn2.set_class (System.current_class);
				vmfn2.set_features (features);
				Error_handler.insert_error (vmfn2);
			end;
				-- Update `rout_id_set'
			rout_id_set.update (features);
		end;

	features_all_redefined (feature_name_id: INTEGER): BOOLEAN is
			-- Are all the non-deferred inherited features redefined?
		require
			features.count > 0
		local
			vdrs2: VDRS2;
		do
			from
				Result := True;
				features.start;
			until
				features.after or else not Result
			loop
				Result := features.item.parent.is_redefining (feature_name_id)
				if Result and then not features.item.a_feature.redefinable then
						-- Cannot redefine frozen feature, constant or once
					create vdrs2;
					vdrs2.set_class (System.current_class);
					vdrs2.set_feature_name (names_heap.item (feature_name_id));
					vdrs2.set_parent (features.item.parent.parent);
					Error_handler.insert_error (vdrs2);
				end;
				features.forth;
			end
		end;

	features_all_the_same: BOOLEAN is
			-- Are all the non-deferred features all the same ?
		require
			good_context: features.count > 0;
		local
			body_id: INTEGER
			written_id: INTEGER
			first_feature: FEATURE_I
			current_feature: FEATURE_I
			written_class: CLASS_C
			to_compare, written_actual_type: TYPE_A
			alias_name_id: INTEGER
		do
				-- First condition for sharing feature: same body id
			from
				Result := True
				first_feature := features.first.a_feature
				body_id := first_feature.code_id
				alias_name_id := first_feature.alias_name_id
				features.start
				features.forth
			until
				features.after or else not Result
			loop
				current_feature := features.item.a_feature
				Result := body_id = current_feature.code_id
					-- Check that aliases are the same
				if not first_feature.is_same_alias (current_feature) then
					error_handler.insert_error (create {VMFN2_NEW}.make (system.current_class, first_feature, current_feature))
				end
				features.forth
			end
				-- Second condition: if the feature is written in a
				-- generic class, check if there is no generic derivation
			if Result and features.count > 1 then
				written_class := first_feature.written_class
				if written_class.generics /= Void then
						-- The class where the feature is written is a
						-- generic class
					from
						written_actual_type := written_class.actual_type
						written_id := written_class.class_id
						to_compare := written_actual_type.instantiation_in (features.first.parent.parent_type, written_id)
							-- Go to the second item in 'features'

						features.start
						features.forth
					until
						features.after or else not Result
					loop
							-- Same instantiated parent type for
							-- sharing feature
						Result := to_compare.is_safe_equivalent (
							written_actual_type.instantiation_in (features.item.parent.parent_type, written_id)
						)
						features.forth
					end
				end
			end
		end

	all_attributes: BOOLEAN is
			-- Are all the inherited features non-deferred attributes ?
		do
			if deferred_features.count = 0 then
				from
					Result := True;
					features.start
				until
					features.after or else not Result
				loop
					Result := features.item.a_feature.is_attribute;
					features.forth;
				end;
			end;
		end;

	exports (feature_name_id: INTEGER): EXPORT_I is
			-- Concatenation of all the export statuses of the inherited
			-- features (`feature_name_id' is the renamed name...)
		require
			not_empty: not is_empty
			positive_feature_name_id: feature_name_id > 0
		local
			export_status: EXPORT_I
			info: INHERIT_INFO
		do
				-- Default value: no export at all
			Result := Export_none
			from
				features.start
			until
				features.after or else Result.is_all
			loop
				info := features.item
					-- First look for a new export status for the
					-- inherited feature
				export_status := info.parent.new_export_for (feature_name_id)
				if export_status = Void then
					export_status := info.a_feature.export_status
				end
				Result := Result.concatenation (export_status)

				features.forth
			end;
			from
				deferred_features.start
			until
				deferred_features.after or else Result.is_all
			loop
				info := deferred_features.item
					-- First look for a new export status for the
					-- inherited feature
				export_status := info.parent.new_export_for (feature_name_id)
					-- If no new export status, then take the inherted one
				if export_status = Void then
					export_status := info.a_feature.export_status
				end
				Result := Result.concatenation (export_status)
				deferred_features.forth
			end
		end

feature -- Debug

	trace is
		do
			io.error.put_string ("INHERIT_FEAT%N");
			io.error.put_string ("%TDeferred%N");
			from
				deferred_features.start
			until
				deferred_features.after
			loop
				deferred_features.item.trace;
				deferred_features.forth;
			end;
			io.error.put_string ("%TEffective%N");
			from
				features.start
			until
				features.after
			loop
				features.item.trace;
				features.forth;
			end;
			if inherited_info /= Void then
				io.error.put_string ("Inherited info:%N");
				inherited_info.trace
			else
				io.error.put_string ("Void inherited info%N");
			end;
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
