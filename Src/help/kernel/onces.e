indexing
	description: "To provide global access to main window."
	author: "pascalf"

class
	ONCES
	
feature -- State Setting

	set_main_window(vw: VIEWER_WINDOW) is
		do
			main_window := vw
		end

	set_main_structure(ms: E_DOCUMENT) is
		do
			main_structure := ms
		end

feature -- Access

	main_window: VIEWER_WINDOW 

	main_structure: E_DOCUMENT

end -- class ONCES
