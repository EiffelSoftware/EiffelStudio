indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.UserPreferenceChangedEventArgs"

external class
	MICROSOFT_WIN32_USERPREFERENCECHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_userpreferencechangedeventargs

feature {NONE} -- Initialization

	frozen make_userpreferencechangedeventargs (category: MICROSOFT_WIN32_USERPREFERENCECATEGORY) is
		external
			"IL creator signature (Microsoft.Win32.UserPreferenceCategory) use Microsoft.Win32.UserPreferenceChangedEventArgs"
		end

feature -- Access

	frozen get_category: MICROSOFT_WIN32_USERPREFERENCECATEGORY is
		external
			"IL signature (): Microsoft.Win32.UserPreferenceCategory use Microsoft.Win32.UserPreferenceChangedEventArgs"
		alias
			"get_Category"
		end

end -- class MICROSOFT_WIN32_USERPREFERENCECHANGEDEVENTARGS
