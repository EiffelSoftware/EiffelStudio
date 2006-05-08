indexing
	description: "Name of a feature or a class to be inserted by autocomplete"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NAME_FOR_COMPLETION

inherit

	NAME_FOR_COMPLETION
		export
			{NONE} set_icon
		redefine
			make,
			icon
		end

	EB_SHARED_PREFERENCES
		undefine
		    copy,
		    out,
		    is_equal
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			copy,
			is_equal,
			out
		end

create
	make

create {EB_NAME_FOR_COMPLETION}
	make_string

feature -- Initialization

	make (a_name: STRING) is
			-- Create feature name with value `name'
		do
			Precursor {NAME_FOR_COMPLETION} (a_name)
			has_dot := True
		ensure then
			name_set: name = a_name
		end

feature -- Query

	is_class: BOOLEAN is
			-- Is a class?
		do
			Result := False
		end

	icon: EV_PIXMAP is
			-- Icon
		do
			Result := pixmaps.icon_other_feature
		end

feature -- Status Report

	has_dot: BOOLEAN

	show_signature: BOOLEAN is
			-- Should signature be displayed?
		do
		    Result := preferences.editor_data.show_completion_signature
		end

	show_type: BOOLEAN is
			-- Should feature return type be displayed?
		do
		    Result := preferences.editor_data.show_completion_type
		end

feature -- Status setting

	set_has_dot (hd: BOOLEAN) is
			-- assign `hd' to `has_dot'
		do
			has_dot := hd
		end

feature {NONE} -- Implementation

	return_type: TYPE_A
			-- Associated feature's return type

	completion_type: STRING is
			-- The type of the feature (for a function, attribute)
		local
			l_desc: STRING
		do
			if internal_completion_type = Void then
				if return_type /= Void then
					l_desc := return_type.dump
					create Result.make (2 + l_desc.count)
					Result.append (": ")
					Result.append (l_desc)
				else
					create Result.make_empty
				end
				internal_completion_type := Result
			else
				Result := internal_completion_type
			end
		ensure
			result_not_void: Result /= Void
		end

	internal_completion_type: STRING;
			-- cache `completion_type'

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

end -- class EB_NAME_FOR_COMPLETION
