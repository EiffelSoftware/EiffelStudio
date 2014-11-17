note
	description: "JSON Iterator"
	pattern: "Iterator visitor"
	author: "Jocelyn Fiat"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"
	date: "2013/08/01"
	revision: "Revision 0.1"

deferred class
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
				c.item.accept (Current)
			end
		end

	visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.
		do
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
