note
	description: "Summary description for {MD_TEXT_EXPORTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TEXT_EXPORTER

inherit
	MD_TEXT_PRINTER
		redefine
			assembly_name
		end

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

feature -- Execution

	process (a_query: MD_QUERY)
		do
			deserializer.deserialize (layout.cache_info_location.name, 0)
			if attached {CACHE_INFO} deserializer.deserialized_object as l_cache_info then
				display_cache_info (l_cache_info, a_query)
			end
		end

	display_cache_info (a_cache_info: CACHE_INFO; a_query: MD_QUERY)
		do
			across
				a_cache_info.assemblies as ass
			loop
				if
					not a_query.has_assembly_filter
					or else a_query.assembly_included (ass)
				then
					display_assembly (ass, a_query)
				end
			end
		end

	last_assembly_references: detachable ARRAYED_LIST [STRING]
			-- Assembly name index by id.

	assembly_name (i: INTEGER): detachable STRING
		do
			if attached last_assembly_references as arr then
				Result := arr.i_th (i)
			end
		end

	display_assembly (ass: CONSUMED_ASSEMBLY; a_query: MD_QUERY)
		local
			i: INTEGER
			ref_names: like last_assembly_references
		do
			io.put_character ('#')
			io.put_character (' ')
			print (ass.name)
			io.put_character (':')
			io.put_character (' ')
			io.put_string_32 (ass.folder_name)
			io.put_new_line
			io.put_character (' ')
			io.put_character ('"')
			io.put_string_32 (layout.relative_path (ass.location))
			io.put_character ('"')
			io.put_new_line

			ref_names := Void

			deserializer.deserialize (layout.referenced_assemblies_location (ass).name, 0)
			if not a_query.has_type_filter then
				if attached {CONSUMED_ASSEMBLY_MAPPING} deserializer.deserialized_object as l_ref_assemblies then
					io.put_character (' ')
					io.put_character ('#')
					io.put_character ('#')
					io.put_character (' ')
					io.put_integer (l_ref_assemblies.assemblies.count)
					io.put_string_32 (" referenced assemblies:")
					io.put_new_line
					create ref_names.make (l_ref_assemblies.assemblies.count)
					last_assembly_references := ref_names
					i := 0
					across
						l_ref_assemblies.assemblies as ref
					loop
						ref_names.extend (ref.name)

						io.put_character (' ')
						io.put_character (' ')
						i := i + 1
						io.put_integer (i)
						io.put_character (')')
						io.put_character (' ')
						io.put_string_32 (ref.name)
						io.put_character (':')
						io.put_character (' ')
						io.put_character ('"')
						io.put_string_32 (ref.location.name)
						io.put_character ('"')
						io.put_new_line
					end
	--					display_assembly_types (ass, l_types)
				end
			end

			deserializer.deserialize (layout.types_location (ass).name, 0)
			if attached {CONSUMED_ASSEMBLY_TYPES} deserializer.deserialized_object as l_types then
				if not a_query.has_type_filter then
					io.put_character (' ')
					io.put_character ('#')
					io.put_character ('#')
					io.put_character (' ')
					io.put_integer (l_types.count)
					io.put_string_32 (" types:")
					io.put_new_line
				end
				display_assembly_types (ass, l_types, a_query)
			end
		end

	display_assembly_types (ass: CONSUMED_ASSEMBLY; a_types: CONSUMED_ASSEMBLY_TYPES; a_query: MD_QUERY)
		local
			i,n, ignored_nb: INTEGER
			l_pos, aid: INTEGER
			en, dn: STRING
			inc: BOOLEAN
		do
			from
				i := 1
				n := a_types.count
			until
				i > n
			loop
				dn := a_types.dotnet_names [i]
				l_pos := a_types.positions [i]
				aid := a_types.assembly_ids [i]
				if dn = Void then
					ignored_nb := ignored_nb + 1
					inc := False
				elseif a_query.has_type_filter then
					inc := a_query.type_name_included (dn) and aid = 0
				else
					inc := True
				end
				if inc then
					deserializer.deserialize (layout.classes_location (ass).name, l_pos)
					if attached {CONSUMED_TYPE} deserializer.deserialized_object as t then
						display_type (t, a_query)
					else
						en := a_types.eiffel_names [i]
						if en /= Void and dn /= Void then
							if aid > 0 then
								io.put_string (" @ ")
							else
								io.put_string (" + ")
							end
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
						else
							check False end
						end
					end
				end
				i := i + 1
			end
		end

end
