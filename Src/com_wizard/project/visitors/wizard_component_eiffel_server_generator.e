indexing
	description: "Component Eiffel generator for server"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_GENERATOR 

	WIZARD_VARIABLE_NAME_MAPPER
	
	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end


feature {NONE} -- Implementation

	make_feature: WIZARD_WRITER_FEATURE is
			-- `make' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (Make_word)
			Result.set_comment ("Creation. Implement if needed.")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	make_from_pointer_feature:  WIZARD_WRITER_FEATURE is
			-- `make_from_pointer' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name ("make_from_pointer")
			Result.set_comment ("Creation.")

			Result.add_argument ("cpp_obj: POINTER")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("set_item (cpp_obj)")

			feature_body.append (New_line_tab_tab_tab)
			feature_body.append (make_word)

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	create_item_feature: WIZARD_WRITER_FEATURE is
			-- `create_item' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name ("create_item")
			Result.set_comment ("Initialize %Qitem%'")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("item := ccom_create_item (Current)")

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

end -- class WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

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

