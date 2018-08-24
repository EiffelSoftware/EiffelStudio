note
	description: "Input to translator."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TRANSLATOR_INPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize empty input.
		do
			create class_list.make
			create feature_list.make
			create feature_of_type_list.make
			create class_check_list.make
		end

feature -- Acces

	class_list: attached LINKED_LIST [attached CLASS_C]
			-- List of classes to be translated.

	feature_list: attached LINKED_LIST [attached FEATURE_I]
			-- List of features to be translated.

	feature_of_type_list: attached LINKED_LIST [TUPLE [f: FEATURE_I; t: CL_TYPE_A]]
			-- List of features with a specific type to be translated.

	class_check_list: attached LINKED_LIST [CL_TYPE_A]
			-- List of classes whose class check is to be generated.

feature -- Element change

	add_class (a_class: attached CLASS_C)
			-- Add `a_class' to be translated.
		do
			class_list.extend (a_class)
		end

	add_feature (a_feature: attached FEATURE_I)
			-- Add `a_feature' to be translated.
		do
			feature_list.extend (a_feature)
		end

	add_feature_of_type (a_feature: attached FEATURE_I; a_type: CL_TYPE_A)
			-- Add `a_feature' to be translated.
		do
			feature_of_type_list.extend ([a_feature, a_type])
		end

	add_class_check (a_class: CL_TYPE_A)
			-- Add `a_class' to be translated.
		do
			class_check_list.extend (a_class)
		end

end
