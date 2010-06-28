note
	description: "[
		Objects that provide settings for executing an {EQA_TEST_SET}. A settings conists of an
		key-value pair of type {STRING}.
		The settings are once per thread, meaning that any {EQA_ENVIRONMENT} instances will have
		the same state if they are accessed in the same thread.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_ENVIRONMENT

feature -- Access

	get (a_key: READABLE_STRING_8): detachable IMMUTABLE_STRING_8
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

	get_attached (a_key: READABLE_STRING_8; a_test_set: EQA_TEST_SET): IMMUTABLE_STRING_8
			-- Retrieve setting for given key or rise exception if no value for given key has been defined.
			--
			-- `a_key': Key for which setting should be returned.
			-- `a_test_set': Test set in which assertions is raised if value could not be retrieved.
			-- `Result': Value associated with `a_key'.
		require
			a_key_attached: a_key /= Void
			a_test_set_attached: a_test_set /= Void
		local
			l_value: like get
		do
			if attached get (a_key) as l_v then
				l_value := l_v
			else
				a_test_set.assert (a_key + " not defined", False)
				check not_reached: l_value /= Void end
			end
			Result := l_value
		ensure
			result_attached: Result /= Void
		end

	get_not_empty (a_key: READABLE_STRING_8; a_test_set: EQA_TEST_SET): IMMUTABLE_STRING_8
			-- Retrieve setting for given key or rise exception if no value for given key has been defined
			-- or the value defined is empty.
			--
			-- `a_key': Key for which setting should be returned.
			-- `a_test_set': Test set in which assertions is raised if value could not be retrieved.
			-- `Result': Non-empty value associated with `a_key'.
		require
			a_key_attached: a_key /= Void
			a_test_set_attached: a_test_set /= Void
		do
			Result := get_attached (a_key, a_test_set)
			a_test_set.assert (a_key + " is empty", not Result.is_empty)
		end

feature {NONE} -- Access

	table: HASH_TABLE [IMMUTABLE_STRING_8, READABLE_STRING_8]
			-- Table in which settings are stored.
		once
			create Result.make (default_table_size)
		end

feature -- Status setting

	put (a_value: READABLE_STRING_8; a_key: READABLE_STRING_8)
			-- Set the value for a given key.
			--
			-- `a_value': Value for new setting.
			-- `a_key': Key for new setting.
		require
			a_value_attached: a_value /= Void
			a_key_attached: a_key /= Void
		local
			l_ivalue: IMMUTABLE_STRING_8
		do
			if attached {IMMUTABLE_STRING_8} a_value as l_v then
				l_ivalue := l_v
			else
				create l_ivalue.make_from_string (a_value)
			end
			table.force (a_value, a_key)
		ensure
			set: a_value ~ get (a_key)
		end

feature {EQA_EVALUATOR} -- Status setting

	reset
			-- Reset all settings.
		do
			table.wipe_out
		end

feature {NONE} -- Query

	is_identifier_char (c: CHARACTER): BOOLEAN
			-- Is `c' an identifier character?
		do
			Result := (c >= 'A' and c <= 'Z') or
				(c >= 'a' and c <= 'z') or
				(c >= '0' and c <= '9') or
				(c = '_');
		end

feature -- Basic operations

	substitute_recursive (a_line: STRING): STRING
			-- Call `substitute' recursively util no '$' found anymore
		require
			not_void: a_line /= Void
		local
			l_temp: STRING
			l_stop: BOOLEAN
		do
			from
				Result := a_line
			until
				not Result.has ('$') or l_stop
			loop
				l_temp := substitute (Result)
				if l_temp.is_equal (Result) then
					l_stop := True
				else
					l_stop := False
					Result := l_temp
				end
			end
		ensure
			not_void: Result /= Void
		end

	substitute (a_line: STRING): STRING
			-- `line' with all environment variables replaced
			-- by their values (or left alone if not in
			-- environment)
		require
			line_not_void: a_line /= Void
		local
			k, l_count, l_start: INTEGER
			c: CHARACTER
			l_word: STRING
			l_replacement: detachable READABLE_STRING_8
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
						l_replacement := get (l_word)
						if l_replacement /= Void then
							Result.append (l_replacement)
						else
							Result.extend (Substitute_char)
							Result.append (l_word)
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

	Substitute_char: CHARACTER = '$'
			-- Character which triggers environment variable
			-- substitution

	Left_group_char: CHARACTER = '('
	Right_group_char: CHARACTER = ')'
			-- Characters which are used for setting environment
			-- variable name off from surrounding text

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
