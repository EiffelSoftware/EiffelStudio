indexing
	description: "Helper functions used by completion mechanism"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_HELPERS

inherit
	EIFFEL_KEYWORDS
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Access

	Standard_call, Agent_call, Static_call, Creation_call, Precursor_call: INTEGER is unique
			-- Possible values for `call_type'

	call_type: INTEGER
			-- Analyzed target call type
			--| Can be one of the following unique values

	extracted_description: STRING
			-- Last extracted description with `extract_description'

	qualified_call: BOOLEAN
			-- Does current target correspond to a qualified call?

feature -- Basic operations

	extract_description (a_feature_i: FEATURE_I; a_class_i: CLASS_I) is
			-- Extract contracts from feature `l_feature_i' in class `a_class_i'.
		require
			non_void_feature: a_feature_i /= Void
			non_void_class: a_class_i /= Void
		local
			l_ctxt: FEATURE_TEXT_FORMATTER;
			l_dotnet_ctxt: DOTNET_FEATURE_TEXT_FORMATTER
			l_reader: EIFFEL_XML_DESERIALIZER
			l_consumed_type: CONSUMED_TYPE
			l_file_name: STRING
		do
			if a_feature_i.is_il_external then
				l_file_name := a_class_i.file_name
				consumed_types_cache.search (l_file_name)
				if not consumed_types_cache.found then
					create l_reader				
					l_consumed_type ?= l_reader.new_object_from_file (l_file_name)
					consumed_types_cache.put (l_consumed_type, l_file_name)
				else
					l_consumed_type := consumed_types_cache.found_item
				end
				if l_consumed_type /= Void then
					create l_dotnet_ctxt
					l_dotnet_ctxt.format_short (a_feature_i.api_feature (a_class_i.compiled_class.class_id), l_consumed_type)
					format (l_dotnet_ctxt.text)
				else
					extracted_description := ""
				end
			else
				create {FEATURE_TEXT_FORMATTER} l_ctxt
				l_ctxt.format_short (a_feature_i.api_feature (a_class_i.compiled_class.class_id), False)
				format (l_ctxt.text)
			end
			extracted_description.replace_substring_all ("%T%T-- ", "")
			extracted_description.replace_substring_all ("%T", "  ")
		end

	features_list_from_table (table: FEATURE_TABLE; class_i: CLASS_I; use_overloading: BOOLEAN): SORTABLE_ARRAY [FEATURE_DESCRIPTOR] is
			-- Convert `table' into an instance of LIST [FEATURE_DESCRIPTOR].
		require
			non_void_table: table /= Void
		local
			ci: CLASS_I
			i: INTEGER
			fi: FEATURE_I
			overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			temp_list: ARRAYED_LIST [INTEGER]
			feature_name: STRING
			descriptors: HASH_TABLE [FEATURE_DESCRIPTOR, STRING]
			descriptor: FEATURE_DESCRIPTOR
			id_table: HASH_TABLE [INTEGER, INTEGER]
		do
			ci := table.associated_class.lace_class
			if ci /= Void then
				
				-- Build `id_table' which is a reverse lookup table of `overloaded_names'
				overloaded_names := table.overloaded_names
				if overloaded_names /= Void and use_overloading then
					create id_table.make (20)
					from
						overloaded_names.start
					until
						overloaded_names.after
					loop
						temp_list := overloaded_names.item_for_iteration
						from
							temp_list.start
						until
							temp_list.after
						loop
							id_table.put (overloaded_names.key_for_iteration, temp_list.item)
							temp_list.forth
						end
						overloaded_names.forth
					end
				end
				
				-- Now create descriptors table, use `id_table' to replace resolved names
				-- with overloaded ones if necessary.
				create descriptors.make (table.count)
				from
					table.start
				until
					table.after
				loop
					fi := table.item_for_iteration
					if is_listed (fi, class_i, ci) then
						if use_overloading and id_table /= Void then
							id_table.search (table.key_for_iteration)
							if id_table.found then
								feature_name := clone (Names_heap.item (id_table.found_item))
							else
								feature_name := fi.feature_name
							end	
						else
							feature_name := fi.feature_name
						end
						descriptors.search (feature_name)
						if not descriptors.found then
							create descriptor.make_with_class_i_and_feature_i (ci, fi)
							descriptor.set_name (feature_name)
							descriptors.put (descriptor, feature_name)
						end
					end
					table.forth
				end
				
				-- Now create result from descriptors table
				create Result.make (1, descriptors.count)
				from
					i := 1
					descriptors.start
				until
					descriptors.after
				loop
					Result.put (descriptors.item_for_iteration, i)
					descriptors.forth
					i := i + 1
				end
			else
				create Result.make (1,0)
			end
		end

	recursive_lookup (target_type: TYPE; targets: LIST [STRING]; feature_table: FEATURE_TABLE; exact_match: BOOLEAN): FEATURE_TABLE is
			-- Available features after resolution of `targets' in `target_type'
		require
			non_void_target_type : target_type /= Void
			non_void_targets: targets /= Void
		local
			l_feature_table: FEATURE_TABLE
			l_cl_type: CL_TYPE_A
			l_type: TYPE
		do
			l_cl_type ?= target_type.actual_type
			if l_cl_type /= Void then
				l_feature_table := l_cl_type.associated_class.feature_table
				if targets.is_empty then
					Result := l_feature_table
				else
					l_feature_table.search (targets.first)
					if l_feature_table.found then
						l_type := l_feature_table.found_item.type
					elseif not exact_match then
						-- We are looking at something like `s.ada' where `s' is a string and
						-- `ada' the beginning but non-complete name of a feature and should return 
						-- the feature table of STRING if not `exact_match'
						Result := l_feature_table
					end
					if l_type /= Void and then not l_type.is_void then 
						targets.start
						targets.remove
						Result := recursive_lookup (l_type, targets, l_feature_table, exact_match)
					end					
				end
			end
		end

	feature_variables (locals, arguments: HASH_TABLE [STRING, STRING]; fi: FEATURE_I; feature_table: FEATURE_TABLE): HASH_TABLE [TYPE, STRING] is
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
				type := type_from_type_name (locals.item_for_iteration)
				if type /= Void then
					r_type := resolved_type (type, feature_table, fi)
					if r_type /= Void then
						Result.put (r_type, locals.key_for_iteration)
					end
				end
				locals.forth
			end
			from
				arguments.start
			until
				arguments.after
			loop
				type := type_from_type_name (arguments.item_for_iteration)
				if type /= Void then
					r_type := resolved_type (type, feature_table, fi)
					if r_type /= Void then
						Result.put (r_type, arguments.key_for_iteration)
					end
				end
				arguments.forth
			end
		end

	type_of_target (target: STRING; table: FEATURE_TABLE; ids: HASH_TABLE [TYPE, STRING]; class_i: CLASS_I): TYPE is
			-- Type of expression `target'
		require
			non_void_target: target /= Void
			valid_target: not target.is_empty
		local
			c: CHARACTER
		do
			if target.substring (1, Agent_keyword_length).is_equal (Agent_keyword) then
				-- Agent
				set_agent_call
				if target.count > Agent_keyword_length + 1 then -- Minimum agent construct is "agent?."
					extract_type (target, Agent_keyword)
					if type_extracted then
						Result := extracted_type
					else
						if target.item (target.count).is_equal ('.') then
							target.keep_head (target.count - 1) -- Remove trailing '.'								
						end
						c := target.item (1)
						if c = '?' then
							Result := class_i.compiled_class.actual_type
						else
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
				if target.count > Create_keyword_length + 1 then -- Minimum create construct is "create a."
					extract_type (target, Create_keyword)
					if type_extracted then
						Result := extracted_type
					else
						if target.item (target.count).is_equal ('.') then
							target.keep_head (target.count - 1) -- Remove trailing '.'								
						end
						Result := identifier_type (target, table, ids)						
					end
				end
			elseif target.item (1) = '!' then
				-- Creation call
				set_creation_call
				if target.item (target.count).is_equal ('.') then
					target.keep_head (target.count - 1) -- Remove trailing '.'								
				end
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

	is_listed (fi: FEATURE_I; a_class_i: CLASS_I; context: CLASS_I): BOOLEAN is
			-- Should `fi' be listed in member completion list?
		require
			non_void_feature_i: fi /= Void
			non_void_class_i: a_class_i /= Void
			valid_class_i: a_class_i.compiled
			non_void_context: context /= Void
		do
			if call_type = Standard_call or call_type = Precursor_call then
				Result := not fi.is_infix and not fi.is_prefix and
							fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
							(not qualified_call or fi.is_exported_for (a_class_i.compiled_class))

			elseif call_type = Static_call then
				Result := not fi.is_infix and not fi.is_prefix and fi.has_static_access and
							(not qualified_call or fi.is_exported_for (a_class_i.compiled_class))

			elseif call_type = Creation_call then
				if context.compiled_class.creators /= Void then
					Result := context.compiled_class.creators.has (fi.feature_name)					
				end

			elseif call_type = Agent_call then
				Result := not fi.is_infix and not fi.is_prefix and
							not fi.is_c_external and not fi.is_attribute and
							fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
							(not qualified_call or fi.is_exported_for (a_class_i.compiled_class))
			end
			if Result and fi.has_static_access and call_type /= Static_call then
				Result := not context.is_external_class
			end
		end

