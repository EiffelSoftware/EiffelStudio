indexing
	description: "Objects that map members parsed. Only used with VS."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_MEMBERS_MAPPING

feature -- Access

	members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION is
			-- Retrieve members.
		do
			Result := internal_members.item (0)
		end

	output_available: BOOLEAN is
--			-- Is the selection available from the output.
--		local
--			a_selection: TEXT_SELECTION
--			retried: BOOLEAN
		do
--			if not retried and output /= Void then
--				a_selection := output.selection
--					-- If selection is not available then a COM exception is raised.
--				Result := True
--			end
--		rescue
--			(create {ECDP_EVENTS_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
--			retried := True
--			retry
		end
		
	text_offset (a_start_pos: INTEGER): INTEGER is
			-- Retrieve the text offset at a given `position'
			-- ( ie : if text has been inserted then the offset is positive
			-- 		  if text has been deleted then the offset is negative)
		require
			positive_start_position: a_start_pos >= 0
		local
			l_start_pos, l_decalage: INTEGER
		do
			from
				internal_text_offset.start
			until
				internal_text_offset.after
			loop
				l_start_pos := internal_text_offset.item.integer_item (1)
				if l_start_pos < a_start_pos then
					l_decalage := internal_text_offset.item.integer_item (2)
					Result := Result + l_decalage
				end
				internal_text_offset.forth
			end
		end

	code_parsed: BOOLEAN is
			-- Has Eiffel code already been parsed?
		do
			Result := internal_code_parsed.item
		end
		
feature -- Status Setting

	set_members (members_list: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION) is
			-- Set `members' with `members_list'.
		local
			l_members_clone: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
		do
			create l_members_clone.make (members_list)
			internal_members.put (0, l_members_clone)
		ensure
			members_set: members.equals (members_list)
		end

	add_text_offset (start_pos: INTEGER; a_text_offset: INTEGER) is
			-- start_pos: position where text has been added or removed.
			-- text_offset: number of char added or removed. If char removed then `a_text_offset' is negative.
		require
			positive_start_position: start_pos >= 0
		local
		do
			internal_text_offset.force ([start_pos, a_text_offset])
		end

	set_code_parsed (a_bool: like code_parsed) is
			-- Set `code_parsed' with `a_bool'.
		do
			internal_code_parsed.put (a_bool)
		ensure
			code_parsed_set: code_parsed = a_bool
		end
		
feature -- Basic operation

	reset_text_offset is
			-- Reset `text_offset'.
		do
			internal_text_offset.wipe_out
		ensure
			text_offset_null: text_offset (1000) = 0
		end

	reset_feature_clauses is
			-- Reset `feature_clauses' at begining of a parsing.
		do
			Internal_feature_clauses.wipe_out
		end

	bottom_position_last_feature: INTEGER is
			-- Retrieve the bottom position where we can introduce some new code in the text document.
		local
			i, l_member_end_pos: INTEGER
			l_user_data: ECDP_USER_DATA_KEYS
		do
			create l_user_data
			from
				i := 0
			until
				i = members.count
			loop
				l_member_end_pos ?= members.item (i).user_data.item (l_user_data.End_position)
				if l_member_end_pos > Result then
					Result := l_member_end_pos
				end
				i := i + 1
			end
		end

	add_feature_clause (a_line: INTEGER) is
			-- add line number of a feature clause.
		require
			positive_line: a_line > 0
		do
			internal_feature_clauses.force (a_line)
		ensure
			line_inserted: internal_feature_clauses.has (a_line)
		end

feature {NONE} -- Implementation

	internal_members: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION] is
			-- Internal representation of `members'.
		once
			create Result.make (1)
		ensure
			non_void_internal_members: Result /= Void
		end

	internal_text_offset: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]] is
			-- Internal representation of `text_offset'.
		once
			create Result.make (10)
		ensure
			non_void_internal_text_offset: Result /= Void
		end

	internal_feature_clauses: ARRAYED_LIST [INTEGER] is
			-- Internal representation of feature clauses.
			-- Store lines where there is feature clauses in output.
		once
			create Result.make (4)
		ensure
			non_void_internal_feature_clauses: Result /= Void
		end

	internal_code_parsed: CELL [BOOLEAN] is
			-- Internal representation of feature `code_parsed'.
		once
			create Result.put (False)
		ensure
			non_void_internal_code_parsed: Result /= Void
		end

end -- class ECDP_MEMBERS_MAPPING
