indexing
	description: "Options representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_OPTIONS

inherit
	LINKED_LIST [STRING]

creation
	make

feature -- Code generation

	display is
		do
			io.putstring ("%NOptions : ")

			from
				start
			until
				after
			loop
				io.putstring (item)
				io.putstring (" ")

				forth
			end
			io.new_line
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			from
				start
			until
				after
			loop
				a_resource_file.putstring (item)
				a_resource_file.putstring (" ")

				forth
			end
		end

feature -- Access

	caption: STRING
			-- Caption

feature -- Setting

	set_characteristic (v: STRING) is
			-- Assign `v' to `characteristic'.
		do
		end

	set_language (v: STRING) is
			-- Assign `v' to `language'
		do
		end

	set_version (v: STRING) is
			-- Assign `v' to `version'
		do
		end

	set_caption (v: STRING) is
			-- Assign `v' to `caption'
		do
		end

	set_class (v: STRING) is
			-- Assign `v' to `class'
		do
		end

	set_menu (v: STRING) is
			-- Assign `v' to `menu'
		do
		end

	set_style (s: TDS_STYLE) is
			-- Assign `v' to `style'
		do
		end

	set_font_size (s: INTEGER) is
			-- Assign `v' to `font_size'
		do
		end

	set_font_type (v: STRING) is
			-- Assign `v' to `font_type'
		do
		end

	set_font_weight (v: INTEGER) is
			-- Assign `v' to `weight'
		do
		end

	set_font_italic (b: BOOLEAN) is
			-- Assign `v' to `font_italic'
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
end -- class TDS_OPTIONS

