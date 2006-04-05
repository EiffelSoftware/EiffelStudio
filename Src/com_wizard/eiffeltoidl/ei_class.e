indexing
	description: "Eiffel class representation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_CLASS

create
	make

feature {NONE} -- Initialization

	make (c_name: STRING) is
			-- Initialize and set 'name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			name := c_name.twin
			create description.make (0)
			create features.make (5)
		end

feature -- Access

	name: STRING
			-- Class name

	features: HASH_TABLE[EI_FEATURE, STRING]
			-- Features (routines, functions, attributes)
			-- Feature name as key.

	description: STRING
			-- Class description

feature -- Basic operations

	set_name (c_name: STRING) is
			-- Set 'name' to 'c_name'.
		require
			valid_name: c_name /= Void and then not c_name.is_empty
		do
			name := c_name.twin
		ensure
			name_set: name.is_equal (c_name)
		end

	set_description (desc: STRING) is
			-- Set 'description' to 'desc'.
		require
			valid_description: desc /= Void and then not desc.is_empty
		do
			description := desc.twin
		ensure
			description_set: description.is_equal (desc)
		end

	add_feature (l_feature: EI_FEATURE) is
			-- Add 'feature' to 'features'.
		require
			non_void_feature: l_feature /= Void
		do
			features.put (l_feature, l_feature.name)
		ensure
			feature_added: features.has (l_feature.name)
		end

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty
	non_void_description: description /= Void
	non_void_features: features /= Void

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
end -- class EI_CLASS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

