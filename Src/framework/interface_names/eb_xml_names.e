indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_XML_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	err_attribute_missing (a_attr: STRING_GENERAL): STRING_32 is
		require
			a_attr_attached: a_attr /= Void
		do
			Result := locale.formatted_string ("Attribute %"$1%" is missing.", [a_attr])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_attribute (a_attribute: STRING_GENERAL): STRING_32 is
			-- Invalid attribute error
		require
			a_attribute_attached: a_attribute /= Void
		do
			Result := locale.formatted_string (locale.translation ("Invalid attribute %"$1%"."), [a_attribute])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag_position (a_tag: STRING_GENERAL): STRING_32 is
			-- Invalid tag error
		require
			a_tag_attached: a_tag /= Void
		do
			Result := locale.formatted_string (locale.translation ("Invalid tag/tag position %"$1%"."), [a_tag])
		ensure
			result_attached: Result /= Void
		end

	err_boolean_value_invalid (a_attr_name: STRING_GENERAL; a_value: STRING_GENERAL): STRING_32 is
		require
			a_attr_name_attached: a_attr_name /= Void
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"$2%" is invalid. A boolean is expected."), [a_value, a_attr_name])
		ensure
			result_attached: Result /= Void
		end

end
