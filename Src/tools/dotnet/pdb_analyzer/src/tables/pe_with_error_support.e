note
	description: "Summary description for {PE_WITH_ERROR_SUPPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_WITH_ERROR_SUPPORT

feature -- Errors		

	has_error: BOOLEAN
		do
			Result := attached errors as lst and then not lst.is_empty
		end

	error_count: NATURAL_32
		do
			if attached errors as lst then
				Result := lst.count.to_natural_32
			end
		end

	errors: detachable ARRAYED_LIST [PE_ERROR]

feature -- Element change

	report_error (err: PE_ERROR)
		local
			lst: like errors
		do
			lst := errors
			if lst = Void then
				create lst.make (1)
				errors := lst
			end
			lst.force (err)
		ensure
			has_error
		end

end
