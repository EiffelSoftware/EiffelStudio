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
	copyright: "2010-2017, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
