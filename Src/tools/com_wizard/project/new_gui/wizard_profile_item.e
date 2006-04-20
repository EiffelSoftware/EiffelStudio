indexing
	description: "Profile item, consists of a name and a list of values"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROFILE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_value: like value) is
			-- Set `name' with `a_name' and `value' with `a_value'.
		require
			non_void_name: a_name /= Void
			non_void_value: a_value /= Void
		do
			name := a_name
			value := a_value
		ensure
			name_set: name = a_name
			value_set: value = a_value
		end

feature -- Access

	name: STRING
			-- Item name
	
	value: STRING
			-- Item value

	linear_representation: LIST [STRING] is
			-- List composed of (name, value)
		do
			create {ARRAYED_LIST [STRING]} Result.make (2)
			Result.extend (name)
			Result.extend (value)
		ensure
			non_void_representation: Result /= Void
			definition: Result.first.is_equal (name) and Result.i_th (2).is_equal (value)
		end

invariant
	non_void_name: name /= Void
	non_void_value: value /= Void

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
end -- class WIZARD_PROFILE_ITEM

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

