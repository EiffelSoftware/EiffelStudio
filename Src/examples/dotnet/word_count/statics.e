indexing
	description: "Useful statics"
	external_name: "ISE.Examples.WordCount.Statics"

class
	STATICS

feature -- Statics

	console: SYSTEM_CONSOLE
		indexing
			description: "Console"
			external_name: "Console"
		end
	
	string: STRING
		indexing
			description: "String"
			external_name: "String"
		end
	
	No_error: INTEGER is unique
		indexing
			description: "No error"
			external_name: "NoError"
		end
	
	Error: INTEGER is unique
		indexing
			description: "Error"
			external_name: "Error"
		end
		
	Show_usage: INTEGER is unique
		indexing
			description: "Show usage."
			external_name: "ShowUsage"
		end
		
	array: SYSTEM_ARRAY
		indexing
			description: "Static needed to access arrays"
			external_name: "Array"
		end
		
	file: SYSTEM_IO_FILE
		indexing
			description: "Static needed to access files"
			external_name: "File"
		end
		
	encoding: SYSTEM_TEXT_ENCODING
		indexing
			description: "Encoding"
			external_name: "Encoding"
		end
		
	environment: SYSTEM_ENVIRONMENT
		indexing
			description: "Execution environment"
			external_name: "Environment"
		end
		
end -- class STATICS	