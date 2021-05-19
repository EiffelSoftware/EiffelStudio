note
	description: "[
		JSON_VALUE represents a value in JSON. 
		        A value can be
		            * a string in double quotes
		            * a number
		            * boolean value (true, false)
		            * null
		            * an object
		            * an array
	]"
	date: "$Date$"
	revision: "$Revision$"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"
	EIS: "name=Introducing JSON", "protocol=URI", "src=http://json.org/"

deferred class
	JSON_VALUE

inherit
	HASHABLE

	DEBUG_OUTPUT

feature -- Status report

	is_string: BOOLEAN
			-- Is Current a string value?
		do
		end

	is_number: BOOLEAN
			-- Is Current a number value?
		do
		end

	is_object: BOOLEAN
			-- Is Current an object value?	
		do
		end

	is_array: BOOLEAN
			-- Is Current an array value?
		do
		end

	is_null: BOOLEAN
			-- Is Current a null value?	
		do
		end

feature -- Access

	has_key (a_key: JSON_STRING): BOOLEAN
			-- Has Current an item associated with `a_key`?
			-- relevant for object and array values!
		do
		end

	chained_item alias "@" alias "/" (a_key: JSON_STRING): JSON_VALUE
			-- Item associated with key `a_key` if exists.
			-- Note: if item does not exists, return also JSON_NULL.
		do
			create {JSON_NULL} Result
		end

feature -- Status report

	same_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Current value is a string value, and same content as `a_string`?
		do
				-- To redefined in descendants.
		end

	same_caseless_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Current value is a string value, and same caseless content as `a_string`?	
		do
				-- To redefined in descendants.
		end

feature -- Conversion

	representation: STRING
			-- UTF-8 encoded Unicode string representation of Current
		deferred
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_*' procedure on `a_visitor'.)
		require
			a_visitor_not_void: a_visitor /= Void
		deferred
		end

note
	copyright: "2010-2021, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
