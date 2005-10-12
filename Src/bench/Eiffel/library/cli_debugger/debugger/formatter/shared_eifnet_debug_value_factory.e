indexing
	description: "Accessor to EIFNET_DEBUG_VALUE_FACTORY"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EIFNET_DEBUG_VALUE_FACTORY

inherit
	ICOR_EXPORTER
	DEBUG_VALUE_EXPORTER

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Initialization

	Edv_factory: EIFNET_DEBUG_VALUE_FACTORY is
		once
			create Result
		end

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Bridge

	debug_value_from_icdv (a_icd: ICOR_DEBUG_VALUE; a_stat_class: CLASS_C): EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Bridge to EIFNET_DEBUG_VALUE_FACTORY.debug_value_from
			-- a_stat_class is the static class of a_icd
		require
			a_icd_not_void: a_icd /= Void
		do
			Result := Edv_factory.debug_value_from (a_icd, a_stat_class)
		ensure
			Result /= Void
		end
		
	error_value (a_name, a_mesg: STRING): DUMMY_MESSAGE_DEBUG_VALUE is
		do		
			create Result.make_with_name (a_name)
			Result.set_message (a_mesg)
		ensure
			Result /= Void
		end	

	exception_value (a_name, a_tag: STRING; a_value: ABSTRACT_DEBUG_VALUE): EXCEPTION_DEBUG_VALUE is
		do		
			create Result.make_with_name (a_name)
			Result.set_tag (a_tag)
			if a_value /= Void then
				Result.set_exception_value (a_value)
			end
		ensure
			Result /= Void
		end	

end -- class SHARED_EIFNET_DEBUG_VALUE_FACTORY


