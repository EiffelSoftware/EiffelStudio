indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RENAMING_A

inherit
	HASH_TABLE[INTEGER,INTEGER]
	redefine
		put
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
		do
			from
				start
			until
				after
			loop
				if a_feature_table.item_id (item_for_iteration) = Void then
					if error_report = Void then
						error_report := new_error_report
					end
					error_report.non_existent.put(names_heap.item (item_for_iteration))
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
				error_report.renamed_multiple_times.put(names_heap.item (a_original_name))
			end
			Precursor {HASH_TABLE} (a_original_name, a_new_name)
			if conflict then
				if not has_error_report then
					error_report := new_error_report
				end
				error_report.renamed_to_same_name.put(names_heap.item (a_original_name))
			end
		end

feature -- Access

	error_report: TUPLE [	renamed_multiple_times: SEARCH_TABLE[STRING];
							renamed_to_same_name: SEARCH_TABLE[STRING];
							non_existent: SEARCH_TABLE[STRING]]
		-- Error report for renaming clause. Contains all problematic cases.
		--| Is Void if no error occured.

	renamed (a_feature_id: INTEGER): INTEGER
			-- Renames `a_feature_id' or leaves it unchanged if it is not renamed.
			--| This feature calls `search' and is therefore not sideeffect free.
			--! This feature can return -1 if it finds out that this feature has benn renamed into another name.
		do
				-- We're looking for f (a_feature_id)
			search (a_feature_id)
			if found then
					-- Someone renamed x into f
					-- Result is now x
				Result := found_item
			else
				if not has_item (a_feature_id) then
						-- Nobody touched our feature:
						-- Result is therefore f (unchanged)
					Result := a_feature_id
				else
						-- f got actually renamed into y
						-- Therefore we return -1
					Result := -1
				end
			end
		ensure
			if_not_available_result_is_negative: (Result = -1) implies (has_item (a_feature_id) and not has (a_feature_id))
		end

feature -- Status

	is_feature_renamed_by_name_id	 (a_feature_name_id: INTEGER): BOOLEAN is
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
			-- Is renaming clause renaming clause valid?
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
				Result := "rename%N"
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
					 Result.append  (names_heap.item (item_for_iteration))
					 Result.append  (l_as_keyword)
					 Result.append  (names_heap.item (key_for_iteration))
					forth
				end
				Result.append (" end")
			end
		end

feature {NONE} -- Implementation

	append_to_impl (a_text_formatter: TEXT_FORMATTER;  a_class_c: CLASS_C) is
			-- Append `Current' renaming.
			--
			-- `a_text_formatter' is the object where the current renaming is appended to.			
			-- `a_type_set' is a list of types to which the renaming is actually applied. It is used to link features.
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

	new_error_report:  TUPLE [SEARCH_TABLE[STRING], SEARCH_TABLE[STRING], SEARCH_TABLE[STRING]]
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
