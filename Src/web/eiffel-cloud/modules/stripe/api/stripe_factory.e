note
	description: "Summary description for {STRIPE_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_FACTORY

feature -- Creation

	stripe_object (a_json: READABLE_STRING_8): detachable STRIPE_OBJECT
		local
			jp: JSON_PARSER
			l_object_type: READABLE_STRING_8
		do
			create jp.make
			jp.parse_string (a_json)
			if
				jp.is_parsed and then
				jp.is_valid and then
				attached jp.parsed_json_object as jo and then
				attached jo.string_item ("object") as js
			then
				l_object_type := js.unescaped_string_8
				if l_object_type /= Void then
					if l_object_type.is_case_insensitive_equal_general ("invoice") then
						create {STRIPE_INVOICE} Result.make_with_json (jo)
					elseif l_object_type.is_case_insensitive_equal_general ("payment_intent") then
						create {STRIPE_PAYMENT_INTENT} Result.make_with_json (jo)
					elseif l_object_type.is_case_insensitive_equal_general ("subscription") then
						create {STRIPE_SUBSCRIPTION} Result.make_with_json (jo)
					elseif l_object_type.is_case_insensitive_equal_general ("plan") then
						create {STRIPE_PLAN} Result.make_with_json (jo)
					elseif l_object_type.is_case_insensitive_equal_general ("customer") then
						create {STRIPE_CUSTOMER} Result.make_with_json (jo)
					end
				end
			end
		ensure
			instance_free: class
		end

end
