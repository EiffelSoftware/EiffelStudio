note
	description: "Summary description for {WSF_REQUEST_PATH_PARAMETERS_SOURCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_REQUEST_PATH_PARAMETERS_SOURCE

feature -- Access

	path_parameters_count: INTEGER
		deferred
		end

	urlencoded_path_parameters: TABLE_ITERABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Raw urlencoded path parameters.
		deferred
		end

	path_parameters: detachable ITERABLE [WSF_VALUE]
			-- Computed path parameters according to the policy of WSF_REQUEST

feature -- Element change

	update_path_parameters (lst: attached like path_parameters)
			-- set computed `path_parameters' to `lst'
		do
			path_parameters := lst
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
