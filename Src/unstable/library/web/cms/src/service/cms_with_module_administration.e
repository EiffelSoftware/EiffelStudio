note
	description: "Interface providing administration module."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_WITH_MODULE_ADMINISTRATION

feature -- Administration

	module_administration: like administration
			-- Associated administration module.
		do
			Result := internal_module_administration
			if Result = Void then
				Result := administration
				internal_module_administration := Result
			end
		end

feature {NONE} -- Implementation

	internal_module_administration: detachable like module_administration
			-- Cached version of `module_administration`.

feature {NONE} -- Administration

	administration: CMS_MODULE_ADMINISTRATION [CMS_MODULE]
			-- Administration module.
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
