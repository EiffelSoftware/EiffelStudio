note
	description: "Summary description for {MD_TEXT_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_TEXT_PRINTER

--feature -- Access

--	layout: MD_CACHE_LAYOUT
--		deferred
--		end

--feature {NONE} -- Implementation	

--	deserializer: EIFFEL_DESERIALIZER
--		deferred
--		end

feature -- Helpers

	assembly_name (aid: INTEGER): detachable STRING
		do
		end

feature -- Display

	display_type (t: CONSUMED_TYPE; a_query: MD_QUERY)
		local
			lst: ARRAYED_LIST [CONSUMED_ENTITY]
		do
			io.put_string (" - ")
			io.put_string (t.dotnet_name)
			io.put_character (' ')
			io.put_character ('(')
			io.put_string (t.eiffel_name)
			io.put_character (')')
			io.put_new_line
			if a_query.has_entity_filter then
				if attached t.entities as t_entities and then not t_entities.is_empty then
					create lst.make (0)
					across
						t_entities as e
					loop
						if a_query.entity_included (e) then
							lst.force (e)
						end
					end
					if not lst.is_empty then
						display_parents (t)
						io.put_string ("   > Found ")
						io.put_string (lst.count.out + " entitie(s)")
						io.put_new_line
						across
							lst as e
						loop
							print ("    * ")
							display_entity (e, t, True)
							if a_query.is_full_mode then
								display_entity_details (e, t)
							end
							io.put_new_line
						end
					end
				end
			else
				display_parents (t)
				if attached t.entities as t_entities and then not t_entities.is_empty then
					io.put_string ("   > ")
					io.put_string (t_entities.count.out + " entitie(s)")
					io.put_new_line
					across
						t_entities as e
					loop
						print ("    * ")
						display_entity (e, t, True)
						if a_query.is_full_mode then
							display_entity_details (e, t)
						end
						io.put_new_line
					end
				end
				if attached t.constructors as t_constructors then
					io.put_string ("   > ")
					io.put_string (t_constructors.count.out + " constructor(s)")
					io.put_new_line
					across
						t_constructors as c
					loop
						print ("    * ")
						display_entity (c, t, True)
						if a_query.is_full_mode then
							display_entity_details (c, t)
						end
						io.put_new_line
					end
				end

				io.put_string ("   >")
				if attached t.constructors as t_constructors then
					io.put_character (' ')
--					io.put_string ("   > ")
					io.put_string (t_constructors.count.out + " constructor(s)")
--					io.put_new_line
				end
				if attached t.fields as t_fields then
					io.put_character (' ')
--					io.put_string ("   > ")
					io.put_string (t_fields.count.out + " field(s)")
--					io.put_new_line
				end
				if attached t.procedures as t_procedures then
					io.put_character (' ')
--					io.put_string ("   > ")
					io.put_string (t_procedures.count.out + " procedure(s)")
--					io.put_new_line
				end
				if attached t.functions as t_functions then
					io.put_character (' ')
--					io.put_string ("   > ")
					io.put_string (t_functions.count.out + " function(s)")
