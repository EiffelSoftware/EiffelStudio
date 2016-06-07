note
	description: "Common ESF helpers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SHARED_FOUNDATION_HELPERS

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Helpers

	frozen tool_utilities: attached ES_TOOL_UTILITIES
			-- Shared access to the tool utilities.
		once
			create Result
		end

feature {NONE} -- Helpers: User interface

	frozen helpers: attached EVS_HELPERS
			-- Helpers to extend the operations of EiffelVision2
		once
			create Result
		end

	frozen interface_names: attached INTERFACE_NAMES
			-- Access to EiffelStudio's interface names
		once
			create Result
		end

	frozen stock_pixmaps: attached ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		end

	frozen mini_stock_pixmaps: attached ES_PIXMAPS_10X10
			-- Shared access to stock 10x10 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).mini_pixmaps
		end

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
