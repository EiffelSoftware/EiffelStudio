note
	description: "Converts a criterion tree to an SQL `WHERE' clause."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERION_SQL_CONVERTER_VISITOR

inherit
	PS_CRITERION_VISITOR [STRING]

feature {PS_CRITERION} -- Visitor functions

	visit_and (and_crit: PS_AND_CRITERION): STRING
			-- Precursor
		local
			left, right: STRING
		do
			left := visit (and_crit.left)
			right := visit (and_crit.right)

			create Result.make (left.count + right.count + 7)
			Result.extend ('(')
			Result.append (left)
			Result.append (" AND ")
			Result.append (right)
			Result.extend (')')
		end

	visit_or (or_crit: PS_OR_CRITERION): STRING
			-- Precursor
		local
			left, right: STRING
		do
			left := visit (or_crit.left)
			right := visit (or_crit.right)

			create Result.make (left.count + right.count + 6)
			Result.extend ('(')
			Result.append (left)
			Result.append (" OR ")
			Result.append (right)
			Result.extend (')')
		end

	visit_not (not_crit: PS_NOT_CRITERION): STRING
			-- Precursor
		local
			child: STRING
		do
			child := visit (not_crit.child)
			Result := "NOT " + child
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): STRING
			-- Precursor
		local
			attribute_key: INTEGER
			value: STRING
			i: INTEGER
		do
			value := predef_crit.value.out
			if predef_crit.operator.is_case_insensitive_equal ("like") then
				replace_chars (value)
			end

			create Result.make (
				predef_crit.attribute_name.count +
				predef_crit.operator.count +
				value.count + 4)


			Result.append (predef_crit.attribute_name)
			Result.extend (' ')
			Result.append (predef_crit.operator)
			Result.extend (' ')

			if attached {READABLE_STRING_GENERAL} predef_crit.value then
				Result.extend ('%'')
				Result.append (value)
				Result.extend ('%'')
			else
				Result.append (value)
			end
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): STRING
			-- Precursor
		do
				-- Those criteria should be filtered in advance and thus never be called.
				-- A call to this function indicates a bug.
			check implementation_error: False end
			Result := ""
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): STRING
		do
				-- Those criteria should be filtered in advance and thus never be called.
				-- A call to this function indicates a bug.
			check implementation_error: False end
			Result := ""
		end

feature {NONE} -- Implementation

	replace_chars (value: STRING)
			-- Replace all occurences of '*' with '%'
			-- and '?' with '_'.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > value.count
			loop
				inspect
					value [i]
				when '*' then
					value [i] := '%%'
				when '?' then
					value [i] := '_'
				else
					-- Do nothing
				end
				i := i + 1
			variant
				value.count + 1 - i
			end
		end

end