feature {NONE} -- Implementation

	format (a_text: STRUCTURED_TEXT) is
			-- Format `a_text' as ASCII string and put result in `extracted_description'.
		require
			non_void_text: a_text /= Void
		do
			Formatter.reset_output
			Formatter.process_text (a_text)
			extracted_description := Formatter.output
			extracted_description.left_adjust
			extracted_description.replace_substring_all ("%N%T", "%N")
			extracted_description.right_adjust
		end

	type_from_type_name (name: STRING): TYPE is
			-- Instance of {TYPE} from type name
			-- (export status {NONE})
		require
			non_void_name: name /= void
			valid_name: not name.is_empty
		local
			retried: BOOLEAN
		do
			name.prune_all (' ')
			if not retried then
				type_parser.parse_from_string ("toto " + name)
				Result := type_parser.type_node
			end
		ensure
			spaces_removed: name.occurrences (' ') = 0
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	type_parser: EIFFEL_PARSER is
			-- Type parser.
			-- (from SHARED_EIFFEL_PARSER)
		once
			create Result.make_type_parser
		end

	resolved_type (type: TYPE; feature_table: FEATURE_TABLE; fi: FEATURE_I): TYPE_A is
			-- Solve type `type' within feature `fi' in table `feature_table'.
			-- (export status {NONE})
		require
			non_void_type: type /= void
			non_void_table: feature_table /= void
			non_void_feature_i: fi /= void
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := local_evaluator.evaluated_type (type, feature_table, fi)
			end
		rescue
			retried := True
			retry
		end

	local_evaluator: LOCAL_EVALUATOR is
			-- Evaluator  of argument types
			-- (from SHARED_EVALUATOR)
			-- (export status {NONE})
		once
			create Result
		end

	identifier_type (id: STRING; table: FEATURE_TABLE; ids: HASH_TABLE [TYPE, STRING]): TYPE is
			-- Type of identifier `id' if defined in either `table' or `ids'
			-- (export status {NONE})
		require
			non_void_identifier: id /= void
			valid_identifier: not id.is_empty
			non_void_table: table /= void
			non_void_ids: ids /= void
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
				target.prune_all_leading (' ')
				target.prune_all_leading ('%T')
				c := target.item (1)
				if c = '{' then
					s := target.substring (2, target.index_of ('}', 3) - 1)
					if not s.is_empty then
						extracted_type := type_from_type_name (s)
					end
				else
					extracted_type := Void
				end
				type_extracted := extracted_type /= Void
			end
		ensure
			keyword_removed: not target.substring (1, keyword.count).is_equal (keyword)
			type_removed_if_extracted: target.occurrences ('{') = 0 and target.occurrences ('}') = 0
			extracted_type_void_if_not_extracted: not type_extracted implies extracted_type = Void
			extracted_type_not_void_if_extracted: type_extracted implies extracted_type /= Void
		end

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

	set_creation_call is
			-- Analyzed target corresponds to a creation call
		do
			call_type := Creation_call
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

feature {NONE} -- Implementation

	Formatter: STRING_FORMATTER is
			-- Text formatter for structured texts
		once
			create Result.make
		end

	extracted_type: TYPE
			-- Type extracted from last call to `extract_type'

	type_extracted: BOOLEAN
			-- Was last call to `extract_type' successful?

	consumed_types_cache: HASH_TABLE [CONSUMED_TYPE, STRING] is
			-- Cache of consumed types so as not to deserialize each time
		once
			create Result.make (128)
		end

end -- class COMPLETION_HELPERS
