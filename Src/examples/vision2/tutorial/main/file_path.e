indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_PATHS

feature {NONE}

	main_path : STRING is
			-- root directory for all tutorial files
		do
			Result := "c:/Eiffel45/examples/vision2/tutorial/"
		end

	library_path : STRING is
			-- directory of all vision2 library short-form interfaces
		do
		--	Result := "c:/Eiffel45/library/vision2/short_forms/"
			Result := "c:/Eiffel45/examples/vision2/tutorial/shortform/"
		end


	example_path: STRING 
			-- path of example class text
	
	docs_path: STRING 
			-- path of documentation text

	class_path: STRING 
			-- path of class file text


	set_example_path(fn: STRING) is
			-- sets example path string
		do
			!!example_path.make(0)
			example_path.append(main_path)
			example_path.append(fn)
		end

	set_docs_path(fn: STRING) is
			-- sets example path string
		do
			!!docs_path.make(0)
			docs_path.append(main_path)
			docs_path.append(fn)
			
		end

	set_class_path(fn: STRING) is
			-- sets example path string
		do
			!!class_path.make(0)
			class_path.append(library_path)
			class_path.append(fn)
			class_path.append(".txt")
		end

end -- class FILE_PATH
