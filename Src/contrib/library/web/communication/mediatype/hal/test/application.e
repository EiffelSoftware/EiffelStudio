note
	description: "HAL application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

--inherit

--	SHARED_EJSON

create
	make

feature {NONE} -- Initialization

	make
		do
			create file_reader
--			test_json_min
--			test_json_hal
--			test_json_link
--			test_hal
			test_item_line_item
			test_order

			example_from_hal_to_domain
			test_build_hal_json
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
			l_currency : STRING
			l_status : STRING
			l_placed : STRING
		do
			create js_hal.make

			if attached json_file_from ("hal_example.json") as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jo then
					if attached {HAL_RESOURCE} js_hal.from_json (jo) as r then
					    if attached {ARRAYED_LIST [HAL_RESOURCE]} r.embedded_resources_by_key ("order") as l_r then
							from
								l_r.start
							until
								l_r.after
							loop
								l_res:= l_r.item_for_iteration

					            if attached {STRING} l_res.fields_by_key ("currency") as l_ucs then
					            	l_currency := l_ucs
					            	print ("Currency:" + l_currency)
					            	io.put_new_line
					            end

					            if attached {STRING} l_res.fields_by_key ("status") as l_ucs then
					            	l_status := l_ucs
									print ("Status:" + l_status )
									io.put_new_line
								end

								if attached {STRING} l_res.fields_by_key ("placed") as l_ucs then
					            	l_placed := l_ucs
					            	print ("Placed:" + l_placed )
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
			if attached {JSON_VALUE} serial.to_json (line) as jv then
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
					if attached {HAL_RESOURCE} conv.from_json (jo) as r then
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
						if attached r.links_by_key ("next") as ln then
							check
								ln.rel ~ "next"
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
