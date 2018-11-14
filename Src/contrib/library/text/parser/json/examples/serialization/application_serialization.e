note
	description: "[
			Collection of JSON serialization examples.
		]"

class
	APPLICATION_SERIALIZATION

create
	make

feature {NONE} -- Initialization

	make
		do
			demonstrate_custom_serialization
			demonstrate_basic_serialization
			demonstrate_reflector_serialization
			demonstrate_smart_serialization
		end

feature -- Example		

	demonstrate_custom_serialization
		local
			l_custom: DEMO_CUSTOM_SERIALIZATION
		do
				-- Example of custom serialization
			create l_custom.make
		end

	demonstrate_basic_serialization
		local
			l_basic: DEMO_BASIC_SERIALIZATION
		do
				-- Example of basic serialization
			create l_basic.make
		end

	demonstrate_reflector_serialization
			-- Use reflector serialization, mostly for storage since the serialized json contains internal attributes...
			-- So not a simple json output.
		local
			fac: JSON_SERIALIZATION_FACTORY
			conv: JSON_SERIALIZATION
			obj: like new_object
		do
			print ("%N")
			print ("=====================================================%N")
			print ("= Serialization using only Reflection functionality =%N")
			print ("=====================================================%N")
			print ("%N")
			obj := new_object

			conv := fac.reflector_serialization

			conv.set_pretty_printing
			if attached conv.to_json_string (obj) as s then
				print ("Object to json:%N")
				print (s)
				print ("%N")

				if attached {like new_object} conv.from_json_string (s, {STRING_TABLE [ARRAYED_LIST [ANY]]}) as l_obj then
					print ("JSON to object:%N")
					print (conv.to_json_string (l_obj))
					print ("%N")
					print (l_obj.item ("abc"))
					print (l_obj.item ("123"))
				elseif conv.has_deserialization_error then
					print ("Error occurred!%N")
					if attached conv.context.deserialization_error as err then
						print (err.all_messages_as_string)
					end
				end
			end
		end

	demonstrate_smart_serialization
			-- Use smart serialization, i.e use json array [ .. ] and json object { .. : .. }.
			-- And deserialization is made possible thanks to specific callback.
		local
			fac: JSON_SERIALIZATION_FACTORY
			conv: JSON_SERIALIZATION
			obj: like new_object
		do
			print ("%N")
			print ("============================================================================%N")
			print ("= Serialization to simple json formating, and deserialization via callback =%N")
			print ("============================================================================%N")
			print ("%N")
			obj := new_object

			conv := fac.smart_serialization

			conv.set_pretty_printing
			if attached conv.to_json_string (obj) as s then
				print ("Object to json:%N")
				print (s)
				print ("%N")

					-- For deserialization, we need to help with a callback to create expected objects for specific json types
					-- such as JSON Array and some JSON object (as dictionary).
				conv.context.deserializer_context.set_value_creation_callback (create {JSON_DESERIALIZER_CREATION_AGENT_CALLBACK}.make (
						agent (a_info: JSON_DESERIALIZER_CREATION_INFORMATION)
						do
							if a_info.static_type = {ARRAYED_LIST [ANY]} then
								a_info.set_object (create {ARRAYED_LIST [ANY]}.make (0))
							elseif a_info.static_type = {STRING_TABLE [ARRAYED_LIST [ANY]]} then
								a_info.set_object (create {STRING_TABLE [ARRAYED_LIST [ANY]]}.make (0))
							end
						end
					)
				)
				if attached conv.from_json_string (s, {STRING_TABLE [ARRAYED_LIST [ANY]]}) as l_obj then
					print ("JSON to object:%N")
					print (conv.to_json_string (l_obj))
					print ("%N")
				elseif conv.has_deserialization_error then
					print ("Error occurred!%N")
					if attached conv.context.deserialization_error as err then
						print (err.all_messages_as_string)
					end
				end
			end
		end

feature -- Object factory		

	new_object: STRING_TABLE [ARRAYED_LIST [ANY]]
		local
			lst: ARRAYED_LIST [ANY]
		do
			create Result.make (2)
			create lst.make (3)
			lst.extend ("a")
			lst.extend ("b")
			lst.extend ("c")
			Result.put (lst, "abc")
			create lst.make (3)
			lst.extend (1)
			lst.extend (2)
			lst.extend (3)
			Result.put (lst, "123")
		end

end
