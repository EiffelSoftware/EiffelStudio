indexing
	description: "Style representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_STYLE

creation

	make 
	
feature -- Initialization

	make is
		do
			activate := true
		end

feature -- Access

	activate: BOOLEAN
			-- Tell if the style is activated or not.

	style: STRING
			-- The style string.


feature -- Element change

	set_desactivate is
			-- Set `activate' to false
		do
			activate := false
		ensure
			activate_set: not activate
		end

	set_style (a_style: STRING) is
			-- Set `a_style' to `style'.
		require
			a_style_exists: a_style /= Void and then a_style.count > 0
		do
			style := clone (a_style)
		ensure
			style_set: style.is_equal (a_style)
		end

feature -- Query

	is_style_equal (a_style: TDS_STYLE) : BOOLEAN is
			-- Is `a_style' equal to `style'?
		require
			a_style_not_void: a_style /= Void
		do
			Result := (style.is_equal (a_style.style)) and (activate = a_style.activate)
		ensure
			Result_not_void: Result /= Void
		end
	
	is_style_almost_equal (a_style: TDS_STYLE) : BOOLEAN is
			-- Is a part of `a_style' contained by `style'?
		require
			a_style_not_void: a_style /= Void
		do
			Result := (style.substring_index (a_style.style, 1)> 0) AND (activate = a_style.activate)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Code generation

	display is
		do
			if (not activate) then
				io.putstring ("not ")
			end

			io.putstring (style)
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (not activate) then
				a_resource_file.putstring ("not ")
			end

			a_resource_file.putstring (style)
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
end -- class TDS_STYLE

