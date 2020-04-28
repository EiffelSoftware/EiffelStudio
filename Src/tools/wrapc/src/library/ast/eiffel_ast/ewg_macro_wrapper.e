note
	description: "Summary description for {EWG_MACRO_WRAPPER}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWG_MACRO_WRAPPER

inherit
	EWG_MEMBER_WRAPPER
		rename
			make as make_member_wrapper
		end

create

	make

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING;
			a_header_file_name: STRING;
			a_class_name: STRING;
			a_constant_name: STRING;
			a_type: STRING;
			a_value: STRING
			)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_class_name_not_void: a_class_name /= Void
			a_class_name_not_empty: a_class_name.count > 0
			a_constant_name_not_void: a_constant_name /= Void
			a_constant_name_not_empty: a_constant_name.count > 0
		do
			make_member_wrapper (a_mapped_eiffel_name, a_header_file_name)
			class_name := a_class_name
			constant_name := a_constant_name
			eiffel_type := a_type
			eiffel_value := a_value
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			class_name_set: class_name = a_class_name
			constant_name_set: constant_name = a_constant_name
		end

feature -- Access

	class_name: STRING
			-- Name of Eiffel class the wrappers for this function should be placed in

	constant_name: STRING
			-- Name of the C constant.

	eiffel_type: STRING
			-- Name of the proposed Eiffel type.

	eiffel_value: STRING
			-- String representation of value.


	proposed_feature_name_list: DS_LINEAR [STRING]
		local
			list: DS_LINKED_LIST [STRING]
		do
			create list.make
			list.put_last (mapped_eiffel_name)
			Result := list
		end

invariant

	class_name_not_void: class_name /= Void
	class_name_not_empty: class_name.count > 0
	class_name_valid_eiffel_identifier: True -- TODO

end
