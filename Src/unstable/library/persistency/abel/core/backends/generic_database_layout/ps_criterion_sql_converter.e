note
	description: "Summary description for {PS_CRITERION_SQL_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERION_SQL_CONVERTER

inherit
	PS_CRITERION_VISITOR [STRING]

	REFACTORING_HELPER

create
	make

feature {PS_CRITERION} -- Visitor functions

	visit_and (and_crit: PS_AND_CRITERION): STRING
		local
			left, right: STRING
		do
			left := visit (and_crit.left)
			right := visit (and_crit.right)

			Result := " SELECT objectid FROM (" + left + ") AS " + new_temp +
						" INNER JOIN (" + right + ") AS " + new_temp + " USING (objectid) "
		end

	visit_or (or_crit: PS_OR_CRITERION): STRING
		local
			left, right: STRING
		do
			left := visit (or_crit.left)
			right := visit (or_crit.right)

--			Result := "(" + left + " UNION " + right + ")"
			Result := " " + left + " UNION " + right + " "
		end

	visit_not (not_crit: PS_NOT_CRITERION): STRING
		local
			child: STRING
		do
			child := visit (not_crit.child)
			Result := " SELECT objectid FROM ps_value WHERE objectid NOT IN (" + child + ") "
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): STRING
		local
			attribute_key: INTEGER
			value: STRING
		do
			value := predef_crit.value.out

			if predef_crit.operator.is_case_insensitive_equal ("like") then
				value.replace_substring_all ("*", "%%")
				value.replace_substring_all ("?", "_")
			end

			attribute_key := metadata.primary_key_of_attribute (predef_crit.attribute_name, metadata.primary_key_of_class (type.base_class.name))
			Result := "SELECT objectid FROM ps_value WHERE attributeid = " + attribute_key.out
				+ " AND value " + predef_crit.operator + " '" + value + "'"
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): STRING
		do
			fixme ("Should be filtered in advance and thus never called...")
			Result := " SELECT DISTINCT objectid FROM ps_value "
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): STRING
		do
			check implementation_error: False end
--			fixme ("Should be filtered in advance and thus never called...")
			Result := " SELECT DISTINCT objectid FROM ps_value "
		end


feature {NONE} -- Implementation

	type: PS_TYPE_METADATA

	temp_count: INTEGER

	new_temp: STRING
		do
			Result := "tmp" + temp_count.out
			temp_count := temp_count + 1
		end

feature {NONE} -- Initialization

	metadata: PS_METADATA_TABLES_MANAGER

	make (meta: like metadata; a_type: like type)
		do
			metadata := meta
			type := a_type
		end

end
