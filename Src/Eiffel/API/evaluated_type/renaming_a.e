indexing
	description: "[
						This class maps new feature names onto old feature names.
						It does this not by using strings but by using the `name_id' of each
						feature which obtained by using an instance of the NAMES_HEAP class.
					]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RENAMING_A

inherit

	HASH_TABLE[INTEGER,INTEGER]
		rename
			put as hashtable_put
		export
			{NONE} force, hashtable_put
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end


	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_ERROR_HANDLER
		undefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		undefine
			copy, is_equal
		end

create
	make

feature -- Operation

	check_against_feature_table (a_feature_table: FEATURE_TABLE)
			-- Checks wheter current renaming is valid against `a_feature_table'.
			-- Checks wheter each feature being renamed is an actual feature of the feature table.
		require
			a_feature_table_not_void: a_feature_table /= Void
		local
			l_check_non_existent: BOOLEAN
		do
				-- First add alias features to the table.
			adapt_alias_feature_name_properties (a_feature_table)
				-- If there were already errors we do not check this because it is not complete.
			l_check_non_existent := not has_error_report
			from
				start
			until
				after
			loop
				if l_check_non_existent then
					if a_feature_table.item_id (item_for_iteration) = Void then
						if error_report = Void then
							error_report := new_error_report
						end
						error_report.non_existent.put(names_heap.item (item_for_iteration))
					end
				end
				if
					a_feature_table.item_id (key_for_iteration) /= Void and then
					not is_feature_renamed_by_name_id (key_for_iteration)
				then
					if error_report = Void then
						error_report := new_error_report
					end
					error_report.renamed_to_same_name.put (names_heap.item (key_for_iteration))
				end
				forth
			end
		end

feature -- Element change

	put (a_original_name: INTEGER; a_new_name: INTEGER)
			-- Add pair to renaming and check for errors.
			--| `a_original_name' used to be the new item to add to the hashtable.
			--| `a_newm_name' is the key for the hashtable.
		do
			if has_item (a_original_name) then
				if not has_error_report then
					error_report := new_error_report
				end
				error_report.renamed_multiple_times.put (names_heap.item (a_original_name))
			end
			hashtable_put (a_original_name, a_new_name)
			if conflict then
				if not has_error_report then
					error_report := new_error_report
				end
				error_report.renamed_to_same_name.put (names_heap.item (a_new_name))
			end
		end

	put_alias (a_original_name: INTEGER; a_new_name: INTEGER)
			-- Add pair to renaming and check for errors.
			--| `a_original_name' used to be the new item to add to the hashtable.
			--| `a_newm_name' is the key for the hashtable.
		do
			hashtable_put (a_original_name, a_new_name)
			if conflict then
				if not has_error_report then
					error_report := new_error_report
				end
				error_report.renamed_to_same_name.put(names_heap.item (a_original_name))
			end
		end

	put_delayed_alias (a_old_name: INTEGER; a_name_with_alias: FEATURE_NAME)
			-- Add pair to renaming and check for errors.
			--| `a_original_name' used to be the new item to add to the hashtable.
			--| `a_newm_name' is the key for the hashtable.
		require
			a_name_with_alias_attached: a_name_with_alias /= Void
		do
			alias_mapping.extend ([a_old_name, a_name_with_alias])
		end

feature -- Access

	error_report: TUPLE [	renamed_multiple_times: SEARCH_TABLE[STRING];
							renamed_to_same_name: SEARCH_TABLE[STRING];
							non_existent: SEARCH_TABLE[STRING]]
		-- Error report for renaming clause. Contains all problematic cases.
		--| Is Void if no error occured.

	renamed (a_name_id: INTEGER): INTEGER
			-- Renames `a_name_id' into it's old name or leaves it unchanged if it is not renamed.
			--| This feature calls `search' and is therefore not sideeffect free.
			--| This feature can return -1 if it finds out that this `a_name_id' has been
			--| renamed into another name.
		do
				-- We're looking for f (a_name_id)
			search (a_name_id)
			if found then
					-- Someone renamed x into f
					-- Result is now x
				Result := found_item
			else
				if not has_item (a_name_id) then
						-- Nobody touched our feature:
						-- Result is therefore f (unchanged)
					Result := a_name_id
				else
						-- f got actually renamed into y
						-- Therefore we return -1
					Result := -1
				end
			end
		ensure
			if_not_available_result_is_negative:
				(Result = -1) implies (has_item (a_name_id) and not has (a_name_id))
		end

	new_name (a_feature_name_id: INTEGER): INTEGER
			-- Renames `a_feature_name_id' into it's new name or leaves it unchanged.
		do
			from
				start
			until
				after or Result /= 0
			loop
				if item_for_iteration = a_feature_name_id then
					Result := key_for_iteration
				end
				forth
			end
			if Result = 0 then
					-- No new name found for this feature
					-- Just keep the old one
				Result := a_feature_name_id
			end
		end

