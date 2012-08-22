note

	description:

		"Objects that make security decisions"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_DEFAULT_SECURITY_MANAGER

inherit

	XM_XSLT_SECURITY_MANAGER

	XM_XPATH_DEFAULT_SECURITY_MANAGER

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make, make_highly_secure

feature {NONE} -- Initialization

	make
			-- Create with low security.
		do
			-- do_nothing
		end

	make_highly_secure
			-- Create with high security.
		do
			is_highly_secure := True
		end

feature -- Access

	is_output_uri_permitted (an_absolute_uri: UT_URI): BOOLEAN
			-- Is writing permitted to `an_absolute_uri'?
		do
			if is_highly_secure then
				Result := STRING_.same_string (an_absolute_uri.scheme, "stdout")
					or else STRING_.same_string (an_absolute_uri.scheme, "string")
			else
				Result := True
			end
		end

end