--					io.put_new_line
				end
			end
			io.put_new_line
		end

	display_parents (t: CONSUMED_TYPE)
		do
			if False then
				if not t.ancestors.is_empty then
					io.put_string ("   > ")
					io.put_string (t.ancestors.count.out + " ancestor(s)")
					io.put_new_line
					across
						t.ancestors as l_ancestor
					loop
						print ("    * ")
						display_referenced_type (l_ancestor)
						io.put_new_line
					end
				end
			else
				if attached t.parent as l_parent then
					io.put_string ("   > Parent: ")
					display_referenced_type (l_parent)
					io.put_new_line
				end
				if attached t.interfaces as t_interfaces then
					io.put_string ("   > ")
					io.put_string (t_interfaces.count.out + " interface(s)")
					io.put_new_line
					across
						t_interfaces as i
					loop
						print ("    * ")
						display_referenced_type (i)
						io.put_new_line
					end
				end
			end
		end

	display_referenced_type (rt: CONSUMED_REFERENCED_TYPE)
		do
			if rt.is_by_ref then
				io.put_character ('&')
			end
			io.put_string (rt.name)
			if attached {CONSUMED_FORMAL_GENERIC_TYPE} rt as fgt then
				io.put_string ("/* " + fgt.formal_type_name + "*/")
			end
			debug
				io.put_character (':')
				io.put_character (':')
				io.put_integer (rt.assembly_id)
			end
		end

	display_entity (e: CONSUMED_ENTITY; t: CONSUMED_TYPE; a_include_associated_entity: BOOLEAN)
		local
			k: STRING
			n: INTEGER
		do
			k := e.generator.as_lower
			if k.starts_with ("consumed_") then
				k.remove_head (("consumed_").count)
			end
			io.put_string (k)
			if
				a_include_associated_entity and then
				attached {CONSUMED_PROCEDURE} e as proc and then
				attached proc.associated_entity as ae
			then
				io.put_character ('-')
				k := ae.generator.as_lower
				if k.starts_with ("consumed_") then
					k.remove_head (("consumed_").count)
				end
				io.put_string (k)
			end
			io.put_character (':')
			io.put_character (' ')
			io.put_string (e.dotnet_name)
			io.put_character (' ')
			io.put_character ('"')
			io.put_string (e.eiffel_name)
			io.put_character ('"')
			if
				attached {CONSUMED_PROCEDURE} e as proc and then
				proc.is_generic
			then
				io.put_character (' ')
				io.put_character ('<')
				io.put_character ('.')
				io.put_character ('.')
				io.put_character ('>')
			end
			if e.has_arguments then
				io.put_string (" (")
				if attached e.arguments as args then
					n := 0
					across
						args as a
					loop
						if n > 0 then
							io.put_character (',')
							io.put_character (' ')
						end
						display_referenced_type (a.type)
						n := n + 1
					end
				else
					io.put_string ("...")
				end
				io.put_string (")")
			end
			if attached e.return_type as rt then
				io.put_character (':')
				io.put_character (' ')
				display_referenced_type (rt)
			end

			if attached {CONSUMED_PROPERTY} e as prop then
				if attached prop.getter as g then
					io.put_new_line
					io.put_string ("    | GET ")
					display_entity (g, t, False)
				end
				if attached prop.setter as s then
					io.put_new_line
					io.put_string ("    | SET ")
					display_entity (s, t, False)
				end
			elseif attached {CONSUMED_EVENT} e as evt then
				if attached evt.raiser as r then
					io.put_new_line
					io.put_string ("    | RAISE  ")
					display_entity (r, t, False)
				end
				if attached evt.adder as a then
					io.put_new_line
					io.put_string ("    | ADD    ")
					display_entity (a, t, False)
				end
				if attached evt.remover as d then
					io.put_new_line
					io.put_string ("    | REMOVE ")
					display_entity (d, t, False)
				end
			end
		end

	display_entity_details (e: CONSUMED_ENTITY; t: CONSUMED_TYPE)
		local
			s: STRING
		do
			create s.make_empty
			if e.is_public then s.append ("public ") end
			if e.is_static then s.append ("static ") end
			if e.is_virtual then s.append ("virtual ") end
			if e.is_deferred then s.append ("deferred ") end
			if e.is_frozen then s.append ("frozen ") end

			if e.is_field then s.append ("field ") end
			if e.is_attribute then s.append ("attribute ") end
			if e.is_constant then s.append ("constant ") end
			if e.is_constructor then s.append ("constructor ") end
			if e.is_event then s.append ("event ") end
			if e.is_property then s.append ("property ") end

			if e.is_infix then s.append ("infix ") end
			if e.is_prefix then s.append ("prefix ") end
			if e.is_literal then s.append ("literal ") end

			if e.is_new_slot then s.append ("new-slot ") end
			if e.is_artificially_added then s.append ("artificially-added ") end
			if e.is_access_type then s.append ("access-type ") end
			if e.is_status_setting_type then s.append ("status-setting-type ") end
			if e.is_hidden_type then s.append ("hidden-type ") end
			if e.is_command_type then s.append ("command-type ") end
			if e.is_query_type then s.append ("query-type ") end

			io.put_string ("    %% ")
			io.put_string (s)
		end


end