feature -- Status

	is_feature_renamed_by_name_id (a_feature_name_id: INTEGER): BOOLEAN is
			-- Is `a_feature' renamed under renaming of `Current'?
		do
			Result := has_item (a_feature_name_id)
		end

	is_feature_renamed (a_feature: ID_AS): BOOLEAN is
			-- Is `a_feature' renamed under renaming of `Current'?
		do
			Result := is_feature_renamed_by_name_id (a_feature.name_id)
		end

	has_error_report: BOOLEAN
			-- Is the renaming clause in-valid?
			--| Are there any features which are renamed multiple times?
			--| Are there any features which are renamed to the same name?
			--| Are there any non-existent features? (This is only the case
			--| if `check_against_feature_table' has been called.)
			--| In either case perform proper error reporting.
		do
			Result := error_report /= Void
		end

feature -- Output

	append_to_with_pebbles (a_text_formatter: TEXT_FORMATTER; a_class_c: CLASS_C)
			-- Append `Current' renaming.
			--
			-- `a_text_formatter' is the object where the current renaming is appended to.			
			-- `a_type_set' is a list of types to which the renaming is actually applied. It is used to link features.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
			a_class_c_not_void: a_class_c /= Void
		do
			append_to_impl (a_text_formatter, a_class_c)
		end

	append_to (a_text_formatter: TEXT_FORMATTER) is
			-- Append `Current' renaming.
			--
			-- `a_text_formatter' is the object where the current renaming is appended to.
		do
			append_to_impl (a_text_formatter, Void)
		end

	dump: STRING
			-- Dump
		local
			l_as_keyword, l_comma_space: STRING
		do
			l_as_keyword := " as "
			if not is_empty then
				Result := "rename "
				from
					start
				until
					after
				loop
					if l_comma_space = Void then
						l_comma_space := ", "
					else
						Result.append (l_comma_space)
					end
					Result.append (names_heap.item (item_for_iteration))
					Result.append (l_as_keyword)
					Result.append (names_heap.item (key_for_iteration))
					forth
				end
				Result.append (" end")
			end
		end

feature {NONE} -- Implementation

	predefined_names: PREDEFINED_NAMES
			-- Predefines names.
		once
			create Result
		end

	adapt_alias_feature_name_properties (a_feature_table: FEATURE_TABLE) is
			-- Checks wheter current renaming is valid against `a_feature_table'.
			-- Checks wheter each feature being renamed is an actual feature of the feature table.
		require
			a_feature_table_not_void: a_feature_table /= Void
		local
			l_alias_mapping: like alias_mapping
			l_old_name: INTEGER
			l_new_name: FEATURE_NAME
			l_infix_prefix: INFIX_PREFIX_AS
			l_feature: FEATURE_I
			l_argument_count: INTEGER
			l_operator: STRING
			vfav: VFAV_SYNTAX
		do
			from
				l_alias_mapping	:= alias_mapping
				l_alias_mapping.start
			until
				l_alias_mapping.after
			loop
				l_old_name := l_alias_mapping.item.old_name
				l_new_name := l_alias_mapping.item.feature_name
				l_feature := a_feature_table.item_id (l_old_name)
				if l_feature /= Void then
						-- TODO: This code should be refactored as it occurs almost the same way in `{AST_COMPILER_FACTORY}.new_feature_as'
					vfav := Void
					l_operator := l_new_name.alias_name.value
					l_argument_count := l_feature.argument_count

					if l_new_name.is_bracket then
						if not l_feature.has_return_value or else l_argument_count < 1 then
								-- Invalid bracket alias
							create {VFAV2_SYNTAX} vfav.make (l_new_name)
						elseif l_new_name.has_convert_mark then
								-- Invalid convert mark
							create {VFAV3_SYNTAX} vfav.make (l_new_name)
						end
					elseif l_feature.has_return_value and then (
							(l_argument_count = 0 and then l_new_name.is_valid_unary_operator (l_operator)) or else
							(l_argument_count = 1 and then l_new_name.is_valid_binary_operator (l_operator))
						)
					then
						if l_argument_count = 1 then
							l_infix_prefix ?= l_new_name
							if l_infix_prefix /= Void then
								if l_infix_prefix.is_prefix then
										-- Ok, the feature renamed is not capable to be a prefix, throw an error.
										-- Invalid operator alias
										create {VFAV1_SYNTAX} vfav.make (l_new_name)
								end
							else
								l_new_name.set_is_binary
							end
						elseif l_new_name.has_convert_mark then
								-- Invalid convert mark
							create {VFAV3_SYNTAX} vfav.make (l_new_name)
						else
							l_infix_prefix ?= l_new_name
							if l_infix_prefix /= Void then
								if l_infix_prefix.is_infix then
										-- Ok, the feature renamed is not capable to be an infix, throw an error.
										-- Invalid operator alias
										create {VFAV1_SYNTAX} vfav.make (l_new_name)
								end
							else
								l_new_name.set_is_unary
							end

						end
					else
							-- Invalid operator alias
						create {VFAV1_SYNTAX} vfav.make (l_new_name)
					end
					if vfav /= Void then
						error_handler.insert_error (vfav)
						error_handler.checksum
					end

					put_alias (l_old_name, l_new_name.internal_alias_name.name_id)
				else
					if error_report = Void then
						error_report := new_error_report
					end
					error_report.non_existent.put (names_heap.item (l_old_name))
				end

				l_alias_mapping.forth
			end
		end

	alias_mapping: ARRAYED_LIST [TUPLE [old_name: INTEGER; feature_name: FEATURE_NAME]]
			-- Alias mapping. Maps alias names to feature names.
			-- It maps it to the new name of the feature. To find the original name apply the ordinary renaming.
		do
			if alias_mapping_attribute = Void then
				create alias_mapping_attribute.make (3)
			end
			Result := alias_mapping_attribute
		ensure
			result_attached: Result /= Void
		end

	alias_mapping_attribute: like alias_mapping
			-- Reference to alias mapping.

	append_to_impl (a_text_formatter: TEXT_FORMATTER; a_class_c: CLASS_C) is
			-- Append `Current' renaming.
			--
			-- `a_text_formatter' is the object where the current renaming is appended to.			
			-- `a_type_set' is a list of types to which the renaming is actually applied. It is used to link features.
		require
			a_text_formatter_attached: a_text_formatter /= Void
			a_class_c_attached: a_class_c /= Void
		local
			l_as_keyword, l_comma_space: STRING
			l_feature: E_FEATURE
		do
			l_as_keyword := " as "

			if not is_empty then
				a_text_formatter.process_keyword_text (" rename ", Void)
				from
					start
				until
					after
				loop
					if l_comma_space = Void then
						l_comma_space := ", "
					else
						a_text_formatter.add (l_comma_space)
					end
					if a_class_c /= Void and then a_class_c.has_feature_table then
						l_feature := a_class_c.feature_with_name_id (item_for_iteration)
					end
					if l_feature /= Void then
						a_text_formatter.process_feature_text (names_heap.item (item_for_iteration), l_feature, false)
					else
						a_text_formatter.add (names_heap.item (item_for_iteration))
					end
					a_text_formatter.process_keyword_text (l_as_keyword, Void)
					a_text_formatter.add (names_heap.item (key_for_iteration))
					forth
				end
				a_text_formatter.process_keyword_text (" end", Void)
			end
		end

	new_error_report: TUPLE [SEARCH_TABLE[STRING], SEARCH_TABLE[STRING], SEARCH_TABLE[STRING]]
			-- Create a new instance of an error report.
		require
			no_error_report_exists: error_report = Void
		do
			Result := [	create {SEARCH_TABLE[STRING]}.make(3),
						create {SEARCH_TABLE[STRING]}.make (3),
						create {SEARCH_TABLE[STRING]}.make (3)]
		ensure
			result_not_void: Result /= Void
		end
end
