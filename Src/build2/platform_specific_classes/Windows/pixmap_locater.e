indexing
	description: "Objects that query the registry to return %
		%the location to the pixmap files when launched by VisualStudio. %
		%This is the windows version, the Gtk version does nothing, as it %
		%will never be executed, but must be in the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAP_LOCATER

feature -- Access

	pixmap_path: STRING is
			--
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
		do
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\7.0\Setup\Eiffel", feature {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
			if p /= default_pointer then
				key := reg.key_value (p, "ProductDir")
				reg.close_key (p)
			end
			if key /= Void then
				Result := key.string_value
			end
		end
		
end -- class PIXMAP_LOCATER
