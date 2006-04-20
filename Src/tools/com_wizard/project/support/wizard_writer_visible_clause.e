indexing
	description: "Visible clause writer"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_VISIBLE_CLAUSE

inherit
	WIZARD_WRITER

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			create {ARRAYED_LIST [STRING]} exported_features.make (20)
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			create Result.make (100)
			Result.append (Tab_tab_tab)
			Result.append (name)
			if not exported_features.is_empty then
				Result.append ("%N%T%T%T%Texport%N")
				from
					exported_features.start
				until
					exported_features.after
				loop
					Result.append ("%T%T%T%T%T%"")
					Result.append (exported_features.item)
					Result.append_character ('"')
					exported_features.forth
					if not exported_features.after then
						Result.append_character (',')
					end
					Result.append_character ('%N')
				end
				Result.append ("%T%T%T%Tend")
			end
			Result.append (";%N")
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := name /= Void and then not name.is_empty
		end

	name: STRING
			-- Class name.

	exported_features: LIST [STRING]
			-- Exported features.


feature -- Element change

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		do
			name := a_name.twin
		ensure
			name_set: name.is_equal (a_name)
		end

	add_feature (a_feature: STRING) is
			-- Add `a_feature to `exported_features'.
		require
			non_void_feature: a_feature /= Void
			valid_feature: not a_feature.is_empty
		do
			exported_features.extend (a_feature.twin)
		ensure
			added: exported_features.last.is_equal (a_feature)
		end

invariant
	non_void_features: exported_features /= Void

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
end -- class WIZARD_WRITER_VISIBLE_CLAUSE

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
