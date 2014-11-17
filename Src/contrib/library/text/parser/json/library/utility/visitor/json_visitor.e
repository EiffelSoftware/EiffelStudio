note
	description: "JSON Visitor"
	pattern: "Visitor"
	author: "Javier Velilla"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"
	date: "2008/08/24"
	revision: "Revision 0.1"

deferred class
	JSON_VISITOR

feature -- Visitor Pattern

	visit_json_array (a_json_array: JSON_ARRAY)
			-- Visit `a_json_array'.
		require
			a_json_array_not_void: a_json_array /= Void
		deferred
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		require
			a_json_boolean_not_void: a_json_boolean /= Void
		deferred
		end

	visit_json_null (a_json_null: JSON_NULL)
			-- Visit `a_json_null'.
		require
			a_json_null_not_void: a_json_null /= Void
		deferred
		end

	visit_json_number (a_json_number: JSON_NUMBER)
			-- Visit `a_json_number'.
		require
			a_json_number_not_void: a_json_number /= Void
		deferred
		end

	visit_json_object (a_json_object: JSON_OBJECT)
			-- Visit `a_json_object'.
		require
			a_json_object_not_void: a_json_object /= Void
		deferred
		end

	visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.
		require
			a_json_string_not_void: a_json_string /= Void
		deferred
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
