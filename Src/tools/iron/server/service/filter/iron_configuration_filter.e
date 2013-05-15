note
	description: "IRON Configuration filter."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CONFIGURATION_FILTER

inherit
	WSF_FILTER

	WSF_REQUEST_EXPORTER
		export
			{NONE} all
		end

feature -- Access

	uploaded_file_path: detachable PATH assign set_uploaded_file_path

feature -- Change

	set_uploaded_file_path (p: like uploaded_file_path)
		do
			uploaded_file_path := p
		end

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		do
			if attached uploaded_file_path as p then
				req.set_uploaded_file_path (p.utf_8_name) -- FIXME
			end
			execute_next (req, res)
		end

note
	copyright: "2011-2013, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
