note
	description: "HAL application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		do
			create file_reader
			test_json_min
			test_json_hal
--			test_json_link
			test_hal
			test_item_line_item
			test_order
			test_hal_types
			test_example_with_nested_objects

			test_embedded_hal_json

			example_from_hal_to_domain
			test_build_hal_json
			test_hal_values
		end

	test_build_hal_json
		local
			conv: JSON_HAL_RESOURCE_CONVERTER
			l_res: HAL_RESOURCE
			l_link: HAL_LINK
			l_attribute: HAL_LINK_ATTRIBUTE
		do
			create conv.make
			create l_attribute.make ("/orders?{id}")
			l_attribute.set_name ("orders")

			create l_res.make
			l_res.add_curie_link (l_attribute)

			create l_attribute.make ("/")
			create l_link.make_with_attribute ("self",l_attribute )
			l_res.add_link (l_link)

			create l_attribute.make ("/pages/?{page}")
			l_attribute.set_name ("pages")
			create l_link.make_with_attribute ("curies",l_attribute)
			l_res.add_link (l_link)

			print ("%Nis_valid_resource:" + l_res.is_valid_resource.out )
			io.put_new_line
			if attached conv.to_json (l_res) as j then
				print (j.representation)

				if attached conv.from_json (j) as hal then
					print (hal)
					print (friendly_output (hal))
				end
			end
		end


	test_embedded_hal_json
		local
			conv: JSON_HAL_RESOURCE_CONVERTER
			l_res: HAL_RESOURCE
			l_link: HAL_LINK
			l_attribute: HAL_LINK_ATTRIBUTE
			l_items: HAL_RESOURCE
			l_list: LIST [HAL_RESOURCE]
		do
			create conv.make
			create l_attribute.make ("/orders?{id}")
			l_attribute.set_name ("orders")

			create l_res.make
			l_res.add_curie_link (l_attribute)

			create l_attribute.make ("/")
			create l_link.make_with_attribute ("self",l_attribute )
			l_res.add_link (l_link)

			create l_attribute.make ("/pages/?{page}")
			l_attribute.set_name ("pages")
			create l_link.make_with_attribute ("curies",l_attribute)
			l_res.add_link (l_link)


			create l_items.make
			l_items.add_integer_field ("product_id", 1)
			l_items.add_integer_field ("count", 1)
			create {ARRAYED_LIST[HAL_RESOURCE]} l_list.make (1)
			l_list.force (l_items)
			l_res.add_embedded_resources_with_key ("items", l_list)

			print ("%Nis_valid_resource:" + l_res.is_valid_resource.out )
			io.put_new_line
			if attached conv.to_json (l_res) as j then
				print (j.representation)

				if attached conv.from_json (j) as hal then
					print (hal)
					print (friendly_output (hal))
				end
			end
		end


	friendly_output (obj: detachable ANY): STRING
		local
			serial: JSON_REFLECTOR_SERIALIZER
			ctx: JSON_SERIALIZER_CONTEXT
		do
			create ctx
			ctx.set_pretty_printing
			ctx.set_is_type_name_included (False)
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})
			create serial
			Result := serial.to_json_string (obj, ctx)
		end

	example_from_hal_to_domain
		local
			js_hal:  JSON_HAL_RESOURCE_CONVERTER
			l_res : HAL_RESOURCE
			l_currency : READABLE_STRING_32
			l_status : READABLE_STRING_32
			l_placed : READABLE_STRING_32
		do
			create js_hal.make

			if attached json_file_from ("hal_example.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					if attached js_hal.from_json (jo) as r then
					    if attached r.embedded_resources_by_key ("order") as l_r then
							from
								l_r.start
							until
								l_r.after
							loop
								l_res:= l_r.item_for_iteration

					            if attached l_res.string_field ("currency") as l_ucs then
					            	l_currency := l_ucs
					            	print ("Currency:" + l_currency)
					            	io.put_new_line
					            end

					            if attached l_res.string_field ("status") as l_ucs then
					            	l_status := l_ucs
									print ("Status:" + l_status)
									io.put_new_line
								end

								if attached l_res.string_field ("placed") as l_ucs then
					            	l_placed := l_ucs
					            	print ("Placed:" + l_placed)
					            	io.put_new_line
								end

								l_r.forth
							end
					    end
					end
				end
			end
		end

	test_order
		local
			l_item: ITEM
			line: LINE_ITEM
			l_cust: CUSTOMER
			l_order: ORDER
			serial: JSON_SERIALIZATION
			ctx: JSON_SERIALIZATION_CONTEXT
		do
			create ctx
			create serial.make_with_context (ctx)
			ctx.register (create {JSON_ITEM_CONVERTER}, {ITEM})
			ctx.register (create {JSON_LINE_ITEM_CONVERTER}, {LINE_ITEM})
			ctx.register (create {JSON_ORDER_CONVERTER}, {ORDER})
			ctx.register (create {JSON_CUSTOMER_CONVERTER}, {CUSTOMER})

			create line.make ("basket")
			create l_item.make ("ABCD123", 2, 9.5)
			line.add_item (l_item)
			create l_item.make ("GFZ111", 1, 11)
			line.add_item (l_item)

			create l_cust.make ("Javier", "test@hal.com")
			create l_order.make ("test", "USD", "Placed", l_cust)
			across
				line.items as ic
			loop
				l_order.add_item (ic.item)
			end

			if attached {JSON_VALUE} serial.to_json (l_order) as jv then
				print (jv.representation)
			end
		end

	test_item_line_item
		local
			l_item: ITEM
			line: LINE_ITEM
			serial: JSON_SERIALIZATION
			ctx: JSON_SERIALIZATION_CONTEXT
		do
			create ctx
			create serial.make_with_context (ctx)
			ctx.register (create {JSON_ITEM_CONVERTER}, {ITEM})
			ctx.register (create {JSON_LINE_ITEM_CONVERTER}, {LINE_ITEM})
			create line.make ("basket")
			create l_item.make ("ABCD123", 2, 9.5)
			line.add_item (l_item)
			create l_item.make ("GFZ111", 1, 11)
			line.add_item (l_item)
			if attached serial.to_json (line) as jv then
				print (jv.representation)
			end
		end

	test_hal
		local
			conv: JSON_HAL_RESOURCE_CONVERTER
		do
			create conv.make
			if attached json_file_from ("hal_example.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					if attached conv.from_json (jo) as r then
						print (r.out)
						if attached conv.to_json (r) as jv then
							print (jv.representation)
						end
						if attached r.self as l_link then
							print (l_link.out)
						end
						if attached r.links_keys as lk then
							print (lk.out)
						end
						if attached r.link_by_key ("next") as ln then
							check
								ln.rel.same_string ("next")
							end
						end
					end
				end
			end
		end

	test_hal_types
		local
			conv: JSON_HAL_RESOURCE_CONVERTER
		do
			create conv.make
			if attached json_file_from ("hal_example_type.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					if attached conv.from_json (jo) as r then
						print (r.out)
						print ("%N")
						if attached conv.to_json (r) as jv then
							print (jv.representation)
						end
					end
				end
			end
		end

	test_example_with_nested_objects
		local
			conv: JSON_HAL_RESOURCE_CONVERTER
		do
			create conv.make
			if attached json_file_from ("exampleWithNestedObjects.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					if attached conv.from_json (jo) as r then
						print (r.out)
						print ("%N")
						if attached conv.to_json (r) as jv then
							print (jv.representation)
						end
							-- expired is BOOLEAN
						if r.is_integer_field ("expired") then
							print ("%N")
							print (r.integer_field ("expired").out)
						end
						if r.is_boolean_field ("expired") then
							print ("%N")
							print (r.boolean_field ("expired").out)
						end
							-- Integer
						if r.is_integer_field ("age") then
							print ("%N")
							print (r.integer_field ("age").out)
						end
							-- Array with String table
						if r.is_array_field ("children") then
							if attached r.array_field ("children") as l_array then
								across l_array as ic loop
									print ("%N")
									if attached ic.item as l_item then
										print (l_item.out)
									end
								end
							end
						end
					end
				end
			end
		end

	test_json_hal
			--
		do
			if attached json_file_from ("hal_example.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					print (jo.representation)
				end
			end
		end

--	test_json_link
--			--
--		local
--			r : HASH_TABLE [LINK, STRING]
--		do
--			if attached json_file_from ("hal_multi_links.json") as json_file then
--				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
--					if attached {JSON_OBJECT} jo.item ("_links") as j_links then
--						r := from_json_link (j_links)
--						print (r.out)
--					end
--				end
--			end
--		end

	test_json_min
			--
		do
			if attached json_file_from ("min_hal.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					print (jo.representation)
				end
			end
		end

	test_hal_values
		local
			l_hal: HAL_RESOURCE
			l_int: INTEGER_64
			l_nat: NATURAL_64
			l_real: REAL_64
		do
			create l_hal.make
			l_hal.add_integer_field ("integer_8", {INTEGER_8} 8)
			check is_integer_8: l_hal.is_integer_field ("integer_8") end
			l_int := l_hal.integer_field ("integer_8")
			print ("%Nint " + l_int.out)

			l_hal.add_natural_field ("natural_8", {NATURAL} 255)
			check is_natural_8: l_hal.is_natural_field ("natural_8") end
			l_nat := l_hal.natural_field ("natural_8")
			print ("%Nnat " + l_nat.out)

			l_hal.add_real_field ("real_32", {REAL} 255.32)
			check is_real_32: l_hal.is_real_field ("real_32") end
			l_real := l_hal.real_field ("real_32")
			print ("%Nreal " + l_real.out)
		end

feature -- Implementation

	file_reader: JSON_FILE_READER

	json_file_from (fn: STRING): detachable STRING
		do
			Result := file_reader.read_json_from (fn)
		ensure
			Result /= Void
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

	json_value_from_file (json_file: STRING): detachable JSON_VALUE
		local
			p: like new_json_parser
		do
			p := new_json_parser (json_file)
			p.parse_content
			check
				json_is_parsed: p.is_parsed
			end

			Result := p.parsed_json_value
		end

end
