indexing
	description: "MIDL interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_INTERFACE

inherit
	EI_MIDL_COMPONENT
		redefine
			make
		end

	WIZARD_SPECIAL_SYMBOLS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (l_name: STRING) is
			-- Initialize object. Set 'name' to 'l_name'.
		do
			Precursor (l_name)
			create {ARRAYED_LIST [EI_MIDL_FEATURE]} features.make (20)
		end

feature -- Access

	features: LIST [EI_MIDL_FEATURE]
			-- Features

feature -- Element change

	add_feature (l_feature: EI_MIDL_FEATURE) is
			-- Add 'l_feature' to 'features'.
		require
			non_void_feature: l_feature /= Void
		do
			features.extend (l_feature)
		ensure
			feature_set: features.has (l_feature)
		end

feature -- Output

	code: STRING is
			-- Output code
		local
			l_name, guid_str: STRING
		do
			-- [object, dual, automation, 
			Result := "%( object, dual, oleautomation, %N%T"

			-- uuid ('guid')
			Result.append ("uuid (")

			guid_str := guid.to_string.twin
			guid_str.remove (1)
			guid_str.remove (guid_str.count)

			Result.append (guid_str)
			Result.append (Close_parenthesis)
			Result.append (Comma)
			REsult.append (New_line_tab)

			-- helpstring ("'description'")
			Result.append ("helpstring (%"")
			Result.append (description)
			Result.append ("%"),%N%T")

			-- version ('version')
			Result.append ("version (")
			Result.append_real (version)
			Result.append (")%N%)%N")

			-- interface I'name: IDispatch
			Result.append ("interface I")

			l_name := name.twin
			l_name.to_lower
			Result.append (l_name)
			Result.append (": IDispatch%N{%N")

			if not features.is_empty then
				from
					features.start
				until
					features.off
				loop
					Result.append (features.item.code)
					Result.append (New_line)
					features.forth
				end
			end

			Result.append ("%N};%N")

	
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
end -- class EI_MIDL_INTERFACE

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

