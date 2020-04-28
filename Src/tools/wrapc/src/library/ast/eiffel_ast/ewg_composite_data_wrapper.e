note

	description:

		"Deferred common base for classes that wrap composite data types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_COMPOSITE_DATA_WRAPPER

inherit

	EWG_COMPOSITE_WRAPPER
		rename
			make as make_composite_wrapper
		end

	EWG_ABSTRACT_TYPE_WRAPPER
		rename
			make as make_abstract_wrapper
		end

create
	make

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING; a_header_file_name: STRING;
			a_c_composite_data_type: EWG_C_AST_COMPOSITE_DATA_TYPE; a_members: like members)
			-- Create new composite data wrapper
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_c_composite_data_type_not_void: a_c_composite_data_type /= Void
			a_members_not_void: a_members /= Void
		do
			c_composite_data_type := a_c_composite_data_type
			make_composite_wrapper (a_mapped_eiffel_name, a_header_file_name, a_members)
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			c_composite_data_type_set: c_composite_data_type = a_c_composite_data_type
			members_set: members = a_members
		end

feature -- Access 

	c_composite_data_type: EWG_C_AST_COMPOSITE_DATA_TYPE
			-- C type to wrapp

	type: EWG_C_AST_TYPE
		do
			Result := c_composite_data_type
		end

invariant

	c_composite_data_type_not_void: c_composite_data_type /= Void

end
