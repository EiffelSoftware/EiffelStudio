note
	description: "Summary description for {MD_TTY_BROWSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TTY_BROWSER

inherit
	MD_TEXT_PRINTER

create
	make

feature {NONE} -- Initialization

	make (lay: MD_CACHE_LAYOUT)
		do
			layout := lay
		end

feature -- Access

	layout: MD_CACHE_LAYOUT

feature {NONE} -- Implementation	

	deserializer: EIFFEL_DESERIALIZER
		once
			create {EIFFEL_JSON_DESERIALIZER} Result
		end

feature -- Access

--	last_assembly: detachable CONSUMED_ASSEMBLY

	exit
		do
			{EXCEPTIONS}.die (0);
		end

	answer: STRING_32
		do
			io.read_line
			Result := io.last_string
			Result.adjust
		end

feature -- Execution

	process (a_query: MD_QUERY)
		local
		do
			deserializer.deserialize (layout.cache_info_location.name, 0)
			if attached {CACHE_INFO} deserializer.deserialized_object as l_cache_info then
				process_cache_info (l_cache_info, a_query)
			end
		end

	process_cache_info (a_cache_info: CACHE_INFO; a_query: MD_QUERY)
		local
			rep: READABLE_STRING_GENERAL
			i: INTEGER
			lst: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			selection: CONSUMED_ASSEMBLY
			sub_entry: detachable READABLE_STRING_GENERAL
			l_ass_name: READABLE_STRING_GENERAL
		do
			i := 0
			if attached a_cache_info.assemblies as l_assemblies then
				if a_query.has_assembly_filter then
--					if
--						attached {CONSUMED_ASSEMBLY} first_matching_item (agent (a: ANY; e: READABLE_STRING_GENERAL): BOOLEAN
--							do
--								Result := attached {CONSUMED_ASSEMBLY} a as ca and then
--											e.starts_with (ca.name)
--							end(?, a_entry),
--							l_assemblies
--						) as sel
--					then
--						selection := sel
--					end
--					if selection /= Void then
--						l_ass_name := selection.name
--						if a_entry.count > l_ass_name.count then
--							sub_entry := a_entry.substring (l_ass_name.count, a_entry.count)
--						end
--					end

					across
						l_assemblies as ass
					until
						selection /= Void
					loop
						if a_query.assembly_included (ass) then
							selection := ass
						end
					end
				end
				if selection = Void then
					create lst.make (l_assemblies.count)
					across
						l_assemblies as ass
					loop
						i := i + 1
						lst.force (ass)
						io.put_integer (i)
						io.put_character ('.')
						io.put_character (' ')
						print_assembly_line (ass)
						io.put_new_line
					end
					rep := answer
					if rep.is_integer then
						i := rep.to_integer
						selection := lst.i_th (i)
					else
						across
							l_assemblies as ass
						until
							selection /= Void
						loop
							if ass.name.is_case_insensitive_equal_general (rep) then
								selection := ass
							end
						end
					end
				end
				if selection /= Void then
					process_assembly (selection, a_query)
				elseif rep = Void then
						-- Not found, ask?
					process_cache_info (a_cache_info, a_query)
				elseif rep.is_case_insensitive_equal ("..") then
					exit
				elseif rep.is_case_insensitive_equal ("q") then
					exit
				else
					process_cache_info (a_cache_info, a_query)
				end
			end
		end

	print_assembly_line (ass: CONSUMED_ASSEMBLY)
		do
			io.put_string (ass.name)
			io.put_character (':')
			io.put_character (' ')
			io.put_character ('"')
			io.put_string_32 (layout.relative_path (ass.location))
			io.put_character ('"')
		end

	index_of (cond: FUNCTION [ANY, BOOLEAN]; a_container: ITERABLE [ANY]): INTEGER
		local
			i: INTEGER
		do
			across
				a_container as item
			until
				Result > 0
			loop
				i := i + 1
				if cond (item) then
					Result := i
				end
			end
		end

	first_matching_item (cond: FUNCTION [ANY, BOOLEAN]; a_container: ITERABLE [ANY]): detachable ANY
		do
			across
				a_container as item
			until
				attached Result
			loop
				if cond (item) then
					Result := item
				end
			end
		end

	process_assembly (ass: CONSUMED_ASSEMBLY; a_query: MD_QUERY)
		local
			rep: like answer
--			ref_names: like last_assembly_references
			idx: INTEGER
			pos: INTEGER
			tn: READABLE_STRING_GENERAL
			sub_entry: READABLE_STRING_GENERAL
			i,n: INTEGER
			l_pos, aid: INTEGER
			en, dn: STRING
		do

			print_assembly_line (ass)
			io.put_new_line

--			process_cache_info (a_cache_info, Void)

--			ref_names := Void

