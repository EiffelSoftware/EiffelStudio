note
	description: "Converts a predefined criterion to an SQL `WHERE' clause."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERION_SQL_CONVERTER

inherit
	PS_CRITERION_VISITOR [STRING]

	PS_ABEL_EXPORT

create
	make

feature {PS_CRITERION} -- Visitor functions

	visit_and (and_crit: PS_AND_CRITERION): STRING
			-- Precursor
		local
			left, right: STRING
		do
			left := visit (and_crit.left)
			right := visit (and_crit.right)

			Result := " SELECT objectid FROM (" + left + ") AS " + new_temp +
						" INNER JOIN (" + right + ") AS " + new_temp + " USING (objectid) "
		end

	visit_or (or_crit: PS_OR_CRITERION): STRING
			-- Precursor
		local
			left, right: STRING
		do
			left := visit (or_crit.left)
			right := visit (or_crit.right)

			Result := " " + left + " UNION " + right + " "
		end

	visit_not (not_crit: PS_NOT_CRITERION): STRING
			-- Precursor
		local
			child: STRING
		do
			child := visit (not_crit.child)
			Result := " SELECT objectid FROM ps_value WHERE objectid NOT IN (" + child + ") "
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): STRING
			-- Precursor
		local
			attribute_key: INTEGER
			value: STRING
		do
			value := predef_crit.value.out

			if predef_crit.operator.is_case_insensitive_equal ("like") then
				value.replace_substring_all ("*", "%%")
				value.replace_substring_all ("?", "_")
			end

			attribute_key := metadata.primary_key_of_attribute (predef_crit.attribute_name, metadata.primary_key_of_class (type.name))
			Result := "SELECT objectid FROM ps_value WHERE attributeid = " + attribute_key.out
				+ " AND value " + predef_crit.operator + " '" + value + "'"
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): STRING
			-- Precursor
		do
				-- Those criteria should be filtered in advance and thus never be called.
				-- A call to this function indicates a bug.
			check implementation_error: False end
			Result := " SELECT DISTINCT objectid FROM ps_value "
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): STRING
		do
				-- Those criteria should be filtered in advance and thus never be called.
				-- A call to this function indicates a bug.
			check implementation_error: False end
			Result := " SELECT DISTINCT objectid FROM ps_value "
		end


feature {NONE} -- Implementation

	metadata: PS_METADATA_TABLES_MANAGER
			-- Information about the class and attribute primary keys in the database.

	type: PS_TYPE_METADATA
			-- The type for building criterion strings.

	temp_count: INTEGER
			-- A counter for temporary names.

	new_temp: STRING
			-- Generates a unique temporary name.
		do
			Result := "tmp" + temp_count.out
			temp_count := temp_count + 1
		end

feature {NONE} -- Initialization


	make (meta: like metadata; a_type: like type)
			-- Initialization for `Current'.
		do
			metadata := meta
			type := a_type
		end

end
