note
	description: "Accessor to EIFNET_DEBUG_VALUE_FACTORY"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EIFNET_DEBUG_VALUE_FACTORY

inherit
	ICOR_EXPORTER
	DEBUG_VALUE_EXPORTER

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Initialization

	Edv_factory: EIFNET_DEBUG_VALUE_FACTORY
		once
			create Result
		end

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Bridge

	debug_value_from_icdv (a_icd: ICOR_DEBUG_VALUE; a_stat_class: CLASS_C): EIFNET_ABSTRACT_DEBUG_VALUE
			-- Bridge to EIFNET_DEBUG_VALUE_FACTORY.debug_value_from
			-- a_stat_class is the static class of a_icd
		require
			a_icd_not_void: a_icd /= Void
		do
			Result := Edv_factory.debug_value_from (a_icd, a_stat_class)
		ensure
			Result /= Void
		end

	error_value (a_name: STRING_32; a_mesg: STRING): DUMMY_MESSAGE_DEBUG_VALUE
		do
			create Result.make_with_name (a_name)
			Result.set_message (a_mesg)
		ensure
			Result /= Void
		end

	exception_value (a_name: STRING_32; a_tag: STRING_GENERAL; a_value: ABSTRACT_DEBUG_VALUE): EXCEPTION_DEBUG_VALUE
		do
			if attached {ABSTRACT_REFERENCE_VALUE} a_value as arv then
				create Result.make_with_value (arv)
			else
				check should_not_occurred: False end
				create Result.make_without_any_value
			end
			Result.set_name (a_name)
			Result.set_user_meaning (a_tag)
		ensure
			Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
