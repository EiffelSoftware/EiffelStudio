indexing
	description: "C virtual property genetor.  Generate virtual functions for property"
	status: "See notice at end of class";
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
			tmp_string: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_setting_feature.make
			create c_access_feature.make

			tmp_string := clone (Set_clause)
			tmp_string.append (a_descriptor.name)
			c_setting_feature.set_name (tmp_string)

			c_setting_feature.set_result_type (Hresult)

			tmp_string := "Set "
			tmp_string.append (a_descriptor.name)
			c_setting_feature.set_comment (tmp_string)

			create visitor
			visitor.visit (a_descriptor.data_type)
			if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
				set_header_file (visitor.c_header_file)
			end

			tmp_string := clone (visitor.c_type)
			tmp_string.append (Space)
			tmp_string.append (Tmp_clause)
			tmp_string.append (a_descriptor.name)

			c_setting_feature.set_signature(tmp_string)
			c_setting_feature.set_pure_virtual

			tmp_string := clone (Get_clause)
			tmp_string.append (a_descriptor.name)
			c_access_feature.set_name (tmp_string)

			c_access_feature.set_result_type (Hresult)

			tmp_string := "Get "
			tmp_string.append (a_descriptor.name)
			c_access_feature.set_comment (tmp_string)

			tmp_string := clone (visitor.c_type)
			tmp_string.append (Space)
			tmp_string.append (Tmp_clause)
			tmp_string.append (a_descriptor.name)

			c_access_feature.set_signature(tmp_string)
			c_access_feature.set_pure_virtual			
		ensure
			setting_feature_exists: c_setting_feature /= Void
			access_feature_exists: c_access_feature /= Void
		end

end -- class WIZARD_C_VIRTUAL_PROPERTY_GENERATOR
