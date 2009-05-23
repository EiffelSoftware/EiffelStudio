note
	description: "[
		{XTAG_F_VALIDATOR_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_VALIDATOR_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
		do
			make_base
			validator_class := ""
		end

feature -- Access

	validator_class: STRING
			-- Identification of the input field for the validation mapping

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if a_id.is_equal ("class") then
				validator_class := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			if attached {LIST [STRING]} a_variable_table [Validator_tag_list_key] as l_validator_list then
				l_validator_list.extend (validator_class)
			else
				a_servlet_class.render_feature.append_comment ("AN ERROR OCCURRED IN GENERATION OF XTAG_F_VALIDATION_RESULT")
			end
		end

feature -- Constants
	Validator_tag_list_key: STRING = "Validator_tag_list_key"

end
