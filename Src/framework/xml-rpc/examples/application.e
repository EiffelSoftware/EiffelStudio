class
	APPLICATION

inherit
	XRPC_SHARED_SERVER_DISPATCHER

create
	make

feature {NONE} -- Initialization

	make
		local
			l_delegate: MY_XMLRPC
			l_args: ARRAY [XRPC_VALUE]
			l_result: detachable XRPC_RESPONSE
			l_visitor: XRPC_RESPONSE_XML_EMITTER
			l_array: XRPC_MUTABLE_ARRAY
		do
			create l_visitor.make
			--create {XRPC_FAULT_RESPONSE} l_result.make (1, "Hello")
			create l_array.make_empty
			l_array.extend (create {XRPC_INTEGER}.make (10))
			l_array.extend (create {XRPC_STRING}.make ("Hello"))
			l_array.extend (create {XRPC_STRING}.make ("World"))
			create  {XRPC_VALUE_RESPONSE} l_result.make (l_array)
			l_result.visit (l_visitor)

			create l_delegate
			dispatcher.extend (l_delegate)
			check has_dispatcher: l_delegate.has_dispatcher end

				-- Build arg list (because compiler is broken!)
			create l_args.make_filled (create {XRPC_INTEGER}.make (0), 1, 2)
			l_args[1] := create {XRPC_INTEGER}.make (200)
			l_args[2] := create {XRPC_INTEGER}.make (33)

				-- Perform call
			print ("%N-- Performing Call --%N")
			print ("math.sum: ")
				-- Change to math.sumx to use the XML-RPC argument types instead.
			l_result := dispatcher.call ("math.sum", l_args)--<<create {XRPC_INTEGER}.make (200), create {XRPC_DOUBLE}.make (1.22323)>>)
			if attached l_result then
				if l_result.is_fault and then attached {XRPC_FAULT_RESPONSE} l_result as l_fault then
					print (l_fault.message)
				else
					check not_is_fault: not l_result.is_fault end
					if attached {XRPC_INTEGRAL_VALUE [ANY]} l_result.value as l_value then
						print (l_value.value)
					end
				end
				print ("%N")
			end
			print ("-- Done --%N")
		end

end
