indexing
	description: "Accelerators epresentation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_ACCELERATORS

inherit
	TDS_RESOURCE
		rename
			make as list_make
		end

create
	make

feature -- Initialization

	make is
			-- Create accelerators
		do
			list_make
			create accelerator_list.make
		end

feature -- Access

	current_accelerator: TDS_ACCELERATORS_ITEM
			-- Accelerator being processed

	accelerator_list: LINKED_LIST [TDS_ACCELERATORS_ITEM]

feature -- Setting

	set_current_accelerator (v: TDS_ACCELERATORS_ITEM) is
			-- Assign `v' to `current_accelerator'.
		require
			v_not_void: v /= Void
		do
			current_accelerator := v
		ensure
			current_accelerator_set: current_accelerator = v
		end

	insert_accelerator (v: TDS_ACCELERATORS_ITEM) is
		do
			accelerator_list.extend (v)
		end

feature -- Code generation

	generate_tree_view (a_tree_view: WEL_TREE_VIEW; a_parent: POINTER) is
		do
		end

	generate_wel_code is
		do
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
		do
		end

	display is
		do
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
end -- class TDS_ACCELERATORS
