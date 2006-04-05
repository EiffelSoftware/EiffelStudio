indexing
	description: "C virtual property genetor.  Generate virtual functions for property"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_VIRTUAL_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_PROPERTY_GENERATOR

feature -- Basic operations

	generate (a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C++ virtual functions
		require
			non_void_descriptor: a_descriptor /= Void
		local
			a_name, a_comment, a_signature: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_setting_feature.make
			create c_access_feature.make

			create a_name.make (100)
			a_name.append (Set_clause)
			a_name.append (a_descriptor.name)
			c_setting_feature.set_name (a_name)

			c_setting_feature.set_result_type (Hresult)

			create a_comment.make (100)
			a_comment.append ("Set ")
			a_comment.append (a_descriptor.name)
			c_setting_feature.set_comment (a_comment)

			create visitor
			visitor.visit (a_descriptor.data_type)
			if visitor.c_header_file /= Void and then not visitor.c_header_file.is_empty then
				set_header_file (visitor.c_header_file)
			end

			create a_signature.make (100)
			a_signature.append (visitor.c_type)
			a_signature.append (Space)
			a_signature.append (Tmp_clause)
			a_signature.append (a_descriptor.name)
			c_setting_feature.set_signature(a_signature)
			c_setting_feature.set_pure_virtual

			create a_name.make (100)
			a_name.append (Get_clause)
			a_name.append (a_descriptor.name)
			c_access_feature.set_name (a_name)

			c_access_feature.set_result_type (Hresult)

			create a_comment.make (100)
			a_comment.append ("Get ")
			a_comment.append (a_descriptor.name)
			c_access_feature.set_comment (a_comment)

			create a_signature.make (100)
			a_signature.append (visitor.c_type)
			a_signature.append (Space)
			a_signature.append (Tmp_clause)
			a_signature.append (a_descriptor.name)
			c_access_feature.set_signature(a_signature)
			c_access_feature.set_pure_virtual			
		ensure
			setting_feature_exists: c_setting_feature /= Void
			access_feature_exists: c_access_feature /= Void
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
end -- class WIZARD_C_VIRTUAL_PROPERTY_GENERATOR

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

