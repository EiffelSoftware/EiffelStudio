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

end -- class WIZARD_C_VIRTUAL_PROPERTY_GENERATOR
