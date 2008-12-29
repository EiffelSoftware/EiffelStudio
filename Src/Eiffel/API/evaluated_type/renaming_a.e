note
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
			put as ht_put,
			make as ht_make
		export
			{NONE} force, ht_put
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

feature {NONE} -- Initialization

	make (a_renamings: EIFFEL_LIST [RENAME_AS]; a_constraint: CLASS_C)
			-- Create current
		require
			a_renamings_not_void: a_renamings /= Void
			a_constraint_not_void: a_constraint /= Void
		local
			l_rename: RENAME_AS
			l_new_name: FEATURE_NAME
			l_old_name_id: INTEGER
			l_feature_table: FEATURE_TABLE
			l_old_feature: FEATURE_I
		do
				-- Create table.
			ht_make (a_renamings.count)

				-- Initialize table.
			from
				l_feature_table := a_constraint.feature_table
				a_renamings.start
			until
				a_renamings.after
			loop
				l_rename := a_renamings.item
				l_old_name_id := l_rename.old_name.internal_name.name_id
				l_old_feature := l_feature_table.item_id (l_old_name_id)
				if l_old_feature = Void then
						-- Old name does not even exist, don't bother checking the new name.
					if error_report = Void then
						error_report := new_error_report
					end
					error_report.non_existent.put(names_heap.item (l_old_name_id))
				else
					l_new_name := l_rename.new_name
						-- Add new name to the list.
					put (l_old_name_id, l_new_name.internal_name.name_id)

					if {l_infix_prefix_name: INFIX_PREFIX_AS} l_new_name then
							-- Check validity of infix/prefix for that particular routine.
						process_alias (l_rename.new_name, l_old_feature)
							-- No need to add it, because infix have the same internal name as their alias.
					elseif {l_alias_name: FEATURE_NAME_ALIAS_AS} l_new_name then
							-- Check validity of alias for that particular routine.
						process_alias (l_rename.new_name, l_old_feature)
							-- Because `l_old_name_id' is already there, we do not want to generate an error
							-- and thus we call `internal_put'.
						internal_put (l_old_name_id, l_new_name.internal_alias_name_id)
					end

						-- If previously it was an alias routine, we removed the alias from the original class.
					if l_old_feature.alias_name_id /= 0 and not l_old_feature.is_infix and not l_old_feature.is_prefix then
						if removed_alias = Void then
							create removed_alias.make (10)
						end
						removed_alias.extend (l_old_feature.alias_name_id)
					end
				end
				a_renamings.forth
			end

				-- Check that we do not end up with twice or more feature with the same name.
			from
				start
			until
				after
			loop
				if
					l_feature_table.has_id (key_for_iteration) and then
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
				if not has_error then
					error_report := new_error_report
				end
				error_report.renamed_multiple_times.put (names_heap.item (a_original_name))
			end
			internal_put (a_original_name, a_new_name)
		end

feature {NONE} -- Element change

	internal_put (a_original_name: INTEGER_32; a_new_name: INTEGER_32)
			-- Add pair to renaming and check for errors.
		do
			ht_put (a_original_name, a_new_name)
			if conflict then
				if not has_error then
					error_report := new_error_report
				end
				error_report.renamed_to_same_name.put (names_heap.item (a_new_name))
			end
		end

feature -- Access

	error_report: TUPLE [renamed_multiple_times: SEARCH_TABLE[STRING];
						renamed_to_same_name: SEARCH_TABLE[STRING];
						non_existent: SEARCH_TABLE[STRING]]
			-- Error report for renaming clause. Contains all problematic cases.
			--| Is Void if no error occured.

	renamed (a_name_id: INTEGER): INTEGER
			-- Renames `a_name_id' into it's old name or leaves it unchanged if it is not renamed.
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
				if removed_alias /= Void and removed_alias.has (a_name_id) then
					Result := -1
				elseif not has_item (a_name_id) then
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
			renamed_result_valid: Result > 0 or Result = -1
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

	is_feature_renamed_by_name_id (a_feature_name_id: INTEGER): BOOLEAN
			-- Is `a_feature' renamed under renaming of `Current'?
		do
			Result := has_item (a_feature_name_id)
		end

	is_feature_renamed (a_feature: ID_AS): BOOLEAN
			-- Is `a_feature' renamed under renaming of `Current'?
		do
			Result := is_feature_renamed_by_name_id (a_feature.name_id)
		end

	has_error: BOOLEAN
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
			-- `a_type_set' is a list of types to which the renaming is actually applied. It is used
			-- to link features.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
			a_class_c_not_void: a_class_c /= Void
		do
			append_to_impl (a_text_formatter, a_class_c)
		end

	append_to (a_text_formatter: TEXT_FORMATTER)
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

	removed_alias: ARRAYED_LIST [INTEGER]
			-- List of removed aliases from the original class.

	process_alias (a_name: FEATURE_NAME; a_old_feature: FEATURE_I)
			-- Check if `a_rename' is a valid infix/prefix/alias.
		require
			a_name_not_void: a_name /= Void
			a_old_feature_not_void: a_old_feature /= Void
		local
			l_infix_prefix: INFIX_PREFIX_AS
			l_argument_count: INTEGER
			l_operator: STRING
			l_vfav: VFAV_SYNTAX
		do
				-- TODO: This code should be refactored as it occurs almost the same way in
				-- `{AST_COMPILER_FACTORY}.new_feature_as'
			l_operator := a_name.alias_name.value
			l_argument_count := a_old_feature.argument_count

			if a_name.is_bracket then
				if not a_old_feature.has_return_value or else l_argument_count < 1 then
						-- Invalid bracket alias
					create {VFAV2_SYNTAX} l_vfav.make (a_name)
				elseif a_name.has_convert_mark then
						-- Invalid convert mark
					create {VFAV3_SYNTAX} l_vfav.make (a_name)
				end
			elseif
				a_old_feature.has_return_value and then
				((l_argument_count = 0 and then a_name.is_valid_unary_operator (l_operator)) or else
				(l_argument_count = 1 and then a_name.is_valid_binary_operator (l_operator)))
			then
				if l_argument_count = 1 then
					l_infix_prefix ?= a_name
					if l_infix_prefix /= Void then
						if l_infix_prefix.is_prefix then
								-- Ok, the feature renamed is not capable to be a prefix, throw an error.
								-- Invalid operator alias
								create {VFAV1_SYNTAX} l_vfav.make (a_name)
						end
					else
						a_name.set_is_binary
					end
				elseif a_name.has_convert_mark then
						-- Invalid convert mark
					create {VFAV3_SYNTAX} l_vfav.make (a_name)
				else
					l_infix_prefix ?= a_name
					if l_infix_prefix /= Void then
						if l_infix_prefix.is_infix then
								-- Ok, the feature renamed is not capable to be an infix, throw an error.
								-- Invalid operator alias
								create {VFAV1_SYNTAX} l_vfav.make (a_name)
						end
					else
						a_name.set_is_unary
					end

				end
			else
					-- Invalid operator alias
				create {VFAV1_SYNTAX} l_vfav.make (a_name)
			end
			if l_vfav /= Void then
				error_handler.insert_error (l_vfav)
			end
		end

	append_to_impl (a_text_formatter: TEXT_FORMATTER; a_class_c: CLASS_C)
			-- Append `Current' renaming.
			--
			-- `a_text_formatter' is the object where the current renaming is appended to.			
			-- `a_type_set' is a list of types to which the renaming is actually applied. It is used to
			-- link features.
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
						a_text_formatter.process_feature_text (names_heap.item (item_for_iteration), l_feature, False)
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
