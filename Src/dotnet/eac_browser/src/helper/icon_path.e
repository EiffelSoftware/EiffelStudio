indexing
	description: "Path to access icon"
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	ICON_PATH

create
	default_create

feature -- Initialization

	Path_icon_eac: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_eac.ico"
			-- Path of eac icon.

	Path_icon_assembly: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_assembly.ico"
			-- Path of assembly icon.

	Path_icon_namespace: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_namespace.ico"
			-- Path of namespace icon.

	Path_icon_class: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_class_color.ico"
			-- Path of class icon.

	Path_icon_constructor: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_constructor.ico"
			-- Path of constructor icon.

	Path_icon_attribute: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_attribute_symbol.ico"
			-- Path of attribute icon.

	Path_icon_procedure: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_procedure.ico"
			-- Path of procedure icon.
			
	Path_icon_function: STRING is "D:\Src\dotnet\eac_browser\ressources\bitmaps\ico\icon_function.ico"
			-- Path of function icon.

end -- ICON_PATH