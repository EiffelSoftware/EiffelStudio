indexing
	description: "Non Optimized XML Parser"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	PARSER_XML

creation
	make

feature -- Properties

	file_name: FILE_NAME
		-- file_name is parsed

feature -- Result

	field_root: XML_FIELD
		-- Result structure

feature -- Creation

	make is
		-- Creation
		do
			!! file_name.make	
			!! file_string.make (0)
			!! field_root.make (field_root_name)
			!! error_message.make (0)
			initialization
		end;

	parse is
		-- Action
		local
			end_parsing: INTEGER
		do
			!! file.make (file_name)

			if file.exists then
				file.open_read
			
				initialization
				file_to_string
				end_parsing := parsing (field_root, 1)
				file.close			
			else
				error := 1
			end
		end

feature -- Settings

	set_file_name (f: FILE_NAME) is
		-- set the file_name for the parsing
		do
			file_name := f
		end

feature -- Output	

	result_string : STRING is
		-- Build an indented string
		do
			!! Result.make (0)
			print_field (field_root, 0, Result)
		end

feature -- flag

	error: INTEGER
		-- flag set if an error occured
		-- O if no errors occured

	error_message: STRING

feature {NONE} -- Implementation

	initialization is
		do
			file_string.wipe_out
			field_root.make (field_root_name)
			error := 0
			error_message.wipe_out
		end

	file: RAW_FILE

	file_string: STRING

	file_to_string is
		require
			file_exists: file.exists
		do
			!! file_string.make (0)
			if file.exists then 
				file.read_stream (file.count)
				file_string.append (file.last_string)
			else	
				error := 1
			end
		end

	parsing (parent: XML_FIELD; i: INTEGER): INTEGER is
		require
			file_string_not_void: file_string /= Void
		local
			index : INTEGER

			field_end: BOOLEAN

			name_begin: INTEGER
			name_end: INTEGER
			name: STRING

			xml_string: XML_STRING
			field: XML_FIELD
			s: STRING
		do
			--io.new_line
			--io.put_integer (i)
			if parent /= Void then
				if file_string /= Void then
					if i <= file_string.count then
						index := i
						from
							field_end := false
						until
							field_end or error /= 0
						loop
							name_begin := file_string.index_of ('<', index)
							if name_begin /= 0 then
								name_end := file_string.index_of ('>', name_begin)
								if name_end /= 0 then
									if name_begin /= index then
										s :=file_string.substring (index, name_begin - 1)
										s.prune_all('%R')
										s.prune_all('%T')
										s.prune_all('%N')
										if not s.empty then
											!! xml_string.make (s)
											parent.add_heir (clone (xml_string))
										end
									end
									name := file_string.substring (name_begin + 1, name_end - 1) 				
									
									if name /= Void then
										if name.item(1) = '/' then
											if begin_end (parent.name, name) then
												field_end := true
											else
												error := 1
												error_message := "Error in Field : "
												error_message.append (parent.name)
											end								
										else
											!! field.make (name)
											index := parsing (field, name_end + 1)
											parent.add_heir (clone (field) )
										end
									end
								end
							else
								if not parent_name_root (parent.name) then
									error := 1
									error_message := "Error in Field : "
									error_message.append (parent.name)						
								else
									!! xml_string.make (file_string.substring (index, file_string.count) )
									parent.add_heir (clone (xml_string))
									field_end := true
									name_end := file_string.count
								end
							end
						end
						if error = 0 then
							Result := name_end + 1
						end
					else
						if not parent_name_root (parent.name) then
							error := 1
							error_message := "Error in Field : "
							error_message.append (parent.name)						
						else
							Result := file_string.count
						end
					end
				else
					error := 1
				end
			else
				error := 1
			end
		end
	
	begin_end (d: STRING; f: STRING): BOOLEAN is
		do
			if d /= Void and f /= Void then
				if d.is_equal (f.substring (2,f.count) ) then
					Result := true
				else
					Result := false
				end
			else
				error := 1
			end
		end

	parent_name_root (s: STRING) : BOOLEAN is
		do
			if s /= Void then
				Result := s.is_equal (field_root_name)
			else
				error := 1
			end
		end

	field_root_name: STRING is "Field_root"

	print_field (f: XML_COMPOSITE; i: INTEGER; s: STRING) is
		local
			indentation : STRING	
		
			field: XML_FIELD
			xml_string: XML_STRING
	
			heir: LINKED_LIST [XML_COMPOSITE]
		do
			!! indentation.make (i)
			indentation.fill_blank
			
			s.append (indentation)
		
			field ?= f
			if field /= Void then
				s.append (field.name)
				s.append_character ('%N')

				heir := field.heir
				
				from
					heir.start
				until
					heir.after
				loop
					print_field (heir.item, i + 8, s)
	
					heir.forth
				end	
			else
				xml_string ?= f
				if xml_string /= Void then
					s.append (xml_string.value)
					s.append_character ('%N')

				else
					error := 1
				end
			end
		end


end -- class PARSER_XML
