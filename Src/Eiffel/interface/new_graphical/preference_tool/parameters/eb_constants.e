indexing
	description	: "Constants for EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONSTANTS

feature {EB_TOOL} -- Resources

	Pixmaps: EB_SHARED_PIXMAPS is
		once
			create Result
		end

	Cursors: EB_SHARED_CURSORS is
		once
			create Result
		end

	Interface_names: INTERFACE_NAMES is
			-- All names used in the interface
		once
			Result := (create {SHARED_BENCH_NAMES}).names
		end

	Interface_messages: INTERFACE_MESSAGES
			-- Interface messages.
		once
			Result := (create {SHARED_BENCH_NAMES}).messages
		end

	Warning_messages: WARNING_MESSAGES is
			-- All warnings used in the interface
		once
			Result := (create {SHARED_BENCH_NAMES}).warnings
		end

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Constants for vision2 layout
		once
			create Result
		end

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

end -- class EB_CONSTANTS

