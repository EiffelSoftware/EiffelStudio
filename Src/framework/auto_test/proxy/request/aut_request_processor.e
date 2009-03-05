note
	description:

		"Request processors"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_REQUEST_PROCESSOR

inherit
	REFACTORING_HELPER

feature{AUT_REQUEST} -- Status report

	is_request_valid (a_request: AUT_REQUEST): BOOLEAN
			-- Is `a_request' valid?
		require
			a_request_attached: a_request /= Void
		do
			Result := True
		end

feature{AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST)
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_stop_request (a_request: AUT_STOP_REQUEST)
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST)
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_type_request (a_request: AUT_TYPE_REQUEST)
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
