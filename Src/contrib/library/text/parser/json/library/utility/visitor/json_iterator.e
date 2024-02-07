note
	description: "JSON Iterator"
	pattern: "Iterator visitor"
	author: "Jocelyn Fiat"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ITERATOR

inherit
	JSON_VISITOR

feature -- Visitor Pattern

	visit_json_array (a_json_array: JSON_ARRAY)
			-- Visit `a_json_array'.
		do
			across
				a_json_array as c
			loop
				c.item.accept (Current)
			end
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		do
		end

	visit_json_null (a_json_null: JSON_NULL)
			-- Visit `a_json_null'.
		do
		end

	visit_json_number (a_json_number: JSON_NUMBER)
			-- Visit `a_json_number'.
		do
		end

	visit_json_object (a_json_object: JSON_OBJECT)
			-- Visit `a_json_object'.
		do
			across
				a_json_object as c
			loop
				visit_json_object_member (c.key, c.item)
			end
		end

	visit_json_object_member (a_json_name: JSON_STRING; a_json_value: JSON_VALUE)
			-- Visit `a_json_object'.
		do
			a_json_value.accept (Current)
		end

	visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.
		do
		end

note
	copyright: "2010-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
