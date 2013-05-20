note
	description: "Summary description for {WSF_REQUEST_PATH_PARAMETERS_PROVIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_REQUEST_PATH_PARAMETERS_PROVIDER

inherit
	WSF_REQUEST_PATH_PARAMETERS_SOURCE

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER; a_urlencoded_path_parameters: like urlencoded_path_parameters)
		do
			path_parameters_count := nb
			urlencoded_path_parameters := a_urlencoded_path_parameters
		end

feature -- Access

	path_parameters_count: INTEGER

	urlencoded_path_parameters: TABLE_ITERABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Raw urlencoded path parameters.

feature -- Operation

	previous_path_parameters_source: detachable WSF_REQUEST_PATH_PARAMETERS_SOURCE

	apply (req: WSF_REQUEST)
			-- <Precursor>
		do
			previous_path_parameters_source := req.path_parameters_source
			req.set_path_parameters_source (Current)
		end

	revert (req: WSF_REQUEST)
			-- <Precursor>
		do
			req.set_path_parameters_source (previous_path_parameters_source)
			previous_path_parameters_source := Void
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
