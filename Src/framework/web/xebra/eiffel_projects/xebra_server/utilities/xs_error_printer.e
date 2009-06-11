note
	description: "Summary description for {XS_ERROR_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_ERROR_PRINTER

inherit
	ERROR_PRINTER
		redefine
			print_warning
		end

	XS_SHARED_SERVER_OUTPUTTER
		rename
			print as outputter_print
		select
			outputter_print
		end


feature -- Basic Operations

	print_error (a_error: ERROR_ERROR_INFO)
			-- <Precursor>.
		do
			o.eprint (a_error.description, a_error.generating_type)
		end

	print_warning (a_warning: ERROR_WARNING_INFO)
			-- <Precursor>.
		do
			o.iprint ("Warning: " + a_warning.description)
		end

end
