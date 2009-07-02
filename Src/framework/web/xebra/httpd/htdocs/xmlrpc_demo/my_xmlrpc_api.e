note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	MY_XMLRPC_API

inherit
	XWA_XRPC_API

feature -- Basic operations

	hello (a_name: STRING): STRING
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := "Hello there " + a_name.string
		end

	test_array (a_array: XRPC_ARRAY): BOOLEAN
		do
			Result := a_array.count > 0 and attached {XRPC_BOOLEAN} a_array.item (1) as l_bool and then l_bool.value
		end

	sum (i, j: NATURAL_16): INTEGER
			-- XML-RPC using Eiffel types.
		do
			Result := (i + j).as_integer_32
		end

	product(i, j: DOUBLE): DOUBLE
			-- XML-RPC using Eiffel types.
		do
			Result := i * j
		end

	sum_x (a_int1: XRPC_INTEGER; a_int2: XRPC_INTEGER): XRPC_INTEGER
			-- XML-RPC using XRPC types.
		do
			create Result.make (a_int1.value + a_int2.value)
		end

end
