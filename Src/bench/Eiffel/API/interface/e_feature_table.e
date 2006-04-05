indexing

	description: 
		"Table representing features for a class hashed on feature name."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	E_FEATURE_TABLE

inherit
	HASH_TABLE [E_FEATURE, STRING]

	SHARED_EIFFEL_PROJECT
		undefine
			copy, is_equal
		end

create
	make

feature -- Properties

	class_id: INTEGER;
			-- Id of the class to which the feature table belongs to.

	associated_class: CLASS_C is
			-- Associated class
		require
			valid_class_id: class_id /= 0
		do
			Result := Eiffel_system.class_of_id (class_id);
		end;

feature {FEATURE_TABLE} -- Optimization

	set_class_id (i: like class_id) is
			-- Set the `class_id' to i.
		do
			class_id := i
		ensure
			set: class_id = i
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

end -- class E_FEATURE_TABLE
