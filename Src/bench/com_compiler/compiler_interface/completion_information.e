indexing
	description: "[
					Complete given target in given class and feature.
					If the target ends with a '.', give list of possible
					features.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_INFORMATION

inherit
	IEIFFEL_COMPLETION_INFO_IMPL_STUB
		redefine
			target_features
		end

	SHARED_EIFFEL_PROJECT

	SHARED_NAMES_HEAP
	
	COMPILER_EXPORTER
	
	SHARED_EVALUATOR

	SHARED_INST_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize info
		do
			
		end

feature -- Access

	target_features (target: STRING; feature_name: STRING; file_name: STRING): COMPLETION_ENTRY_ENUMERATOR is
			-- Features accessible from target.
			-- `target' [in].
		local
			ci: CLASS_I
			fi: FEATURE_I
			fa: FEATURE_AS
			ra: ROUTINE_AS
			ids: HASH_TABLE [TYPE, STRING]
			farg: FEAT_ARG
			targets: LIST [STRING]
			target_type: TYPE
			feature_table: FEATURE_TABLE
			locals: EIFFEL_LIST [TYPE_DEC_AS]
			id_list: ARRAYED_LIST [INTEGER]
			i, count, old_count: INTEGER
			variable_list: SORTABLE_ARRAY [COMPLETION_ENTRY]
			retried: BOOLEAN
			arrayed_list: ARRAYED_LIST [COMPLETION_ENTRY]
			features: SORTABLE_ARRAY [FEATURE_DESCRIPTOR]
		do
			if not retried then
				ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
				if ci /= Void and then ci.compiled and then ci.compiled_class.has_feature_table then
					class_i := ci
					feature_table := ci.compiled_class.feature_table
					fi := feature_table.item (feature_name)
					Inst_context.set_cluster (ci.cluster)
					if fi /= Void then
						create ids.make (10)
						fa := fi.body
						if fa /= Void then
							ra ?= fa.body.content
							if ra /= Void then
								from
									locals := ra.locals
									locals.start
								until
									locals.after
								loop
									id_list := locals.item.id_list
									from
										id_list.start
									until
										id_list.after
									loop
										Local_evaluator.set_local_name (id_list.item)
										ids.put (Local_evaluator.evaluated_type (locals.item.type, feature_table, fi), Names_heap.item (id_list.item))
										id_list.forth
									end
									locals.forth
								end
							end
						end
						if fi.has_arguments then
							farg := fi.arguments
							from
								i := 1
								count := farg.count
							until
								i > count
							loop
								ids.put (farg.i_th (i), farg.item_name (i))
								i := i + 1
							end
						end
					end
					check
						non_void_ids: ids /= Void
					end
					if target.occurrences ('.') = 0 then
						from
							ids.start
							i := 1
							create variable_list.make (1, ids.count)
						until
							ids.after
						loop
							variable_list.put (create {VARIABLE_DESCRIPTOR}.make (ids.key_for_iteration, ids.key_for_iteration + ": " + ids.item_for_iteration.dump), i)
							i := i + 1
							ids.forth
						end
						features := features_list_from_table (feature_table)
						old_count := variable_list.count
						variable_list.resize (1, old_count + features.count)
						variable_list.subcopy (features, 1, features.count, old_count + 1)
						variable_list.sort
						create arrayed_list.make_from_array (variable_list)
						create Result.make (arrayed_list)
					else
						targets := target.split ('.')
						if targets.last.is_empty then
							targets.finish
							targets.remove
						end
						ids.search (targets.first)
						if ids.found then
							target_type := ids.found_item
						else
							feature_table.search (targets.first)
							if feature_table.found then
								target_type := feature_table.found_item.type
							end
						end
						if target_type /= Void and then not target_type.is_void then
							targets.start
							targets.remove
							Result := recursive_lookup (target_type, targets)
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	recursive_lookup (target_type: TYPE; targets: LIST [STRING]): COMPLETION_ENTRY_ENUMERATOR is
			-- Available features after resolution of `targets' in `target_type'
		require
			non_void_target_type : target_type /= Void
			non_void_targers: targets /= Void
		local
			feature_table: FEATURE_TABLE
			cl_type: CL_TYPE_A
			a_type: TYPE
		do
			cl_type ?= target_type
			if cl_type /= Void then
				feature_table := cl_type.associated_class.feature_table
			end
			if feature_table /= Void then
				if targets.is_empty then
					Result := features_from_table (feature_table)
				else
					feature_table.search (targets.first)
					if feature_table.found then
						a_type := feature_table.found_item.type
					end
					if a_type /= Void and then not a_type.is_void then
						targets.start
						targets.remove
						Result := recursive_lookup (a_type, targets)
					end					
				end
			end
		end
	
	features_from_table (table: FEATURE_TABLE): COMPLETION_ENTRY_ENUMERATOR is
			-- Convert `table' into an instance of COMPLETION_ENTRY_ENUMERATOR.
		require
			non_void_table: table /= Void
		local
			arrayed_list: ARRAYED_LIST [FEATURE_DESCRIPTOR]
		do
			create arrayed_list.make_from_array (features_list_from_table (table))
			create Result.make (arrayed_list)
		end

	features_list_from_table (table: FEATURE_TABLE): SORTABLE_ARRAY [FEATURE_DESCRIPTOR] is
			-- Convert `table' into an instance of LIST [FEATURE_DESCRIPTOR].
		require
			non_void_table: table /= Void
		local
			ci: CLASS_I
			i: INTEGER
			fi: FEATURE_I
		do
			ci := table.associated_class.lace_class
			if ci /= Void then
				create Result.make (1, table.count)
				from
					i := 1
					table.start
				until
					table.after
				loop
					fi := table.item_for_iteration
					if is_listed (fi) then
						Result.put (create {FEATURE_DESCRIPTOR}.make_with_class_i_and_feature_i (ci, fi), i)
						i := i + 1
					end
					table.forth
				end
				Result := Result.subarray (1, i - 1)
				Result.sort
			else
				create Result.make (1,0)
			end
		end
	
	is_listed (fi: FEATURE_I): BOOLEAN is
			-- Should `fi' be listed in member completion list?
		require
			non_void_class_i: class_i /= Void
			valid_class_i: class_i.compiled
		do
			Result := not fi.is_infix and
						not fi.is_prefix and
						fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
						fi.is_exported_for (class_i.compiled_class)
		end
	
	class_i: CLASS_I
			-- Class in which code is being completed

invariant
	valid_class_i: class_i /= Void implies class_i.compiled

end -- class COMPLETION_INFORMATION