--			deserializer.deserialize (layout.referenced_assemblies_location (ass).name, 0)
			pos := -1
			deserializer.deserialize (layout.types_location (ass).name, 0)
			if attached {CONSUMED_ASSEMBLY_TYPES} deserializer.deserialized_object as l_ass_types then
				if a_query.has_type_filter then
					idx := 0
					pos := -1
					across
						l_ass_types.dotnet_names as i_dn
					until
						pos >= 0
					loop
						dn := i_dn
						if dn /= Void and then a_query.type_name_included (dn) then
							pos := l_ass_types.positions [idx]
						end
						idx := idx + 1
					end
				end
				if pos < 0 then
					-- List choice ...!!!
					print ("Ask for a type ...%N")
					from
						i := 1
						n := l_ass_types.count
					until
						i > n
					loop
						l_pos := l_ass_types.positions [i - 1]
						aid := l_ass_types.assembly_ids [i - 1]
						en := l_ass_types.eiffel_names [i - 1]
						dn := l_ass_types.dotnet_names [i - 1]
						if en /= Void and dn /= Void then
							io.put_integer (i)
							io.put_character ('.')
							io.put_character (' ')
--							if aid > 0 then
--								io.put_string (" @ ")
--							else
--								io.put_string (" + ")
--							end
							io.put_string (dn)
							io.put_character (' ')
							io.put_character ('(')
							io.put_string (en)
							io.put_character (')')
							if aid > 0 then
								io.put_string (" -- from assembly #" + aid.out)
								if attached assembly_name (aid) as an then
									io.put_string (" '" + an + "'")
								end
							end
							io.put_new_line
						end
						i := i + 1
					end
					rep := answer
					if rep.is_integer then
						pos := l_ass_types.positions [rep.to_integer]
					else
						idx := 0
						pos := -1
						across
							l_ass_types.dotnet_names as i_dn
						until
							pos >= 0
						loop
							dn := i_dn
							if dn /= Void and then rep.same_string (dn) then
								pos := l_ass_types.positions [idx]
							end
							idx := idx + 1
						end
					end
				else
				end
				if pos >= 0 then
					deserializer.deserialize (layout.classes_location (ass).name, pos)
					if attached {CONSUMED_TYPE} deserializer.deserialized_object as t then
						process_type (t, a_query, ass)
					end
				end
			end
		end

	process_type (t: CONSUMED_TYPE; a_query: MD_QUERY; ass: CONSUMED_ASSEMBLY)
		local
			e: CONSUMED_ENTITY
			lst: ARRAYED_LIST [CONSUMED_ENTITY]
		do
			io.put_string (" - ")
			io.put_string (t.dotnet_name)
			io.put_character (' ')
			io.put_character ('(')
			io.put_string (t.eiffel_name)
			io.put_character (')')
			if t.assembly_id > 0 then
				io.put_string (" -- from assembly #" + t.assembly_id.out)
				if attached assembly_name (t.assembly_id) as an then
					io.put_string (" '" + an + "'")
				end
				io.put_new_line
			else
				io.put_new_line
				if a_query.has_entity_filter then
					if attached t.entities as t_entities and then not t_entities.is_empty then
						create lst.make (0)
						across
							t_entities as i_entity
						loop
							e := i_entity
							if a_query.entity_included (e) then
									-- Found entity
								lst.force (e)
							end
						end
					end
					if lst /= Void and then not lst.is_empty then
						io.put_string ("   > Found ")
						io.put_string (lst.count.out + " entitie(s)")
						io.put_new_line
						across
							lst as i_lst
						loop
							e := i_lst
							print ("    * ")
							display_entity (e, t, True)
							display_entity_details (e, t)
							io.put_new_line
						end
					end
				else
					if False then
						if not t.ancestors.is_empty then
							io.put_string ("   > ")
							io.put_string (t.ancestors.count.out + " ancestor(s)")
							io.put_new_line
							across
								t.ancestors as l_ancestor
							loop
								print ("    * ")
								process_referenced_type (l_ancestor)
								io.put_new_line
							end
						end
					else
						if attached t.parent as l_parent then
							io.put_string ("   > Parent: ")
							process_referenced_type (l_parent)
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
								process_referenced_type (i)
								io.put_new_line
							end
						end
					end

					if attached t.entities as t_entities and then not t_entities.is_empty then
						io.put_string ("   > ")
						io.put_string (t_entities.count.out + " entitie(s)")
						io.put_new_line
						across
							t_entities as e_item
						loop
							e := e_item
							print ("    * ")
							display_entity (e, t, True)
							display_entity_details (e, t)
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
		end

	process_referenced_type (rt: CONSUMED_REFERENCED_TYPE)
		do
			if rt.is_by_ref then
				io.put_character ('&')
			end
			io.put_string (rt.name)
			debug
				io.put_character (':')
				io.put_character (':')
				io.put_integer (rt.assembly_id)
			end
		end

end
