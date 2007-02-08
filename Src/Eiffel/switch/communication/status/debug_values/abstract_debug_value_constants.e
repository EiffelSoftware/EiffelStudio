indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ABSTRACT_DEBUG_VALUE_CONSTANTS

inherit
	DEBUG_VALUE_EXPORTER

feature {DEBUG_VALUE_EXPORTER} -- Constants

	abstract_debug_value_id: INTEGER is 0
	abstract_special_value_id: INTEGER is 1
	abstract_reference_value_id: INTEGER is 5
	expanded_value_id: INTEGER is 6
	bits_value_id: INTEGER is 7
	debug_basic_value_id: INTEGER is 10
	character_value_id: INTEGER is 11
	character_32_value_id: INTEGER is 12
	eifnet_debug_unknown_type_value_id: INTEGER is 20
	eifnet_debug_native_array_value_id: INTEGER is 21
	exception_debug_value_id: INTEGER is 30
	procedure_return_debug_value_id: INTEGER is 31
	dummy_message_debug_value_id: INTEGER is 32

feature {NONE} -- Readme

	--| For now, only value used in DEBUGGER_TEXT_FORMATTER_OUTPUT are set
	--| don't forget to update any related classes.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
