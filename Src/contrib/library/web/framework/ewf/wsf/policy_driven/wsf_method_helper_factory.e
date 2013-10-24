note

	description: "[
						Default factory for policy-driven method helpers.
                  Extension methods can be implemented here.
						]"
	date: "$Date$"
	revision: "$Revision$"

class WSF_METHOD_HELPER_FACTORY

feature -- Factory

	new_method_helper (a_method: READABLE_STRING_8): detachable WSF_METHOD_HELPER
			-- New object for processing `a_method';
			-- Redefine this routine to implement extension methods.
		require
			a_method_attached: a_method /= Void
		do
			if a_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_get) or
				a_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_head) then
				create {WSF_GET_HELPER} Result
			elseif a_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_put) then
				create {WSF_PUT_HELPER} Result
			elseif a_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_post) then
				create {WSF_POST_HELPER} Result
			elseif a_method.is_case_insensitive_equal ({HTTP_REQUEST_METHODS}.method_delete) then
				create {WSF_DELETE_HELPER} Result
			end
		end

note
	copyright: "2011-2013, Colin Adams, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
