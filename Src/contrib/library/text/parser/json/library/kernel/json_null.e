note
	description: "JSON Null Values"
	author: "Javier Velilla"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_NULL

inherit
	JSON_VALUE
		redefine
			is_null
		end

feature -- Status report			

	is_null: BOOLEAN = True
			-- <Precursor>

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := null_value.hash_code
		end

feature -- Conversion		

	representation: STRING
		do
			Result := "null"
		ensure then
			instance_free: class
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_element_a' procedure on `a_visitor'.)
		do
			a_visitor.visit_json_null (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := null_value
		end

feature {NONE} -- Implementation

	null_value: STRING = "null"

note
	copyright: "2010-2019, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
