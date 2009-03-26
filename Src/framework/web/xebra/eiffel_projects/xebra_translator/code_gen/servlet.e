note
	description: "[
		The {SERVLET} handles a page request.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SERVLET

feature -- Access

	controller_features: TABLE [PROCEDURE [ANY, TUPLE], STRING]
			-- Table with the feature agents of the controller
			-- Only the features that will be called

	controller_features_with_result: TABLE [FUNCTION [ANY, TUPLE, STRING], STRING]
			-- Table with the feature agents (only the functions) of the controller
			-- Only the features that will be called

	handle_request (request: REQUEST): RESPONSE
			-- Handles a request from a client an generates a response.
		deferred
		end

	call_on_controller (feature_name: STRING)
			-- Calls the feature with the name `feature_name' on the controller
			-- If the feature does not exist, nothing happens
		do
			if controller_features.valid_key (feature_name) then
				controller_features [feature_name].call (Void)
			end
		end

	call_on_controller_with_result (feature_name: STRING): STRING
			-- Calls the feature with the name `feature_name' on the controller
			-- If the feature does not exist, nothing happens
			-- Returns the result of the feature
		do
			Result := ""
			if controller_features_with_result.valid_key (feature_name) then
				Result := controller_features_with_result [feature_name].item (Void)
			end
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
