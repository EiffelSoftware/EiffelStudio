indexing
	description: "EiffelStudio resources, with access facilities"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES

inherit
	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Access

	resources: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		once
			create Result.make_from_location (System_general, Eiffel_preferences)
		end

feature -- Access

	color_resource_value (s: STRING): EV_COLOR is
			-- Color resource. Can be Void if no color resource called `s' exists.
		local
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			end
		end

	secure_color_resource_value (s: STRING; rd, gd, bd: INTEGER): EV_COLOR is
			-- Color value of resource named `s', or rgb color defined by
			-- `rd', `gd', `bd' if resource does not exist.
		local
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create Result.make_with_8_bit_rgb (rd, gd, bd)
			end
		end

	font_resource_value (s: STRING): EV_FONT is
			-- Font value of resource named `s', or a default font
			-- if resource does not exist.
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create r.make (s, "verdana,arial,helvetica-r-regular-12-screen")
				Result := r.actual_value
			end
		end

	secure_font_resource_value (s: STRING; df: STRING): EV_FONT is
			-- Font value of resource named `s', or font defined by
			-- `df' if resource does not exist.
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create r.make (s, df)
				Result := r.actual_value
			end
		end

	array_resource_value (s: STRING; da: ARRAY [STRING]): ARRAY [STRING] is
		local
			r: ARRAY_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := da
			end
		end

	integer_resource_value (s: STRING; di: INTEGER): INTEGER is
		local
			r: INTEGER_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := di
			end
		end

	boolean_resource_value (s: STRING; db: BOOLEAN): BOOLEAN is
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := db
			end
		end

	string_resource_value (s: STRING; ds: STRING): STRING is
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.value
			else
				Result := ds
			end
		end

feature -- Setting

	set_integer (s: STRING; ni: INTEGER) is
		local
			r: INTEGER_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (ni)
			else
				create r.make (s, ni)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_boolean (s: STRING; nb: BOOLEAN) is
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (nb)
			else
				create r.make (s, nb)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_string (s: STRING; ns: STRING) is
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_value (ns)
			else
				create r.make (s, ns)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_array (a_resource_name: STRING; a_value: ARRAY [STRING]) is
			-- Set the value of `a_resource_name' to `a_value'.
		local
			resource_item: ARRAY_RESOURCE
		do
			resource_item ?= resources.item (a_resource_name)
			if resource_item /= Void then
				resource_item.set_actual_value (a_value)
			else
				create resource_item.make (a_resource_name, a_value)
				resources.root_folder.resource_list.extend (resource_item)
				resources.put_resource (resource_item)
			end
		end

feature -- Basic operations

	save_resources is
			-- Commit all changes by saving the registry/.es5rc file.
		do
			resources.save
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

end -- class SHARED_RESOURCES
