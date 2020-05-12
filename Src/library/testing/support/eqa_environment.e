note
	description: "[
		Objects that provide settings for executing an {EQA_TEST_SET}. A settings conists of an
		key-value pair of type {STRING}.
		The settings are once per thread, meaning that any {EQA_ENVIRONMENT} instances will have
		the same state if they are accessed in the same thread.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_ENVIRONMENT

feature -- Access

	item (a_key: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_32
			-- Retrieve setting for given key
			--
			-- `a_key': Key for which setting should be returned.
			-- `Result': Value associated with `a_key'.
		require
			a_key_attached: a_key /= Void
		do
			table.search (a_key)
			if table.found then
				Result := table.found_item
			end
		end

	item_attached (a_key: READABLE_STRING_GENERAL; an_asserter: EQA_ASSERTIONS): IMMUTABLE_STRING_32
			-- Retrieve setting for given key or rise exception if no value for given key has been defined.
			--
			-- `a_key': Key for which setting should be returned.
			-- `an_asserter': Asserter in which exceptions are raised if value could not be retrieved.
			-- `Result': Value associated with `a_key'.
		require
			a_key_attached: a_key /= Void
			an_asserter_attached: an_asserter /= Void
		do
			if attached item (a_key) as l_v then
				Result := l_v
			else
				an_asserter.assert (a_key.as_string_32 + {STRING_32} " not defined", False)
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	item_not_empty (a_key: READABLE_STRING_GENERAL; an_asserter: EQA_ASSERTIONS): IMMUTABLE_STRING_32
			-- Retrieve setting for given key or rise exception if no value for given key has been defined
			-- or the value defined is empty.
			--
			-- `a_key': Key for which setting should be returned.
			-- `an_asserter': Asserter in which exceptions are raised if value could not be retrieved.
			-- `Result': Non-empty value associated with `a_key'.
		require
			a_key_attached: a_key /= Void
			an_asserter_attached: an_asserter /= Void
		do
			Result := item_attached (a_key, an_asserter)
			an_asserter.assert (a_key.as_string_32 + {STRING_32} " is empty", not Result.is_empty)
		end

feature -- Access: obsolete

	get (a_key: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_8
			-- Retrieve setting for given key
			--
			-- `a_key': Key for which setting should be returned.
			-- `Result': Value associated with `a_key'..
		obsolete "Use `item` [2017-05-31]"
		require
			a_key_attached: a_key /= Void
		do
			if attached item (a_key) as v then
				create Result.make_from_string (v.as_string_8)
			end
		end

	get_attached (a_key: READABLE_STRING_GENERAL; an_asserter: EQA_ASSERTIONS): IMMUTABLE_STRING_8
			-- Retrieve setting for given key or rise exception if no value for given key has been defined.
			--
			-- `a_key': Key for which setting should be returned.
			-- `an_asserter': Asserter in which exceptions are raised if value could not be retrieved.
			-- `Result': Value associated with `a_key'.
		obsolete "Use `item_attached` [2017-05-31]"
		require
			a_key_attached: a_key /= Void
			an_asserter_attached: an_asserter /= Void
		do
			create Result.make_from_string (item_attached (a_key, an_asserter).as_string_8)
		ensure
			result_attached: Result /= Void
		end

	get_not_empty (a_key: READABLE_STRING_GENERAL; an_asserter: EQA_ASSERTIONS): IMMUTABLE_STRING_8
			-- Retrieve setting for given key or rise exception if no value for given key has been defined
			-- or the value defined is empty.
			--
			-- `a_key': Key for which setting should be returned.
			-- `an_asserter': Asserter in which exceptions are raised if value could not be retrieved.
			-- `Result': Non-empty value associated with `a_key'.
		obsolete "Use `item_not_empty` [2017-05-31]"
		require
			a_key_attached: a_key /= Void
			an_asserter_attached: an_asserter /= Void
		do
			create Result.make_from_string (item_not_empty (a_key, an_asserter).as_string_8)
		end

feature {NONE} -- Access

	table: STRING_TABLE [IMMUTABLE_STRING_32]
			-- Table in which settings are stored.
		once
			create Result.make (default_table_size)
		end

feature -- Status setting

	put (a_value: READABLE_STRING_GENERAL; a_key: READABLE_STRING_GENERAL)
			-- Set the value for a given key.
			--
			-- `a_value': Value for new setting.
			-- `a_key': Key for new setting.
		require
			a_value_attached: a_value /= Void
			a_key_attached: a_key /= Void
		local
			l_ivalue: IMMUTABLE_STRING_32
		do
			if attached {IMMUTABLE_STRING_32} a_value as l_v then
				l_ivalue := l_v
			else
				create l_ivalue.make_from_string_general (a_value)
			end
			table.force (l_ivalue, a_key)
		ensure
			set: attached item (a_key) as l_value and then a_value.same_string (l_value)
		end

feature {EQA_EVALUATOR} -- Status setting

	reset
			-- Reset all settings.
		do
			table.wipe_out
		end

feature {NONE} -- Query

	is_identifier_char (c: CHARACTER_32): BOOLEAN
			-- Is `c' an identifier character?
		do
			Result := (c >= 'A' and c <= 'Z') or
				(c >= 'a' and c <= 'z') or
				(c >= '0' and c <= '9') or
				(c = '_');
		end

feature -- Basic operations

	substitute_recursive (a_line: READABLE_STRING_GENERAL): STRING_32
			-- Call `substitute' recursively util no '$' found anymore
		require
			not_void: a_line /= Void
		local
			l_temp: STRING_32
			l_stop: BOOLEAN
		do
			from
				create Result.make_from_string_general (a_line)
			until
				not Result.has ('$') or l_stop
			loop
				l_temp := substitute (Result)
				if l_temp.same_string (Result) then
					l_stop := True
				else
					l_stop := False
					Result := l_temp
				end
			end
		ensure
			not_void: Result /= Void
		end

	substitute (a_line: READABLE_STRING_GENERAL): STRING_32
			-- `line' with all environment variables replaced
			-- by their values (or left alone if not in
			-- environment)
		require
			line_not_void: a_line /= Void
		local
			k, l_count, l_start: INTEGER
			c: CHARACTER_32
			l_word: READABLE_STRING_GENERAL
			l_subst_started, l_in_group: BOOLEAN
		do
			create Result.make (a_line.count)
			from
				l_count := a_line.count
				k := 1
			until
				k > l_count
			loop
				c := a_line.item (k)
				if c = Substitute_char then
					if l_subst_started then
						l_subst_started := False
						Result.extend (c)
					else
						l_subst_started := True
					end
				elseif l_subst_started then
					if c = Left_group_char then
						l_in_group := True
					else
						from
							l_start := k
						until
							k > l_count or not is_identifier_char (a_line.item (k))
						loop
							k := k + 1
						end
						k := k - 1
						l_word := a_line.substring (l_start, k)
						if attached item (l_word) as l_replacement then
							Result.append (l_replacement)
						else
							Result.extend (Substitute_char)
							Result.append_string_general (l_word)
						end
						if l_in_group then
							l_in_group := False
							k := k + 1
							-- Skip right paren
						end
						l_subst_started := False
					end
				else
					Result.extend (c)
				end
				k := k + 1
			end
			if l_subst_started then
				Result.extend (c)
			end
		end

feature {NONE} -- Constants

	default_table_size: INTEGER = 10
			-- Default number of settings stored in `table'

	Substitute_char: CHARACTER_32 = '$'
			-- Character which triggers environment variable
			-- substitution

	Left_group_char: CHARACTER_32 = '('
	Right_group_char: CHARACTER_32 = ')'
			-- Characters which are used for setting environment
			-- variable name off from surrounding text

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
