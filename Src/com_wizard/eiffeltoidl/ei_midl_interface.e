indexing
	description: "MIDL interface"
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
			Result := "%( object, dual, oleautomation, %R%N%T"

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
			Result.append ("%"),%R%N%T")

			-- version ('version')
			Result.append ("version (")
			Result.append_real (version)
			Result.append (")%R%N%)%R%N")

			-- interface I'name: IDispatch
			Result.append ("interface I")

			l_name := name.twin
			l_name.to_lower
			Result.append (l_name)
			Result.append (": IDispatch%R%N{%R%N")

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

			Result.append ("%R%N};%R%N")

	
		end

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

