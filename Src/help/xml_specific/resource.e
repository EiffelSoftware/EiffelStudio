note

	description:
		"A resource as it appears in the resource files."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE

inherit
	COMPARABLE

feature -- Setting

	set_value (new_value: STRING)
			-- Set `value' to `new_value'.
		require
			new_value_not_void: new_value /= Void;
			is_valid_value: is_valid (new_value)
		deferred
		ensure
			value_set: value.is_equal (new_value)
		end

feature -- Access

	name: STRING
			-- Name of the resource as it appears to the left
			-- of the colona in the resource file

	visual_name: STRING
			-- Visual name of the resource as it appears to the left
			-- of the colon in the preference tool
		do
			Result := clone (name);
			Result.replace_substring_all ("_", " ");
			Result.put (Result.item (1).upper, 1)
		end;

	value: STRING
			-- Value of the resource as it appears to the right
			-- of the colon
		deferred
		end;

	is_valid (a_value: STRING): BOOLEAN
			-- Is `a_value' valid for use in Current?
		deferred
		end;

	has_changed: BOOLEAN
			-- Has the resource changed from the default value?
		deferred
		end;

	get_value: ANY deferred end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN
			-- Is Current less than `other'?
			--| By default this is based on `name'.
		do
			Result := name < other.name
		end

feature -- Update

	update_with (other: like Current)
			-- Update Current with the value of `other'
		require
			same_name: name.is_equal (other.name)
		do
			set_value (other.value)
		end
		
invariant

	valid_name: name /= Void and then not name.empty;
	value_not_void: value /= Void

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
end -- class RESOURCE
