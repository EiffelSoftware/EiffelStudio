note
	description: "Fixes violations of rule #9 ('Useless contract with void-safety')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_USELESS_CONTRACT_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_feature_and_tagged_as

feature {NONE} -- Initialization

	make_with_feature_and_tagged_as (a_class: attached CLASS_C; a_feature: attached FEATURE_AS; a_tagged: attached TAGGED_AS; a_precondition: BOOLEAN)
			-- Initializes `Current' with class `a_class'. `a_feature' is the feature containing the violating
			-- contract. `a_tagged' is the violating contract. `a_precondition' is true if it's a precondition.
		do
			make(ca_names.useless_contract_fix, a_class)
			tagged_to_fix := a_tagged
			feature_to_fix := a_feature
			is_precondition := a_precondition
		end


feature {NONE} -- Implementation

	execute
			-- <Precursor>
		local
			l_contracts: ASSERT_LIST_AS
		do
			if attached {ROUTINE_AS} feature_to_fix.body.content as l_routine then
				if is_precondition then
					l_contracts := l_routine.precondition
				else
					l_contracts := l_routine.postcondition
				end

				if l_contracts.assertions.count = 1 then
					l_contracts.remove_text (match_list)
				else
					tagged_to_fix.remove_text (match_list)
				end
			end
		end

	is_precondition: BOOLEAN
		-- Is the violating contract a precondition?

	feature_to_fix: attached FEATURE_AS
		-- The feature containing the violating contract.

	tagged_to_fix: attached TAGGED_AS
		-- The contract to be removed.
end
