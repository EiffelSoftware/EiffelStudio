indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SHARED_EIFNET_DEBUG_VALUE_FACTORY

feature -- Status

	debug_value_from_icdv (a_icd: ICOR_DEBUG_VALUE; a_stat_class: CLASS_C): EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Bridge to EIFNET_DEBUG_VALUE_FACTORY.debug_value_from
			-- a_stat_class is the static class of a_icd
		do
		end
		
end
