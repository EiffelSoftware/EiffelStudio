indexing
	description: "Feature attributes flags"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ATTRIBUTE

feature -- Access

	Is_frozen: INTEGER is 1
	Is_static: INTEGER is 2
	Is_deferred: INTEGER is 4
	Is_infix: INTEGER is 8
	Is_prefix: INTEGER is 16
	Is_public: INTEGER is 32
	Is_artificially_added: INTEGER is 64
	Is_property_or_event: INTEGER is 128
	Is_init_only: INTEGER is 256
	Is_newslot: INTEGER is 512
	Is_virtual: INTEGER is 1024
	Is_attribute_setter: INTEGER is 2048;
			-- Possible attributes of a feature.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class FEATURE_ATTRIBUTE
