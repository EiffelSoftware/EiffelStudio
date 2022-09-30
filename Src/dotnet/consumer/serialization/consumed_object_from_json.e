note
	description: "[
		JSON deserialization of dotnet CONSUMED_... objects.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_OBJECT_FROM_JSON

create
	make

feature {NONE} -- Initialization

	make
		do
			if {EIFFEL_SERIALIZATION}.use_long_json_names then
				create names
			else
				create {CONSUMED_OBJECT_JSON_SHORT_NAMES} names
			end
		end

feature -- Settings

	names: CONSUMED_OBJECT_JSON_NAMES

feature -- Status report

	has_error: BOOLEAN

feature -- Deserialization

	from_json_file (f: FILE): like from_json
		local
			s: STRING_8
		do
			has_error := False
			from
				create s.make (f.count)
				f.open_read
			until
				f.end_of_file or f.exhausted
			loop
				f.read_stream (1024)
				s.append (f.last_string)
			end
			f.close
			Result := from_json_string (s)
		end

	from_json_file_at (f: FILE; a_pos: INTEGER): like from_json
		local
			s: STRING_8
		do
			has_error := False
			f.open_read
			if a_pos > 0 then
				f.go (a_pos)
			end

			f.read_line
			s := f.last_string
			f.close
			Result := from_json_string (s)
		end

	from_json_string (js: STRING_8): like from_json
		local
			p: JSON_PARSER
		do
			has_error := False
			create p.make
			p.parse_string (js)
			if
				p.is_parsed and then
				p.is_valid
			then
				Result := from_json (p.parsed_json_value)
			else
				has_error := True
			end
		end

	from_json (j: detachable JSON_VALUE): detachable ANY
		local
			n: JSON_STRING
			v: detachable JSON_VALUE
			t: READABLE_STRING_GENERAL
		do
			if j = Void then
				Result := Void
			elseif attached {JSON_OBJECT} j as jobj then
				if jobj.count = 1 then
					across
						jobj as i
					loop
						n := @i.key
						v := i
					end
				elseif attached jobj.string_item ("_type") as l_object_type then
					n := l_object_type
					v := jobj
				end
				if n /= Void then
					t := n.unescaped_string_32
				end
			end
			if t = Void then
				check has_typename: False end
			else
				if
					t.is_case_insensitive_equal ("CONSUMED_TYPE")
					or t.is_case_insensitive_equal ("CONSUMED_NESTED_TYPE")
				then
					Result := consumed_type (v)
				elseif
					t.is_case_insensitive_equal ("CONSUMED_REFERENCED_TYPE")
					or t.is_case_insensitive_equal ("CONSUMED_ARRAY_TYPE")
				then
					Result := consumed_referenced_type (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_ASSEMBLY_MAPPING") then
					Result := consumed_assembly_mapping (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_ASSEMBLY_TYPES") then
					Result := consumed_assembly_types (v)
				elseif t.is_case_insensitive_equal ("CACHE_INFO") then
					Result := cache_info (v)
				elseif t.is_case_insensitive_equal ("CACHE_READER") then
					Result := cache_reader (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_ASSEMBLY") then
					Result := consumed_assembly (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_ARGUMENT") then
					Result := consumed_argument (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_CONSTRUCTOR") then
					Result := consumed_constructor (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_PROCEDURE") then
					Result := consumed_procedure (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_FUNCTION") then
					Result := consumed_function (v)
				elseif
					t.is_case_insensitive_equal ("CONSUMED_FIELD")
					or 	t.is_case_insensitive_equal ("CONSUMED_LITERAL_FIELD")
				then
					Result := consumed_field (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_PROPERTY") then
					Result := consumed_property (v)
				elseif t.is_case_insensitive_equal ("CONSUMED_EVENT") then
					Result := consumed_event (v)
				else
					check supported_type: False end
					print ("From-JSON: unsupported type name:%T")
					print (t)
					print ("%N")
				end
			end
		end

	cache_info (j: detachable JSON_VALUE): detachable CACHE_INFO
		do
			create Result
			if attached {JSON_OBJECT} j as jo then
				if attached {JSON_ARRAY} jo [names.assemblies] as j_assemblies then
					across
						j_assemblies as j_ass
					loop
						if attached consumed_assembly (j_ass) as a then
							Result.add_assembly (a)
						end
					end
				end
			end
		end

	cache_reader (j: detachable JSON_VALUE): detachable ANY --CACHE_READER
		local
		do
--			create Result
			-- TODO
		end

	consumed_assembly_mapping (j: detachable JSON_VALUE): detachable CONSUMED_ASSEMBLY_MAPPING
		local
			assembly_ids: ARRAYED_LIST [CONSUMED_ASSEMBLY]
		do
			if
				j /= Void and then
				attached {JSON_ARRAY} (j / names.assemblies) as lst_assemblies
			then
				create assembly_ids.make (lst_assemblies.count)
				across
					lst_assemblies as ja
				loop
					if attached consumed_assembly (ja) as a then
						assembly_ids.extend (a)
					else
						report_error ("Missing or null assembly")
					end
				end
			else
				create assembly_ids.make (0)
			end
			create Result.make (assembly_ids)
		end

	consumed_assembly_types (j: detachable JSON_VALUE): detachable CONSUMED_ASSEMBLY_TYPES
		local
			l_eiffel_names, l_dotnet_names: ARRAYED_LIST [detachable STRING]
			l_positions, l_flags: ARRAYED_LIST [INTEGER]
			l_count, i, f, nb: INTEGER
		do
			if attached {JSON_OBJECT} j as jo then
				if attached {JSON_NUMBER} (jo[names.count]) as j_count then
					l_count := j_count.integer_64_item.to_integer_32
				end

				create Result.make (l_count)
				nb := l_count

				create l_eiffel_names.make (nb)
				create l_dotnet_names.make (nb)
				create l_flags.make (nb)
				create l_positions.make (nb)

				if attached {JSON_ARRAY} (jo / names.eiffel_names) as lst_eiffel_names then
					check l_count <= lst_eiffel_names.count end
					nb := nb.min (lst_eiffel_names.count)
					i := 0
					across
						lst_eiffel_names as en
					loop
						i := i + 1
						if attached {JSON_STRING} en as str then
							l_eiffel_names.extend (str.unescaped_string_8)
						elseif attached {JSON_NULL} en then
							l_eiffel_names.extend (Void)
						else
							report_error ("ERROR: missing eiffel_name%N")
						end
					end
					check i = l_eiffel_names.count end
					nb := nb.min (l_eiffel_names.count)
				end
				if attached {JSON_ARRAY} (jo / names.dotnet_names) as lst_dotnet_names then
					check l_count <= lst_dotnet_names.count end
					nb := nb.min (lst_dotnet_names.count)
					i := 0
					across
						lst_dotnet_names as dn
					loop
						i := i + 1
						if attached {JSON_STRING} dn as str then
							l_dotnet_names.extend (str.unescaped_string_8)
						elseif attached {JSON_NULL} dn then
							l_dotnet_names.extend (Void)
						else
							report_error ("ERROR: missing dotnet_name%N")
						end
					end
					check i = l_dotnet_names.count end
					nb := nb.min (l_dotnet_names.count)
				end
				if attached {JSON_ARRAY} (jo / names.flags) as lst_flags then
					check l_count <= lst_flags.count end
					nb := nb.min (lst_flags.count)
					across
						lst_flags as fl
					loop
						if attached {JSON_NUMBER} fl as num then
							l_flags.extend (num.integer_64_item.to_integer_32)
						else
							l_flags.extend (0)
						end
					end
				end
				if attached {JSON_ARRAY} (jo / names.positions) as lst_positions then
					check l_count <= lst_positions.count end
					nb := nb.min (lst_positions.count)
					across
						lst_positions as po
					loop
						if attached {JSON_NUMBER} po as num then
							l_positions.extend (num.integer_64_item.to_integer_32)
						else
							l_positions.extend (0)
						end
					end
				end

				from
					i := 1
				until
					i > nb
				loop
					f := l_flags.i_th (i)
					if
						attached l_eiffel_names.i_th (i) as l_en and then
						attached l_dotnet_names.i_th (i) as l_dn
					then
						Result.put (
								l_dn,
								l_en,
								f = {TYPE_FLAGS}.Is_interface,
								f = {TYPE_FLAGS}.Is_enum,
								f = {TYPE_FLAGS}.Is_delegate,
								f = {TYPE_FLAGS}.Is_value_type,
								l_positions.i_th (i)
							)
					end

					i := i + 1
				end
			end
		end

	consumed_assembly (j: detachable JSON_VALUE): detachable CONSUMED_ASSEMBLY
		local
			uid, fn, n, v, c, k, s: JSON_STRING
			is_in_gac: JSON_BOOLEAN
			loc, gp: PATH
		do
			if attached {JSON_OBJECT} j as jo then
				uid := jo.string_item (names.unique_id)
				fn := jo.string_item (names.folder_name)
				n := jo.string_item (names.name)
				v := jo.string_item (names.version)
				c := jo.string_item (names.culture)
				k := jo.string_item (names.key)

				s := jo.string_item (names.location)
				if s /= Void then
					create loc.make_from_string (s.unescaped_string_32)
				end
				s := jo.string_item (names.gac_path)
				if s /= Void then
					create gp.make_from_string (s.unescaped_string_32)
				end
				is_in_gac := jo.boolean_item (names.is_in_gac)

				if
					uid /= Void and fn /= Void and
					n /= Void and v /= Void and c /= Void and k /= Void and
					loc /= Void and gp /= Void and is_in_gac /= Void
				then
					create Result.make (uid.unescaped_string_32, fn.unescaped_string_32,
							n.unescaped_string_32, v.unescaped_string_32, c.unescaped_string_32, k.unescaped_string_32,
							loc, gp, is_in_gac.item
						)
					if attached jo.boolean_item (names.is_consumed) as jb and then jb.item then
						Result.set_is_consumed (True, attached jo.boolean_item (names.has_info_only) as jb2 and then jb2.item)
					end
				end
			end
		end

	consumed_type (j: detachable JSON_VALUE): detachable CONSUMED_TYPE
		local
			en, dn: JSON_STRING
			is_inter, is_abstract, is_sealed, is_value_type, is_enumerator: BOOLEAN
			par: detachable CONSUMED_REFERENCED_TYPE
			inter: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
		do
			if attached {JSON_OBJECT} j as jo then
				en := jo.string_item (names.eiffel_name)
				dn := jo.string_item (names.dotnet_name)
				is_inter := boolean_item (jo, names.is_interface)
				is_abstract := boolean_item (jo, names.is_deferred)
				is_sealed := boolean_item (jo, names.is_frozen)
				is_value_type := boolean_item (jo, names.is_expanded)
				is_enumerator := boolean_item (jo, names.is_enum)

				if attached {JSON_OBJECT} jo [names.parent] as j_par then
					par := consumed_referenced_type (j_par)
				end

				if attached {JSON_ARRAY} jo [names.interfaces] as j_interfaces then
					inter := consumed_referenced_type_list (j_interfaces)
				else
					create inter.make (0)
				end

				if en /= Void and dn /= Void and inter /= Void then
					if attached {JSON_OBJECT} jo [names.enclosing_type] as j_enc_type then
						if attached consumed_referenced_type (j_enc_type) as l_enc_type then
							create {CONSUMED_NESTED_TYPE} Result.make (
									dn.unescaped_string_8, en.unescaped_string_8,
									is_inter, is_abstract, is_sealed, is_value_type, is_enumerator,
									par,
									inter,
									l_enc_type
								)
						else
							report_error ("Missing enclosing type")
						end
					else
						create {CONSUMED_TYPE} Result.make (
								dn.unescaped_string_8, en.unescaped_string_8,
								is_inter, is_abstract, is_sealed, is_value_type, is_enumerator,
								par,
								inter
							)
					end
					if Result /= Void then
						-- Complete the other infos...
						if attached {JSON_ARRAY} jo [names.constructors] as j_constructors then
							Result.set_constructors (consumed_constructors (j_constructors))
						end
						if attached {JSON_ARRAY} jo [names.functions] as j_functions then
							Result.set_functions (consumed_functions (j_functions))
						end
						if attached {JSON_ARRAY} jo [names.procedures] as j_procedures then
							Result.set_procedures (consumed_procedures (j_procedures))
						end
						if attached {JSON_ARRAY} jo [names.fields] as j_fields then
							Result.set_fields (consumed_fields (j_fields))
						end
						if attached {JSON_ARRAY} jo [names.events] as j_events then
							Result.set_events (consumed_events (j_events))
						end
							-- Important to do that at the end.
						if attached {JSON_ARRAY} jo [names.properties] as j_properties then
							Result.set_properties (consumed_properties (j_properties))
						end
--						if attached {JSON_OBJECT} jo [names.associated_reference_type] as j_ass_type then
--							if attached consumed_referenced_type (j_ass_type) as l_ass_type then

--							end
--						end
					end
				else
					report_error ("Missing eiffel or dotnet name")
				end
			end
		end

	consumed_referenced_type (j: detachable JSON_VALUE): detachable CONSUMED_REFERENCED_TYPE
		do
			if attached {JSON_OBJECT} j as jo then
				if
					attached {JSON_STRING} jo [names.name] as jname and then
					attached {JSON_NUMBER} jo [names.assembly_id] as jid
				then
					if attached {JSON_OBJECT} jo [names.element_type] as j_elt_type then
						if attached consumed_referenced_type (j_elt_type) as elt_type then
							create {CONSUMED_ARRAY_TYPE} Result.make (jname.unescaped_string_8, jid.integer_64_item.to_integer_32, elt_type)
						else
							report_error ("Missing element type")
						end
					else
						create Result.make (jname.unescaped_string_8, jid.integer_64_item.to_integer_32)
					end
				else
					report_error ("Missing name or assembly id")
				end
			end
		end

	consumed_referenced_type_list (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached {JSON_OBJECT} j as jo and then
					attached consumed_referenced_type (jo) as crt
				then
					Result.force (crt)
				else
					report_error ("Missing or invalid referenced type")
				end
			end
		end

	consumed_property (j: detachable JSON_VALUE): detachable CONSUMED_PROPERTY
		local
			dn: JSON_STRING
			decl_type: CONSUMED_REFERENCED_TYPE
			cp_getter: detachable CONSUMED_FUNCTION
			cp_setter: detachable CONSUMED_PROCEDURE
		do
			if attached {JSON_OBJECT} j as jo then
				dn := jo.string_item (names.dotnet_name)
				if attached {JSON_OBJECT} jo [names.declared_type] as j_decl_type then
					decl_type := consumed_referenced_type (j_decl_type)
				end
				if dn /= Void and decl_type /= Void then
					cp_getter := consumed_function (jo [names.getter])
					cp_setter := consumed_procedure (jo [names.setter])
					create Result.make_with_updated_getter (
							dn.unescaped_string_8,
							boolean_item (jo, names.is_public),
							boolean_item (jo, names.is_static),
							decl_type,
							cp_getter,
							cp_setter
						)
					update_consumed_entity_from (Result, jo)
				end
			end
		end

	consumed_argument (j: detachable JSON_VALUE): detachable CONSUMED_ARGUMENT
		local
			en, dn: JSON_STRING
			ct: CONSUMED_REFERENCED_TYPE
		do
			if attached {JSON_OBJECT} j as jo then
				en := jo.string_item (names.eiffel_name)
				dn := jo.string_item (names.dotnet_name)
				ct := consumed_referenced_type (jo [names.type])
				if en /= Void and dn /= Void and ct /= Void then
					create Result.make (
							dn.unescaped_string_8, en.unescaped_string_8,
							ct
						)
				else
					report_error (Void)
				end
			end
		end

	consumed_function (j: detachable JSON_VALUE): detachable CONSUMED_FUNCTION
		local
			en, dn, den: JSON_STRING
			args: ARRAYED_LIST [CONSUMED_ARGUMENT]
			ret: CONSUMED_REFERENCED_TYPE
			l_type: CONSUMED_REFERENCED_TYPE
		do
			if attached {JSON_OBJECT} j as jo then
				en := jo.string_item (names.eiffel_name)
				dn := jo.string_item (names.dotnet_name)
				den := jo.string_item (names.dotnet_eiffel_name)
				l_type := consumed_referenced_type (jo [names.declared_type])
				if attached {JSON_ARRAY} jo [names.arguments] as j_args then
					args := consumed_arguments (j_args)
				end
				if args = Void then
					create args.make (0)
				end
				ret := consumed_referenced_type (jo [names.return_type])
				if
					en /= Void and dn /= Void and den /= Void and
					l_type /= Void and args /= Void and ret /= Void
				then
					create Result.make (
							en.unescaped_string_8, dn.unescaped_string_8, den.unescaped_string_8,
							args.to_array,
							ret,
							boolean_item (jo, names.is_frozen),
							boolean_item (jo, names.is_static),
							boolean_item (jo, names.is_deferred),
							boolean_item (jo, names.is_infix),
							boolean_item (jo, names.is_prefix),
							boolean_item (jo, names.is_public),
							boolean_item (jo, names.is_new_slot),
							boolean_item (jo, names.is_virtual),
							boolean_item (jo, names.is_property_or_event),
							l_type
						)

					update_consumed_member_from (Result, jo)
				else
					report_error ("Missing value for function")
				end
			end
		end

	consumed_procedure (j: detachable JSON_VALUE): detachable CONSUMED_PROCEDURE
		local
			en, dn: JSON_STRING
			l_type: CONSUMED_REFERENCED_TYPE
			den: JSON_STRING
			args: ARRAYED_LIST [CONSUMED_ARGUMENT]
		do
			if attached {JSON_OBJECT} j as jo then
				en := jo.string_item (names.eiffel_name)
				dn := jo.string_item (names.dotnet_name)
				den := jo.string_item (names.dotnet_eiffel_name)

				if en = Void then
					if dn /= Void then
						create en.make_from_string_general (dn.unescaped_string_32) -- TODO: check if ok
					end
				end
				if dn /= Void then
					if en = Void then
						create en.make_from_string_general (dn.unescaped_string_32) -- TODO: check if ok
					end
				end

				l_type := consumed_referenced_type (jo [names.declared_type])
				if attached {JSON_ARRAY} jo [names.arguments] as j_args then
					args := consumed_arguments (j_args)
				end
				if args = Void then
					create args.make (0)
				end
				if en /= Void and dn /= Void and l_type /= Void and args /= Void then
					if boolean_item (jo, names.is_attribute_setter) then
						check args.count = 1 end
						create Result.make_attribute_setter (
								en.unescaped_string_8, dn.unescaped_string_8,
								args.first,
								l_type,
								boolean_item (jo, names.is_static)
							)
					else
						if den = Void then
							create den.make_from_string_general (en.unescaped_string_32) -- TODO: check if ok
						end
						create Result.make (
								en.unescaped_string_8,
								dn.unescaped_string_8,
								den.unescaped_string_8,
								args.to_array,
								boolean_item (jo, names.is_frozen),
								boolean_item (jo, names.is_static),
								boolean_item (jo, names.is_deferred),
								boolean_item (jo, names.is_public),
								boolean_item (jo, names.is_new_slot),
								boolean_item (jo, names.is_virtual),
								boolean_item (jo, names.is_property_or_event),
								l_type
							)
					end
					update_consumed_member_from (Result, jo)
				else
					report_error ("Missing value for procedure")
				end
			end
		end

	consumed_constructor (j: detachable JSON_VALUE): detachable CONSUMED_CONSTRUCTOR
		local
			en: JSON_STRING
			l_type: CONSUMED_REFERENCED_TYPE
			args: ARRAYED_LIST [CONSUMED_ARGUMENT]
		do
			if attached {JSON_OBJECT} j as jo then
				en := jo.string_item (names.eiffel_name)
				l_type := consumed_referenced_type (jo [names.declared_type])
				if attached {JSON_ARRAY} jo [names.arguments] as j_args then
					args := consumed_arguments (j_args)
				end
				if args = Void then
					create args.make (0)
				end
				if en /= Void and l_type /= Void and args /= Void then
					create Result.make (
							en.unescaped_string_8,
							args.to_array,
							boolean_item (jo, names.is_public),
							l_type
						)
					update_consumed_entity_from (Result, jo)
				else
					report_error ("Missing value for constructor")
				end
			end
		end

	consumed_event (j: detachable JSON_VALUE): detachable CONSUMED_EVENT
		local
			dn: JSON_STRING
			decl_type: CONSUMED_REFERENCED_TYPE
		do
			if attached {JSON_OBJECT} j as jo then
				dn := jo.string_item (names.dotnet_name)
				decl_type := consumed_referenced_type (jo [names.declared_type])
				if dn /= Void and decl_type /= Void then
					create Result.make (
							dn.unescaped_string_8,
							boolean_item (jo, names.is_public),
							decl_type,
							consumed_procedure (jo [names.raiser]),
							consumed_procedure (jo [names.adder]),
							consumed_procedure (jo [names.remover])
						)
					update_consumed_entity_from (Result, jo)
				end
			end
		end

	consumed_field (j: detachable JSON_VALUE): detachable CONSUMED_FIELD
		local
			en, dn, val: JSON_STRING
			rt: CONSUMED_REFERENCED_TYPE
			l_type: CONSUMED_REFERENCED_TYPE
		do
			if attached {JSON_OBJECT} j as jo then
				en := jo.string_item (names.eiffel_name)
				dn := jo.string_item (names.dotnet_name)
				rt := consumed_referenced_type (jo [names.return_type])
				l_type := consumed_referenced_type (jo [names.declared_type])
				if en /= Void and dn /= Void and rt /= Void and l_type /= Void then
					if boolean_item (jo, names.is_literal) then
						val := jo.string_item (names.value)
						if val = Void then
							check has_value: False end
							report_error ("From-JSON: missing value.%N")
							val := "" -- default empty string.!!
						end
						create {CONSUMED_LITERAL_FIELD} Result.make (
								en.unescaped_string_8,
								dn.unescaped_string_8,
								rt,
								boolean_item (jo, names.is_static),
								boolean_item (jo, names.is_public),
								val.unescaped_string_8,
								l_type
							)
					else
						create Result.make (
								en.unescaped_string_8,
								dn.unescaped_string_8,
								rt,
								boolean_item (jo, names.is_static),
								boolean_item (jo, names.is_public),
								boolean_item (jo, names.is_init_only),
								l_type
							)
					end
					update_consumed_member_from (Result, jo)
					if attached consumed_procedure (jo [names.setter]) as l_setter then
						Result.set_setter (l_setter)
					end
				else
					report_error ("Missing or invalid value for field")
				end
			end
		end

	update_consumed_member_from (m: CONSUMED_MEMBER; jo: JSON_OBJECT)
		do
			update_consumed_entity_from (m, jo)
			if boolean_item (jo, names.is_artificially_added) then
				m.set_is_artificially_added (True)
			end
		end

	update_consumed_entity_from (e: CONSUMED_ENTITY; jo: JSON_OBJECT)
		do
			if boolean_item (jo, names.is_public) then
				e.set_is_public (True)
			end
		end

feature -- List

	consumed_properties (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_PROPERTY]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_property (j) as prop
				then
					Result.force (prop)
				else
					report_error ("Missing or invalid property")
				end
			end
		end

	consumed_constructors (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_constructor (j) as c
				then
					Result.force (c)
				else
					report_error ("Missing or invalid constructor")
				end
			end
		end

	consumed_arguments (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_ARGUMENT]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_argument (j) as arg
				then
					Result.force (arg)
				else
					report_error ("Missing or invalid argument")
				end
			end
		end

	consumed_procedures (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_PROCEDURE]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_procedure (j) as proc
				then
					Result.force (proc)
				else
					report_error ("Missing or invalid procedure")
				end
			end
		end

	consumed_functions (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_FUNCTION]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_function (j) as fct
				then
					Result.force (fct)
				else
					report_error ("Missing or invalid function")
				end
			end
		end

	consumed_events (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_EVENT]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_event (j) as evt
				then
					Result.force (evt)
				else
					report_error ("Missing or invalid event")
				end
			end
		end

	consumed_fields (jarr: JSON_ARRAY): detachable ARRAYED_LIST [CONSUMED_FIELD]
		do
			create Result.make (jarr.count)
			across
				jarr as j
			loop
				if
					attached consumed_field (j) as fld
				then
					Result.force (fld)
				else
					report_error ("Missing or invalid field")
				end
			end
		end

feature -- Helpers

	report_error (m: detachable READABLE_STRING_GENERAL)
		do
			has_error := True
			check False end
		end

	boolean_item (j: JSON_OBJECT; n: JSON_STRING): BOOLEAN
		do
			Result := attached j.boolean_item (n) as b and then b.item
		end

end
