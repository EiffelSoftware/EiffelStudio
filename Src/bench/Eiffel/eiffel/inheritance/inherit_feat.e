-- Class for analysis of instances of FEATURE_I inherited under the
-- same final name. Those features are divided into the sublists:
-- the deferred features and the non-deferred features.

class INHERIT_FEAT 

inherit

	SHARED_INHERITED;
	SHARED_WORKBENCH;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER;
	SHARED_EXPORT_STATUS;

creation

	make

	
feature 

	deferred_features: LINKED_LIST [INHERIT_INFO];
			-- List of deferred inherited features informations

	features: LINKED_LIST [INHERIT_INFO];
			-- List of informations on non-deferred inherited features

	inherited_info: INHERIT_INFO;
			-- Feature inherited chosen among the deferred features and
			-- the non-deferred.  If a redefinition is expected, this
			-- attribute will be void after feature `process'.

	rout_id_set: ROUT_ID_SET;
			-- Set of routine ids computed for the inherited feature

	make is
			-- Lists creation
		do
			!!deferred_features.make;
			!!features.make;
			!!rout_id_set.make (5);
		end;

	has_assertion: BOOLEAN is
			-- Do deferred_features or features have assertions?
			-- (for Merging)
		do
			Result := check_assertion (deferred_features) or else
						check_assertion (features)
		end;

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
			end;			
		end;

	wipe_out is
			-- Clear the structure
		do
			deferred_features.wipe_out;
			features.wipe_out;
			inherited_info := Void;
			rout_id_set.wipe_out;
		end;

	set_inherited_info (f: INHERIT_INFO) is
			-- Assign `f' to `inherited_info'.
		do
			inherited_info := f;
		end;

	nb_features: INTEGER is
			-- Count of `features'.
		do
			Result := features.count;
		end;

	nb_deferred: INTEGER is
			-- Count of `deferred_features'.
		do
			Result := deferred_features.count;
		end;

	empty: BOOLEAN is
			-- Are the feature info lists empty ?
		do
			Result := nb_features = 0 and then nb_deferred = 0;
		end;

	insert (info: INHERIT_INFO) is
			-- Insert `info' in one of the two lists.
		require
			good_argument: info /= Void
		local
			pos: INTEGER;
		do
				-- The position of the list of features must be saved
				-- because feature `treat_renamings' could call it.
			if info.a_feature.is_deferred then
				pos := deferred_features.position;
				deferred_features.start;
				deferred_features.put_left (info);
				deferred_features.go (pos);
			else
				pos := features.position;
				features.start;
				features.put_left (info);
				features.go (pos);
			end;
		end;

	inherited_feature: FEATURE_I is
			-- Feature in information `inherited_info'
		require
			inherited_info_exists: inherited_info /= Void
		do
			Result := inherited_info.a_feature;
		end;

	check_renamings is
			-- Check renamings in the two lists
		do
			if deferred_features /= Void then
				treat_renamings (deferred_features);
			end;
			if features /= Void then
				treat_renamings (features);
			end;
		end;

	treat_renamings (feat: like features) is
			-- Check renamings in the feature list `feat'.
		require
			good_argument: feat /= Void
		local
			next_info, next: INHERIT_INFO;
			feature_name, new_name, other_renaming: STRING;
			parent: PARENT_C;
			pos, body_id: INTEGER;
			duplication: BOOLEAN;
			other_renamings: EXTEND_TABLE [STRING, STRING];
			replication: FEATURE_i;
				-- Replicated feature in case of repeated inheritance
		do
			from
				feat.start;
			until
				feat.offright
			loop
				next := feat.item;
				feature_name := next.a_feature.feature_name;
				parent := next.parent;
				if parent.is_renaming (feature_name) then
						-- Detection of a renaming clause: check repeated
						-- inheritance possible replication
					new_name := parent.renaming.item (feature_name);
					pos := feat.position;
					from
							-- Looking for a case of replication through
							-- repeated inheritance. There must be two same
							-- body ids.
						body_id := next.a_feature.code_id;
						feat.start;
					until
						feat.offright or else duplication
					loop
						next_info := feat.item;
						if 	next_info /= next
							and then
							next_info.a_feature.code_id = body_id
						then
							other_renamings := next_info.parent.renaming;
							if other_renamings /= Void then
								other_renaming := 
											other_renamings.item (feature_name);
							end;
								-- Replication if same code id but not the
								-- same renaming
							duplication :=
								not equal(new_name, other_renaming);
						end;
						feat.forth;
					end;
					feat.go (pos);

						-- Duplication of the instance of FEATURE_I for 
						-- renaming
					if duplication then
							-- Feature replication in case of repeated
							-- inheritance: process a new body id.
							-- Give a new body id to the replication
						replication := next.a_feature.replicated;
					else
						replication := next.a_feature.twin;
					end;
					replication.set_feature_name (new_name);

					next.set_a_feature (replication);

						-- Move the inherit feature information under 
						-- 'new_name'.
					Inherit_table.add_inherited_feature (next, new_name);
						-- Remove the information
					feat.remove;
						-- Remove empty structure
					if empty then
						Inherit_table.remove (feature_name);
					end;
				else
					feat.forth;
				end;
			end;
		end;

	process (cl: CLASS_C; feature_name: STRING) is
			-- Process the features inherited under the same final name
		require
			inherited_info = Void
		do
			process_undefinition (cl, feature_name);
			if nb_deferred > 0 then
				check_deferred (cl, feature_name);
			end;
			if nb_features > 0 then
				check_features (cl, feature_name);
			end;
		end;

	process_undefinition (cl: CLASS_C; feature_name: STRING) is
			-- Process possible undefinitions
		require
			good_argument: not (cl = Void or else feature_name = Void)
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
				deferred_features.offright
			loop
				info := deferred_features.item;
				if info.parent.is_undefining (feature_name) then
					!!vdus3;
					vdus3.set_class_id (System.current_class.id);
					vdus3.set_parent
							(System.class_of_id (info.parent.parent_id));
					vdus3.set_a_feature (info.a_feature);
					Error_handler.insert_error (vdus3);
				end;
				deferred_features.forth;
			end;
			from
				features.start
			until
				features.offright
			loop
				info := features.item;
				if info.parent.is_undefining (feature_name) then
					a_feature := info.a_feature;
					if not a_feature.undefinable then
						!!vdus2;
						vdus2.set_class_id (System.current_class.id);
						vdus2.set_parent
								(System.class_of_id (info.parent.parent_id));
						vdus2.set_a_feature (a_feature);
						Error_handler.insert_error (vdus2);
						features.forth;
					else
						new_deferred := a_feature.new_deferred;
						!!new_info;
						new_info.set_a_feature (new_deferred);
						new_info.set_parent (info.parent);
						insert (new_info);
						features.remove;
					end;
				else
					features.forth;
				end;
			end;
		end;

	check_deferred (cl: CLASS_C; feature_name: STRING) is
			-- Process the deferred features
		require
			nb_deferred > 0;
		local
			inherit_feat: FEATURE_I;
		do
				-- Update `rout_id_set'.
			rout_id_set.update (deferred_features);
		end;

	check_features (cl: CLASS_C; feature_name: STRING) is
			-- Process the non-deferred inherited features.
		require
			features /= Void;
			nb_features > 0;
		local
			inherit_feat: FEATURE_I;
			vmfn2: VMFN2;
		do
			if features_all_redefined (feature_name) then
					-- To be redefined later
			elseif features_all_the_same then
					-- Shared features
				inherited_info := features.first;
			else
					-- Name clash
				!!vmfn2;
				vmfn2.set_class_id (System.current_class.id);
				vmfn2.set_features (features);
				Error_handler.insert_error (vmfn2);
			end;
				-- Update `rout_id_set'
			rout_id_set.update (features);
		end;

	features_all_redefined (feature_name: STRING): BOOLEAN is
			-- Are all the non-deferred inherited features redefined ?
		require
			nb_features > 0;
		local
			inherit_info: INHERIT_INFO;
			vdrs2: VDRS2;
		do
			from
				Result := True;
				features.start;
			until
				features.offright or else not Result
			loop
				inherit_info := features.item;
				Result := inherit_info.parent.is_redefining (feature_name);

				if Result and then not inherit_info.a_feature.redefinable then
						-- Cannot redefine frozen feature, constant or once
					!!vdrs2;
					vdrs2.set_class_id (System.current_class.id);
					vdrs2.set_feature_name (feature_name);
					vdrs2.set_body_id (inherit_info.a_feature.body_id);
					vdrs2.set_parent_id (inherit_info.parent.parent_id);
					Error_handler.insert_error (vdrs2);
				end;
				features.forth;
			end
		end;

	features_all_the_same: BOOLEAN is
			-- Are all the non-deferred features all the same ?
		require
			good_context: nb_features > 0;
		local
			body_id, written_id: INTEGER;
			first_feature: FEATURE_I;
			written_class: CLASS_C;
			to_compair, written_type, written_actual_type: TYPE_A;

		do
				-- First condition for sharing feature: same body id
			from
				Result := True;
				first_feature := features.first.a_feature;
				body_id := first_feature.code_id;
				features.start;
				features.forth;
			until
				features.offright or else not Result
			loop
				Result := body_id = features.item.a_feature.code_id;
				features.forth;
			end;
				-- Second condition: if the feature is written in a
				-- generic class, check if there is no generic derivation
			if Result and features.count > 1 then
				written_class := first_feature.written_class;
				if written_class.generics /= Void then
						-- The class where the feature is written is a
						-- generic class
					from
						written_actual_type := written_class.actual_type;
						written_id := written_class.id;
						to_compair := written_actual_type.duplicate;
						to_compair := to_compair.instantiation_in
							(features.first.parent.parent_type, written_id);
						features.go (2);
					until
						features.offright or else not Result
					loop
						written_type := written_actual_type.duplicate;
						written_type := written_type.instantiation_in
							(features.item.parent.parent_type, written_id);
							-- Same instantiated parent type for
							-- sharing feature
						Result := deep_equal (to_compair, written_type);
						features.forth;
					end;
				end;
			end;
		end;

	all_attributes: BOOLEAN is
			-- Are all the inherited features non-deferred attributes ?
		do
			if deferred_features.empty then
				from
					Result := True;
					features.start
				until
					features.offright or else not Result
				loop
					Result := features.item.a_feature.is_attribute;
					features.forth;
				end;
			end;
		end;

	exports (feature_name: STRING): EXPORT_I is
			-- Concatenation of all the export statuses of the inherited
			-- features (`feature_name' is the renamed name...)
		require
			not empty;
			feature_name /= Void;
		local
			export_status: EXPORT_I;
			info: INHERIT_INFO;
		do
				-- Default value: no export at all
			Result := Export_none;
			from
				features.start
			until
				features.offright or else Result.is_all
			loop
				info := features.item;
					-- First look for a new export status for the
					-- inherited feature
				export_status := info.parent.new_export_for (feature_name);
				if export_status = Void then
					export_status := info.a_feature.export_status;
				end;
				Result := Result.concatenation (export_status);

				features.forth;
			end;
			from
				deferred_features.start;
			until
				deferred_features.offright or else Result.is_all
			loop
				info := deferred_features.item;
					-- First look for a new export status for the
					-- inherited feature
				export_status := info.parent.new_export_for (feature_name);
					-- If no new export status, then take the inherted one
				if export_status = Void then
					export_status := info.a_feature.export_status;
				end;
				Result := Result.concatenation (export_status);
				deferred_features.forth;	
			end;
		end;

feature -- Debug

	trace is
		do
			io.error.putstring ("INHERIT_FEAT%N");
			io.error.putstring ("%TDeferred%N");
			from
				deferred_features.start
			until
				deferred_features.after
			loop
				deferred_features.item.trace;
				deferred_features.forth;
			end;
			io.error.putstring ("%TEffective%N");
			from
				features.start
			until
				features.after
			loop
				features.item.trace;
				features.forth;
			end;
			if inherited_info /= Void then
				io.error.putstring ("Inherited info:%N");
				inherited_info.trace
			else
				io.error.putstring ("Void inherited info%N");
			end;
		end;

end
