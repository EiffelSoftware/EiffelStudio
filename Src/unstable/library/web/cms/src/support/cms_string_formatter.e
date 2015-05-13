note
	description: "Format a text using arguments."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STRING_FORMATTER

feature -- Conversion

	formatted_string (a_string: READABLE_STRING_GENERAL; args: TUPLE): STRING_32
		do
			Result := i18n_formatter.formatted_string (a_string, args)
		end

feature {NONE} -- Implementation

	i18n_formatter: I18N_STRING_FORMATTER
		once
			create Result
		end

end
