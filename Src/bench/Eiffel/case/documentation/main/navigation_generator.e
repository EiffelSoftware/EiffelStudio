indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAVIGATION_GENERATOR

creation
	make

feature -- Initialize

	make (gen: HTML_GENERATOR) is
		do
		--	format_generator := gen
		end

feature -- Actions


	generate_index ( dir_path: STRING) is
		local
			fi_n: FILE_NAME
			fi: PLAIN_TEXT_FILE
		do
				-- Copy the index file.
		--	Create fi_n.make_from_String("index.html")
		--	navigation_template.process_file("index.html")
		--	Create fi_n.make_from_string(dir_path)
		--	fi_n.extend("index.html")
		--	Create fi.make_create_read_write(fi_n)
		--	fi.put_string(navigation_template.result_string)
		--	fi.close	
--
	--			-- Process the navigation file.
	--		navigation_template.initialize("navigation_template")
			
		end

feature -- Implementation

	navigation_template: XML_DOCUMENTATION_READER is
		once
			Create Result.make
		end

end -- class NAVIGATION_GENERATOR
