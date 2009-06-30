note
	description: "[
		Base enumeration type implementation for pseduo enumeration types.
		
		See the written article on http://dev.eiffel.com/Enums_in_Eiffel where
		this code was extracted from.
	]"
	legal   : "See notice at end of class."
	status  : "See notice at end of class.";
	author  : "Paul Bates (paul.a.bates@gmail.com)"
	date    : "$Date$"
	revision: "$Revision$"

deferred class
	ENUM_TYPE [G -> NUMERIC]

inherit
	HASHABLE
		redefine
			default_create,
			out
		end

	PART_COMPARABLE
		redefine
			default_create,
			out
		end

convert
	item: {G}

feature {ENUM_TYPE} -- Initialization

	frozen default_create
			-- Default initialization.
		do
			make ((items[1]).item)
		end

	frozen make (n: G)
			-- Initializes instance from base entity `n'
			--
			-- `n': A numerical value associated with a member of `Current'
		require
			n_is_valid_numeric_value: is_valid_numeric_value (n)
		do
			internal_value := n
		ensure
			internal_value_set: internal_value = n
		end

feature -- Access

	frozen items: ARRAY [like Current]
			-- Access to all members of `Current'
		local
			l_items: detachable ARRAY [G]
			l_internal: INTERNAL
			l_id: INTEGER
			l_count, i: INTEGER
			l_assert: BOOLEAN
		do
			create l_internal
			l_id := l_internal.dynamic_type (Current)
			if attached {ARRAY [like Current]} internal_items_table.item (l_id) as l_result then
				Result := l_result
			else
				check not_internal_items_table_has_l_id: not internal_items_table.has (l_id) end
				l_items := members
				l_count := l_items.count
				create Result.make (1, l_count)

				l_assert := {ISE_RUNTIME}.check_assert (False)
				from i := 1 until i > l_count loop
						-- Does automatic conversion
					if attached {like Current} l_internal.new_instance_of (l_id) as l_instance then
						l_instance.make (l_items.item (i))
						Result.put (l_instance, i)
					end
					i := i + 1
				end
				l_assert := {ISE_RUNTIME}.check_assert (l_assert)

				internal_items_table.force (Result, l_id)
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
			internal_items_table_has_current: internal_items_table.has (
				(create {INTERNAL}).dynamic_type (Current))
		end

	frozen hash_code: INTEGER
			-- <Precursor>
		do
			if attached {HASHABLE} internal_value as l_hashable then
				Result := l_hashable.hash_code
			else
				check False end
			end
		end

feature {ENUM_TYPE} -- Access

	frozen internal_items_table: HASH_TABLE [ARRAY [ENUM_TYPE [NUMERIC]], INTEGER]
			-- Items table used to cache member info.
		once
			create Result.make (1)
		ensure
			result_attached: attached Result
		end

	frozen internal_value: G
			-- Internal raw value (do not rename!)

feature -- Query

   is_valid_numeric_value (n: G): BOOLEAN
			-- Determines if `n' a value associated with a member of `Current'.
			--
			-- `n': A numerical value to check for validity against members of `Current'.
			-- `Result': True if `n' a valid member, False otherwise.
		local
			l_assert: BOOLEAN
		do
			Result := True
			l_assert := {ISE_RUNTIME}.check_assert (False)
				-- Kind of a hack but it's the most direct way to check.
				-- `n' converted into `like Current'
			Result := members.has (n)
			l_assert := {ISE_RUNTIME}.check_assert (l_assert)
		end

feature {NONE} -- Factory

	members: ARRAY [G]
			-- Array of all members of `Current'.
			--
			-- Note to Implementers: This function should be a once!
		deferred
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
			result_lower_is_one: Result.lower = 1
			result_upper_is_count: Result.upper = Result.count
			result_contains_unique_items: (agent (a_result: ARRAY [G]): BOOLEAN
				require
					a_result_attached: a_result /= Void
				local
					l_upper, i: INTEGER
				do
					Result := True
					l_upper := a_result.upper
					from i := a_result.lower until i > l_upper or not Result loop
						Result := a_result.occurrences (a_result[i]) = 1
						i := i + 1
					end
				end).item ([Result])
			same_result: Result = members
		end

feature -- Comparison

	frozen is_less alias "<" (other: ENUM_TYPE [G]): BOOLEAN
			-- <Precursor>
		do
			if
				attached {PART_COMPARABLE} internal_value as l_cc and then
				attached {PART_COMPARABLE} internal_value as l_oc
			then
				Result := l_cc < l_oc
			end
		end

feature -- Conversion

	frozen item: G
			-- `Current' as a {NUMERIC} value
		do
			Result := internal_value
		ensure
			result_set: Result = internal_value
			result_is_valid_numeric_value: is_valid_numeric_value (Result)
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := internal_value.out
		end

invariant
   is_valid_numeric_value: is_valid_numeric_value (internal_value)

end
