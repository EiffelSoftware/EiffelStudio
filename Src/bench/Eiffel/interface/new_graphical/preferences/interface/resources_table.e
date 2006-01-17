indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCES_TABLE

inherit
	HASH_TABLE [RESOURCE,STRING]
		
create

	make

feature -- Access

	get_color (s: STRING): EV_COLOR is
		local
			r: COLOR_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_array (s: STRING; default_result: ARRAY [STRING]): ARRAY [STRING] is
		local
			r: ARRAY_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_integer (s: STRING; default_result: INTEGER): INTEGER is
		local
			r: INTEGER_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_boolean (s: STRING; default_result: BOOLEAN): BOOLEAN is
		local
			r: BOOLEAN_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_string (s: STRING; default_result: STRING): STRING is
		local
			r: STRING_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.value
				end
			end
		end

feature -- Setting

	set_value (s: STRING; new_value: STRING) is
			-- Used for font, color, and array.
		do
			if has (s) then
				item (s).set_value (new_value)
			else
				io.put_string ("%N ")
				io.put_string (s)
				io.put_string (" does not exist. No affectaion done.")
			end
		end

--	set_color (s: STRING; new_value: EV_COLOR) is
--		do
--			set_value (s, new_value)
--		end

	set_integer (s: STRING; new_value: INTEGER)is
		local
			r: INTEGER_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					r.set_actual_value (new_value)
				end
			end
		end

	set_boolean (s: STRING; new_value: BOOLEAN) is
		local
			r: BOOLEAN_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					r.set_actual_value (new_value)
				end
			end
		end

	set_string (s: STRING; new_value: STRING) is
		local
			r: STRING_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					r.set_value (new_value)
				end
			end
		end

feature -- Element Change

	put_resource (r: RESOURCE) is
			-- adds `r' in Current.
		do
			put (r, r.name)
		end

	replace_resource (r: RESOURCE) is
			-- replace resource `r.name' by `r'.
			-- do nothing if there is no resource calles `r.name'.
		do
			replace (r, r.name)
		end

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

end -- class RESOURCES_TABLE
