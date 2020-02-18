note
	description: "Fixes violations of rule #50 ('Local variable only used for Result')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LOCAL_USED_FOR_RESULT_FIX

inherit
	CA_FIX
		redefine
			execute,
			process_access_id_as,
			process_assign_as
		end

create
	make_with_feature_type_and_index

feature {NONE} -- Initialization

	make_with_feature_type_and_index (a_class: attached CLASS_C; a_feature: attached FEATURE_AS; a_local_type: attached TYPE_A; a_local_index: attached INTEGER; a_access: attached ACCESS_ID_AS)
			-- Initializes `Current' with class `a_class'. `a_local_type' is the type of the local variable which violates the rule.
			-- `a_feature' is the feature in which the rule was violated. `a_local_index' is the internal index of the local from its local_dec_list_as.
		do
			make (ca_names.local_used_for_result_fix, a_class)
			local_type := a_local_type
			feature_as := a_feature
			local_index := a_local_index
			access_id_as := a_access
		end

feature {NONE} -- Implementation

	execute
			-- <Precursor>
		local
			l_list: LINKED_LIST[TUPLE[INTEGER, TYPE_A]]
		do
				-- Remove local.

			create l_list.make
			l_list.extend ([local_index, local_type])

			(create {CA_FIX_UNUSED_LOCAL_APPLICATION}.make (l_list, feature_as, match_list)).do_nothing

				-- Process the feature to replace the local with Result.
			process_feature_as (feature_as)
		end

	process_access_id_as (a_access_id: attached ACCESS_ID_AS)
		do
			if a_access_id.is_equivalent (access_id_as) then
				a_access_id.replace_text ("Result", match_list)
			end
		end

	process_assign_as (a_assign: attached ASSIGN_AS)
		do
			Precursor (a_assign)

			if
				attached {RESULT_AS} a_assign.target
				and then attached {EXPR_CALL_AS} a_assign.source as l_expr_call
				and then attached {ACCESS_ID_AS} l_expr_call.call as l_access
				and then l_access.is_equivalent (access_id_as)
			then
				a_assign.remove_text (match_list)
			end
		end

	local_type: TYPE_A
		-- The type of the local variable to be replaced and removed.

	local_index: INTEGER
		-- The internal index of the local variable to be replaced and removed.

	access_id_as: ACCESS_ID_AS
		-- One of the accesses to the local variable to be replaced and removed.

	feature_as: FEATURE_AS
		-- The ast node of the feature in wich the rule was violated.

;note
	ca_ignore: "CA011", "CA011: too many arguments"
end
