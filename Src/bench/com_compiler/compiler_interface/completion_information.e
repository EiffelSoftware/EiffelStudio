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
			target_features,
			target_feature,
			add_local,
			add_argument
		end

	SHARED_EIFFEL_PROJECT

	SHARED_NAMES_HEAP
	
	COMPILER_EXPORTER
	
	SHARED_EVALUATOR

	SHARED_INST_CONTEXT
	
	SHARED_EIFFEL_PARSER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize info
		do
			create locals.make (10)
			create arguments.make (5)
			set_standard_call
		end

feature -- Access

	target_feature (target: STRING; feature_name: STRING; file_name: STRING): FEATURE_DESCRIPTOR is
			-- Feature information
			-- `target' [in].
			-- `feature_name' [in].
			-- `file_name' [in].
		local
			ci: CLASS_I
			fi: FEATURE_I
			feature_table: FEATURE_TABLE
			targets: LIST [STRING]
			retried: BOOLEAN
			lookup_name: STRING
			target_type: TYPE
			ids: HASH_TABLE [TYPE, STRING]
		do
			if not retried then
				ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
				if ci /= Void and then ci.compiled and then ci.compiled_class.has_feature_table then
					class_i := ci
					feature_table := ci.compiled_class.feature_table
					fi := feature_table.item (feature_name)
					Inst_context.set_cluster (ci.cluster)
					if fi /= Void then
						targets := target.split ('.')
						if targets.last.is_empty then
							targets.finish
							targets.remove
						end
						if targets.count = 1 then
							feature_table.search (targets.first)
							if feature_table.found then
								create Result.make_with_class_i_and_feature_i (ci, feature_table.found_item)
							end
						else
							targets.finish
							lookup_name := targets.item
							targets.remove
							ids := feature_variables (fi, feature_table)
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
								feature_table := recursive_lookup (target_type, targets)
								if feature_table /= Void then
									feature_table.search (lookup_name)
									if feature_table.found then
										create Result.make_with_class_i_and_feature_i (class_i, feature_table.found_item)
									end
								end
							end
						end
					end
				end
			end
			locals.wipe_out
			arguments.wipe_out
		ensure then
			locals_reset: locals.is_empty
			arguments_reset: arguments.is_empty
		rescue
			retried := True
			retry
		end

	target_features (target: STRING; feature_name: STRING; file_name: STRING): COMPLETION_ENTRY_ENUMERATOR is
			-- Features accessible from target.
			-- `target' [in].
		local
			ci: CLASS_I
			fi: FEATURE_I
			ids: HASH_TABLE [TYPE, STRING]
			targets: LIST [STRING]
			target_type: TYPE
			feature_table: FEATURE_TABLE
			i, old_count: INTEGER
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
						ids := feature_variables (fi, feature_table)
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
								set_standard_call
							else
								feature_table.search (targets.first)
								if feature_table.found then
									set_standard_call
									target_type := feature_table.found_item.type
								else
									target_type := type_of_target (targets.first, feature_table, ids)
								end
							end
							if target_type /= Void and then not target_type.is_void then
								targets.start
								targets.remove
								Result := features_from_table (recursive_lookup (target_type, targets))
							end
						end
					end
				end
			end
			locals.wipe_out
			arguments.wipe_out
		ensure then
			locals_reset: locals.is_empty
			arguments_reset: arguments.is_empty
		rescue
			retried := True
			retry
		end

feature -- Basic Operations

		add_local (name: STRING; type: STRING) is
				-- Add local variable used for solving member completion list.
			do
				if name /= Void and type /= Void and then not name.is_empty and then not type.is_empty and then not locals.has (name) then
					locals.put (name, type)
				end
			end

		add_argument (name: STRING; type: STRING) is
				-- Add argument used for solving member completion list.
			do
				if name /= Void and type /= Void and then not name.is_empty and then not type.is_empty and then not arguments.has (name) then
					arguments.put (name, type)
				end
			end		

