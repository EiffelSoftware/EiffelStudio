indexing
	description: "Provide global functionality to all objects."
	author: "pascalf"

class
	FACILITIES

feature -- Access

	structure: E_DOCUMENT is 
			-- The help topic tree.
		do
			Result := onces.main_structure
		end

	main_window: VIEWER_WINDOW is
		do
			Result := onces.main_window
		end

	set_main_window(vw:VIEWER_WINDOW) is
		do
			onces.set_main_window(vw)
		end

	set_main_structure(ms:E_DOCUMENT) is
		do
			onces.set_main_structure(ms)
		end

	warning(title, message:STRING; par:EV_CONTAINER) is
		local
			win: EV_WARNING_DIALOG
		do
			!! win.make_with_text(par, title, message)
			win.show
		end

	is_xml_file(fn: STRING):BOOLEAN is
		local
			s: STRING
		do
			s := clone(fn)
			s.tail(4)
			s.to_upper
			Result := s.is_equal(".XML")
		end

feature {NONE}

	onces: ONCES is
		once
			!! Result
		end

end -- class FACILITIES
