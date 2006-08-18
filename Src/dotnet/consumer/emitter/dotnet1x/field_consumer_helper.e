indexing
	description: "A utility class for extracting the content of a field"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FIELD_CONSUMER_HELPER

feature {NONE} -- Query

	field_value (a_fi: FIELD_INFO): SYSTEM_OBJECT is
			-- Retrieves field value for `a_fi'
		require
			a_fi_attached: a_fi /= Void
			a_fi_is_literal: a_fi.is_literal
		do
			Result := a_fi.get_value (Void)
		end

end -- class {FIELD_CONSUMER_HELPER}
