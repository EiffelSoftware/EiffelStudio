note
	description: "Feature attributes flags"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ATTRIBUTE

feature -- Access

	Is_frozen: INTEGER = 1
	Is_static: INTEGER = 2
	Is_deferred: INTEGER = 4
	Is_infix: INTEGER = 8
	Is_prefix: INTEGER = 16
	Is_public: INTEGER = 32
	Is_artificially_added: INTEGER = 64
	Is_property_or_event: INTEGER = 128
	Is_init_only: INTEGER = 256
	Is_newslot: INTEGER = 512
	Is_virtual: INTEGER = 1024
	Is_attribute_setter: INTEGER = 2048;
			-- Possible attributes of a feature.

note
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


end -- class FEATURE_ATTRIBUTE
