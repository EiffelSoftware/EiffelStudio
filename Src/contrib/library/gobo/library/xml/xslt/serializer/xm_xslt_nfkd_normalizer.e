indexing

	description:

		"Objects that convert strings to Unicode normalization form NFKD."

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2007, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_NFKD_NORMALIZER

inherit

	XM_XSLT_UNICODE_NORMALIZER

create

	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			-- nothing to do
		end

feature -- Access

	normalization_form: STRING is "NFKD"
			-- Name of normalization form provided by `Current'

	normalized_string (a_string: STRING): UC_UTF8_STRING is
			-- Normalized version of `a_string' according to `normalization_form'
		do
			Result := normalization.as_nfkd (a_string)
		end

end
