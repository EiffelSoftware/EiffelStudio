note
	description: "[
		JSON_VALUE represent a value in JSON. 
		        A value can be
		            * a string in double quotes
		            * a number
		            * boolean value(true, false )
		            * null
		            * an object
		            * an array
	]"
	author: "Javier Velilla"
	date: "2008/05/19"
	revision: "Revision 0.1"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"

deferred class
	JSON_VALUE

inherit

	HASHABLE

	DEBUG_OUTPUT

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
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
