indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Pascal Freund and Christophe Bonnard"

class
	RESOURCE_STRUCTURE_IMP

inherit
	RESOURCE_STRUCTURE_I
		rename
			root_folder_i as root_folder_imp
		redefine
			root_folder_imp
		end

create
	make

feature -- Initialization

	make (in: like interface) is
		do
			interface := in
		end

	initialize (default_file: STRING) is
		local
			file_name: FILE_NAME
			environment: EXECUTION_ENVIRONMENT
		do
			make_default (default_file)
			create environment
			create file_name.make_from_string (environment.home_directory_name)
			file_name.set_file_name (".es4rc")
			if root_folder_imp /= Void then
				update_from_file_name (file_name)
			else
				make_from_file_name (file_name)
			end
		end

	make_from_file_name (file_name: FILE_NAME) is
				-- Initialize Current from file
				-- named `file_name'.
		local
			file: RAW_FILE
			s: STRING
			p: XML_TREE_PARSER
			error_message: STRING
		do
			location := file_name
			create table.make (100)
			create p.make
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				s := file.last_string
				p.parse_string (s)
				p.set_end_of_file
				file.close
				parser := p
				if not p.root_element.name.is_equal ("EIFFEL_DOCUMENT") then
					error_message := "EIFFEL_DOCUMENT TAG missing%N"
				else
					create root_folder_imp.make_root (parser.root_element, interface)
					root_folder_imp.create_interface
				end
			else
				error_message := "does not exist%N"
				error_message.prepend (location)
			end
			if error_message /= Void then
				io.put_string (error_message)
			end
		end

feature -- Update

	update_from_file_name (file_name: FILE_NAME) is
				-- Initialize Current from file
				-- named `file_name'.
		local
			file: RAW_FILE
			s: STRING
			p: XML_TREE_PARSER
			error_message: STRING
		do
			location := file_name
			create p.make
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				s := file.last_string
				p.parse_string (s)
				p.set_end_of_file
				file.close
				parser := p
				if not p.root_element.name.is_equal ("EIFFEL_DOCUMENT") then
					error_message := "EIFFEL_DOCUMENT TAG missing%N"
				else
					root_folder_imp.update_root (parser.root_element)
				end
			else
				error_message := "does not exist%N"
				error_message.prepend (location)
			end
			if error_message /= Void then
				io.put_string (error_message)
			end
		end

feature -- Access

	root_folder_imp: RESOURCE_FOLDER_IMP

feature -- Saving

	save is
		local
			file: RAW_FILE
			s: STRING
			l: LINKED_LIST [RESOURCE_FOLDER_IMP]
		do
			create file.make_open_write (location)
			if file.exists then
				s := "<EIFFEL_DOCUMENT>%N"
				from
					l := root_folder_imp.child_list
					l.start
				until
					l.after
				loop
					s.append (l.item.xml_trace (""))
					l.forth
				end
				s.append ("</EIFFEL_DOCUMENT>%N")
				file.put_string (s)
				file.close
			end
		end

	save_resource (r: RESOURCE) is
		do
			save
		end

feature -- Status report

	location: FILE_NAME

end -- class RESOURCE_STRUCTURE_IMP
