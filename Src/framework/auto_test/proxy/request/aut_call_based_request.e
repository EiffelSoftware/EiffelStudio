note
	description: "Summary description for {AUT_CALL_BASED_REQUEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_CALL_BASED_REQUEST

inherit
	AUT_REQUEST

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

feature -- Access

	target: ITP_VARIABLE
			-- Target for the call to feature `feature_to_call'
			-- In case of object creation, this means the object to be created

	target_type: TYPE_A
			-- Type of target for call to feature `feature_to_call'.
			-- In case of object creation, this means the type of the object to be created

	class_of_target_type: CLASS_C
			-- Direct base class of `target_type'
		require
			ready: is_setup_ready
		do
			Result := target_type.base_class
		ensure
			definition: Result = target_type.base_class
		end

	argument_list: detachable DS_LINEAR [ITP_EXPRESSION]
			-- Arguments used to invoke `procedure';
			-- Void if default creation procedure is to be used .

	feature_to_call: FEATURE_I
			-- Feature to be called in current request
		require
			ready: is_setup_ready
		deferred
		ensure
			result_attached: Result /= Void
		end

	argument_count: INTEGER
			-- Number of arguments in `feature_to_call'
			-- 0 if `feature_to_call' takes no argument.
		require
			ready: is_setup_ready
		do
			if feature_to_call /= Void then
				Result := feature_to_call.argument_count
			end
		ensure
			good_result:
				(feature_to_call /= Void implies Result = feature_to_call.argument_count) and then
				(feature_to_call = Void implies Result = 0)
		end

feature -- Status report

	is_setup_ready: BOOLEAN
			-- Is setup of current request ready?
		deferred
		end

	is_feature_query: BOOLEAN
			-- Is `feature_to_call' a query?
		require
			type_attached: target_type /= Void
		do
			Result := feature_to_call.type /= void_type
		ensure
			good_result: Result = (feature_to_call.type /= void_type)
		end

	has_argument: BOOLEAN
			-- Does `feature_to_call' has any formal argument?
		require
			is_ready: is_setup_ready
		do
			Result := argument_count > 0
		ensure
			good_result: Result = (argument_count > 0)
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
