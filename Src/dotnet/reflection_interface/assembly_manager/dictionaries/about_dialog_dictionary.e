indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.AboutDialogDictionary"

class
	ABOUT_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access

	Company_name: STRING is "Interactive Software Engineering, Inc."
		indexing
			description: "Company name"
			external_name: "CompanyName"
		end

	Dotnet_web_address: STRING is "http://dotnetexperts.com"
		indexing
			description: ".NET experts Web address"
			external_name: "DotnetWebAddress"
		end
		
	Fax: STRING is "Fax.: (805)685-6869"
		indexing
			description: "Company fax"
			external_name: "Fax"
		end
		
	Image_filename: STRING is 
		indexing
			description: "Image on the left side of the dialog"
			external_name: "ImageFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Image_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Powered_by_eiffel_sharp: STRING is "Powered by Eiffel#"
		indexing
			description: "Powered by Eiffel#"
			external_name: "PoweredByEiffelSharp"
		end
		
	Product_name: STRING is "ISE Assembly Manager (Version 1.0.0)"
		indexing
			description: "Product name"
			external_name: "ProductName"
		end
		
	Street: STRING is "360 Storke Road"
		indexing
			description: "Company address: the street"
			external_name: "Street"
		end

	Telephone: STRING is "Tel.: (805)685-1006"
		indexing
			description: "Company telephone"
			external_name: "Telephone"
		end
		
	Town: STRING is "Goleta, CA 93117, USA."
		indexing
			description: "Company address: the town"
			external_name: "Town"
		end
		
	Web_address: STRING is "http://eiffel.com"
		indexing
			description: "ISE Web address"
			external_name: "WebAddress"
		end
		
	Title: STRING is "About ISE Assembly Manager"
		indexing
			description: "Title"
			external_name: "Title"
		end
		
	White_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "White color"
			external_name: "WhiteColor"
		once
			Result := Result.get_White	
		end
		
	Window_height: INTEGER is 250
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end
		
	Window_width: INTEGER is 500
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end

feature {NONE} -- Implementation

	Image_relative_filename: STRING is "\Eiffel_tower.png"
		indexing
			description: "Image on the left side of the dialog"
			external_name: "ImageRelativeFilename"
		end
		
end -- class ABOUT_DIALOG_DICTIONARY
