indexing

	description: "All resources used for EiffelCase."
	author: "pascalf"
	date: "$Date$";
	revision: "$Revision$"

class RESOURCES 

inherit

creation

	initialize

feature -- Access

	get_color(s: STRING): EV_COLOR is
		local
			s1: STRING
		do
			Result ?= resource_structure.table.get_value(s)
			if Result= Void then
				s1 := clone(s)
				s1.append(" : resource name has no associated value, default applied.")
				-- Warning, we apply the default.
			end
		end

	get_font(s: STRING): EV_FONT is
		local
			s1: STRING
		do
			Result ?= resource_structure.table.get_value(s)
			if Result= Void then
				s1 := clone(s)
				s1.append(" : resource name has no associated value, default applied.")
				-- Warning, we apply the default.
			end
		end

	get_array (s: STRING; da: ARRAY [STRING]): ARRAY [STRING] is
		do
			Result := resource_structure.table.get_array (s, da)
		end

	get_integer (s: STRING; di: INTEGER): INTEGER is
		do
			Result := resource_structure.table.get_integer (s, di)
		end

	get_boolean (s: STRING; db: BOOLEAN): BOOLEAN is
		do
			Result := resource_structure.table.get_boolean (s, db)
		end

	get_string (s: STRING; ds: STRING): STRING is
		do
			Result := resource_structure.table.get_string (s, ds)
		end

feature -- Setting

	set_integer(s: STRING; ni: INTEGER) is
		do
			resource_structure.table.set_integer (s, ni)
		end

	set_boolean(s: STRING; nb: BOOLEAN) is
		do
			resource_structure.table.set_boolean (s, nb)
		end

	set_string(s: STRING; ns: STRING) is
		do
			resource_structure.table.set_string (s, ns)
		end


feature -- save config

	save_config ( s : STRING ; new_name : STRING)	is
			-- command that save s 
			-- in the .ecr file
	do
	end

feature -- Access

	resource_structure: RESOURCE_STRUCTURE
		-- new storage structure.

feature {NONE,RETRIEVE_PROJECT} -- Creation & Re-initialization

	initialize is
			-- Resources specified by the user
		local
			file_name: FILE_NAME
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
		do	
			!! file_name.make_from_string("/home/bonnard/bench.xml")

			!! parser.make 
			!! file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				!! s.make(file.count)
				s.append (file.last_string)
				parser.parse_string(s)
				parser.set_end_of_file
				file.close		
			end
			!! resource_structure.make(parser)
			reinitialize
		end

feature {PREFERENCE_WINDOW}

		reinitialize is 
			do
			end
end 