feature {NONE} -- Implementation

	recursive_lookup (target_type: TYPE; targets: LIST [STRING]): FEATURE_TABLE is
			-- Available features after resolution of `targets' in `target_type'
		require
			non_void_target_type : target_type /= Void
			non_void_targers: targets /= Void
		local
			feature_table: FEATURE_TABLE
			cl_type: CL_TYPE_A
			a_type: TYPE
		do
			cl_type ?= target_type.actual_type
			if cl_type /= Void then
				feature_table := cl_type.associated_class.feature_table
			end
			if feature_table /= Void then
				if targets.is_empty then
					Result := feature_table
				else
					set_standard_call -- Complete with all features
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
			if call_type = Standard_call or call_type = Precursor_call then
				Result := not fi.is_infix and
							not fi.is_prefix and
							fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
							fi.is_exported_for (class_i.compiled_class)
			elseif call_type = Static_call then
				Result := not fi.is_infix and
							not fi.is_prefix and
							fi.has_static_access and
							fi.is_exported_for (class_i.compiled_class)
			elseif call_type = Creation_call then
				Result := class_i.compiled_class.creators.has (fi.feature_name)
			elseif call_type = Agent_call then
				Result := not fi.is_infix and
							not fi.is_prefix and
							not fi.is_c_external and
							not fi.is_attribute and
							fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
							fi.is_exported_for (class_i.compiled_class)
			end
		end
	
	feature_variables (fi: FEATURE_I; feature_table: FEATURE_TABLE): HASH_TABLE [TYPE, STRING] is
			-- Local and arguments types of feature `fi' from table `feature_table'.
			-- Result is indexed by name of variable.
		require
			non_void_feature: fi /= Void
		local
			type: TYPE
			r_type: TYPE_A
		do
			create Result.make (10)
			from
				locals.start
			until
				locals.after
			loop
				type := type_from_type_name (locals.key_for_iteration)
				if type /= Void then
					r_type := resolved_type (type, feature_table, fi)
					if r_type /= Void then
						Result.put (r_type, locals.item_for_iteration)
					end
				end
				locals.forth
			end
			from
				arguments.start
			until
				arguments.after
			loop
				type := type_from_type_name (arguments.key_for_iteration)
				if type /= Void then
					r_type := resolved_type (type, feature_table, fi)
					if r_type /= Void then
						Result.put (r_type, arguments.item_for_iteration)
					end
				end
				arguments.forth
			end
		end

	resolved_type (type: TYPE; feature_table: FEATURE_TABLE; fi: FEATURE_I): TYPE_A is
			-- Solve type `type' within feature `fi' in table `feature_table'.
		require
			non_void_type: type /= Void
			non_void_table: feature_table /= Void
			non_void_feature_i: fi /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := Local_evaluator.evaluated_type (type, feature_table, fi)				
			end
		rescue
			retried := True
			retry
		end
		
	type_from_type_name (name: STRING): TYPE is
			-- Instance of {TYPE} from type name
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			retried: BOOLEAN
		do
			name.prune_all (' ')
			if not retried then
				Type_parser.parse_from_string ("toto " + name)
				Result := Type_parser.type_node
			end
		ensure
			spaces_removed: name.occurrences (' ') = 0
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	identifier_type (id: STRING; table: FEATURE_TABLE; ids: HASH_TABLE [TYPE, STRING]): TYPE is
			-- Type of identifier `id' if defined in either `table' or `ids'
		require
			non_void_identifier: id /= Void
			valid_identifier: not id.is_empty
			non_void_table: table /= Void
			non_void_ids: ids /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				id.item (i) /= ' ' or i > id.count
			loop
				i := i + 1
			end
			id.keep_tail (id.count - i + 1)
			ids.search (id)
			if ids.found then
				Result := ids.found_item
			else
				table.search (id)
				if table.found then
					Result := table.found_item.type
				end
			end
		ensure
			leading_spaces_removed: id.item (1) /= ' '
		end

	type_of_target (target: STRING; table: FEATURE_TABLE; ids: HASH_TABLE [TYPE, STRING]): TYPE is
			-- Type of expression `target'
		require
			non_void_target: target /= Void
			valid_target: not target.is_empty
		local
			c: CHARACTER
		do
			target.to_lower
			if target.substring (1, Agent_keyword_length).is_equal (Agent_keyword) then
				-- Agent
				set_agent_call
				if target.count > Agent_keyword_length + 1 then -- Minimum agent construct is "agent?."
					extract_type (target, Agent_keyword)
					if type_extracted then
						Result := extracted_type
					else
						c := target.item (1)
						if c = '?' then
							Result := class_i.compiled_class.actual_type
						else
							target.keep_head (target.count - 1) -- Remove trailing '.'
							Result := identifier_type (target, table, ids)
						end
					end
				end
			elseif target.substring (1, Feature_keyword_length).is_equal (Feature_keyword) then
				-- Static call
				set_static_call
				if target.count > Feature_keyword_length + 3 then -- Minimum static call construct is "feature{T}."
					Result := type_from_type_name (target.substring (target.index_of ('{', 1) + 1, target.index_of ('}', 2) - 1))
				end
			elseif target.substring (1, Create_keyword_length).is_equal (Create_keyword) then
				-- Creation call
				set_creation_call
				if target.count > Create_keyword_length + 2 then -- Minimum create construct is "create a."
					extract_type (target, Create_keyword)
					if type_extracted then
						Result := extracted_type
					else
						target.keep_head (target.count - 1) -- Remove trailing '.'
						Result := identifier_type (target, table, ids)						
					end
				end
			elseif target.item (1) = '!' then
				-- Creation call
				set_creation_call
				if target.substring (1, 2).is_equal ("!!") then
					target.keep_tail (target.count - 2)
					Result := identifier_type (target, table, ids)
				else
					Result := type_from_type_name (target.substring (2, target.index_of ('!', 2) - 1))
				end
			elseif target.substring (1, Precursor_keyword_length).is_equal (Precursor_keyword) then
				-- Precursor call
			elseif target.item (1).is_equal ('{') then
				-- Precursor call
			end
		end
	
	extract_type (target, keyword: STRING) is
			-- Extract type in `target' after `keyword' between curly braces if any.
			-- Set `extracted_type' and `type_extracted' accordingly.
		require
			non_void_target: target /= Void
			valid_target: not target.is_empty
			non_void_keyword: keyword /= void
			valid_keyword: not keyword.is_empty
			starts_with_keyword: target.substring (1, keyword.count).is_equal (keyword)
			well_formed: target.index_of ('{', 1) > 0 implies target.index_of ('}', 1) > 0
			one_type_at_most: target.occurrences ('{') < 2
		local
			s: STRING
			c: CHARACTER
			i: INTEGER
		do
			target.keep_tail (target.count - keyword.count)
			c := target.item (1)
			if not c.is_alpha and not c.is_digit then
				from
					i := 1
				until
					target.item (i) /= ' ' or i > target.count
				loop
					i := i + 1							
				end
				c := target.item (1)
				if c = '{' then
					s := target.substring (2, target.index_of ('}', 3))
					if not s.is_empty then
						extracted_type := type_from_type_name (s)
					end
					target.keep_tail (target.count - target.index_of ('}', 1) - 1)
				else
					extracted_type := Void
					type_extracted := False
				end
			end
		ensure
			keyword_removed: not target.substring (1, keyword.count).is_equal (keyword)
			type_removed_if_extracted: target.occurrences ('{') = 0 and target.occurrences ('}') = 0
			extracted_type_void_if_not_extracted: not type_extracted implies extracted_type = Void
			extracted_type_not_void_if_extracted: type_extracted implies extracted_type /= Void
		end
	
	type_extracted: BOOLEAN
			-- Was last call to `extract_type' successful?
	
	extracted_type: TYPE
			-- Type extracted from last call to `extract_type'

	set_standard_call is
			-- Analyzed target corresponds to a standard call
		do
			call_type := Standard_call
		end
	
	set_agent_call is
			-- Analyzed target corresponds to an agent call
		do
			call_type := Agent_call
		end
	
	set_static_call is
			-- Analyzed target corresponds to a static call
		do
			call_type := Static_call
		end
	
	set_precursor_call is
			-- Analyzed target corresponds to a Precursor call
		do
			call_type := Precursor_call
		end
	
	set_creation_call is
			-- Analyzed target corresponds to a creation call
		do
			call_type := Creation_call
		end
		
	call_type: INTEGER
			-- Analyzed target call type
			--| Can be one of the following unique values
	
	Standard_call, Agent_call, Static_call, Creation_call, Precursor_call: INTEGER is unique
			-- Possible values for `call_type'

	Agent_keyword: STRING is "agent"
			-- Eiffel agent keyword
	
	Agent_keyword_length: INTEGER is 5
			-- Eiffel agent keyword character count
	
	Feature_keyword: STRING is "feature"
			-- Eiffel feature keyword
	
	Feature_keyword_length: INTEGER is 7
			-- Eiffel feature keyword character count
	
	Precursor_keyword: STRING is "precursor"
			-- Eiffel precursor keyword
	
	Precursor_keyword_length: INTEGER is 9
			-- Eiffel precursor keyword character count
	
	Create_keyword: STRING is "create"
			-- Eiffel create keyword
	
	Create_keyword_length: INTEGER is 6
			-- Eiffel create keyword character count
	
	class_i: CLASS_I
			-- Class in which code is being completed

	locals, arguments: HASH_TABLE [STRING, STRING]
			-- Local variables and arguments used to solve member completion list.

invariant
	valid_class_i: class_i /= Void implies class_i.compiled
	valid_call_type: call_type = Standard_call or call_type = Static_call or
						call_type = Creation_call or call_type = Precursor_call or
						call_type = Agent_call

end -- class COMPLETION_INFORMATION
