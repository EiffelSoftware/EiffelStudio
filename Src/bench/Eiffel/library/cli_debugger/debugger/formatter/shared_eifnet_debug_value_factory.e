indexing
	description: "Accessor to EIFNET_DEBUG_VALUE_FACTORY"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EIFNET_DEBUG_VALUE_FACTORY

inherit
	ICOR_EXPORTER

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Initialization

	Edv_factory: EIFNET_DEBUG_VALUE_FACTORY is
		once
			create Result
		end

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Bridge

	debug_value_from_icdv (a_icd: ICOR_DEBUG_VALUE): EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Bridge to EIFNET_DEBUG_VALUE_FACTORY.debug_value_from 
		do
			Result := Edv_factory.debug_value_from (a_icd, a_icd.associated_frame)
		end
		
	debug_value_from_prepared_icdv (a_icd: ICOR_DEBUG_VALUE; a_prep_icd: ICOR_DEBUG_VALUE): EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Bridge to EIFNET_DEBUG_VALUE_FACTORY.debug_value_from 
		do
			Result := Edv_factory.debug_value_from_prepared_icd (a_icd, a_prep_icd, a_icd.associated_frame)
		end		

end -- class SHARED_EIFNET_DEBUG_VALUE_FACTORY


