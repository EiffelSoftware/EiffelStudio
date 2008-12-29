note
	description: "[
		A commander interface for interacting with the class tool {ES_CLASS_TOOL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_CLASS_TOOL_COMMANDER_I

inherit
	USABLE_I

feature -- Access

	mode: NATURAL_8 assign set_mode
			-- The class tool's view mode.
			-- See {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_valid_mode: (create {ES_CLASS_TOOL_VIEW_MODES}).is_valid_mode (Result)
		end

feature -- Element change

	set_mode (a_mode: like mode)
			-- Sets the current view mode.
			--
			-- `a_mode': The view mode to set. See {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		require
			is_interface_usable: is_interface_usable
			a_mode_is_valid_mode: (create {ES_CLASS_TOOL_VIEW_MODES}).is_valid_mode (a_mode)
			a_mode_not_custom: a_mode /= {ES_CLASS_TOOL_VIEW_MODES}.custom
		deferred
		ensure
			mode_set: mode = a_mode
		end

	set_mode_with_stone (a_mode: like mode; a_stone: STONE)
			-- Sets the current view mode and the stone to view using the mode.
			--
			-- `a_mode': The view mode to set.
			-- `a_stone': The stone to set on the class tool.
		require
			is_interface_usable: is_interface_usable
			a_mode_is_valid_mode: (create {ES_CLASS_TOOL_VIEW_MODES}).is_valid_mode (a_mode)
			a_mode_not_custom: a_mode /= {ES_CLASS_TOOL_VIEW_MODES}.custom
		deferred
		ensure
			mode_set: mode = a_mode
		end

;note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
