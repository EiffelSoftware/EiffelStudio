note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TDS_RESOURCE

inherit
	LINKED_LIST [TDS_RESOURCE]

	TDS_RESOURCE_CONSTANTS
		undefine
			is_equal, copy
		end

feature -- Access

	tree_view_item: POINTER

	is_wel_code_on: BOOLEAN

	class_name: STRING

	set_class_name (s: STRING)
		do
			class_name := s
		end

	type: INTEGER

	set_type (a_type: INTEGER)
		do
			type := a_type
		end

	make_options
		do
			create options.make
		end

	make_load_and_mem_attributes
		do
			create load_and_mem_attributes.make
		end

	id: TDS_ID

	set_id (s: STRING)
		do
			if id = Void then
				create id
			end
			id.set_id (s)
		end

	insert (v: TDS_RESOURCE)
		do
			extend (v)
		end

	set_tree_view_item (a_parent: POINTER)
		do
			tree_view_item := a_parent
		end

	set_wel_code (value: BOOLEAN)
		do
			is_wel_code_on := value
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE)
		deferred
		end

	generate_tree_view (a_tree_view: WEL_TREE_VIEW; a_parent: POINTER)
		deferred
		end

	generate_wel_code
		deferred
		end

	load_and_mem_attributes: TDS_LOAD_AND_MEM_ATTRIBUTES

	options: TDS_OPTIONS

	filename: STRING
	
	set_filename (s: STRING)
		require
			s_not_void: s /= Void
		do
			filename := s
			if s.item (1) = '%"' then
				s.remove_head (1)
			end
			if s.item (s.count) = '%"' then
				s.remove_tail (1)
			end
		end

	display
		deferred
		end

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
end -- class TDS_RESOURCE
