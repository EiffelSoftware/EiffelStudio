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
	CEIFFEL_COMPLETION_INFO_COCLASS_IMP
		redefine
			make,
			target_features
		end

	SHARED_EIFFEL_PROJECT

	SHARED_NAMES_HEAP
	
	COMPILER_EXPORTER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize info
		do
			
		end

feature -- Access

	target_features (target: STRING; feature_name: STRING; file_name: STRING): IENUM_COMPLETION_ENTRY_INTERFACE is
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
			i, count: INTEGER
			variable_list: LIST [COMPLETION_ENTRY]
		do
			ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
			if ci /= Void and then ci.compiled and then ci.compiled_class.has_feature_table then
				feature_table := ci.compiled_class.feature_table
				fi := feature_table.item (feature_name)
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
									ids.put (locals.item.type, Names_heap.item (id_list.item))
									id_list.forth
								end
								locals.forth
							end
						end
					end
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
				check
					non_void_ids: ids /= Void
				end
				if target.occurrences ('.') = 0 then
					from
						ids.start
						create {ARRAYED_LIST [VARIABLE_DESCRIPTOR]} variable_list.make (ids.count)
					until
						ids.after
					loop
						variable_list.put (create {VARIABLE_DESCRIPTOR}.make (ids.key_for_iteration, ids.key_for_iteration + ": " + ids.item_for_iteration.dump))
						ids.forth
					end
					variable_list.append (features_list_from_table (feature_table))
				else
					targets := target.split ('.')
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

	recursive_lookup (target_type: TYPE; targets: LIST [STRING]): IENUM_COMPLETION_ENTRY_INTERFACE is
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
	
	features_from_table (table: FEATURE_TABLE): IENUM_COMPLETION_ENTRY_INTERFACE is
			-- Convert `table' into an instance of COMPLETION_ENTRY_ENUMERATOR.
		require
			non_void_table: table /= Void
		do
			create {COMPLETION_ENTRY_ENUMERATOR} Result.make (features_list_from_table (table))				
		end

	features_list_from_table (table: FEATURE_TABLE): ARRAYED_LIST [FEATURE_DESCRIPTOR] is
			-- Convert `table' into an instance of LIST [FEATURE_DESCRIPTOR].
		require
			non_void_table: table /= Void
		local
			ci: CLASS_I
		do
			ci := table.associated_class.lace_class
			create Result.make (table.count)
			if ci /= Void then
				from
					table.start
				until
					table.after
				loop
					Result.extend (create {FEATURE_DESCRIPTOR}.make_with_class_i_and_feature_i (ci, table.item_for_iteration))
					table.forth
				end
			end
		end
		
end -- class COMPLETION_INFORMATION
