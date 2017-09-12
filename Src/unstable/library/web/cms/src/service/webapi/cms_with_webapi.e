note
	description: "Interface providing webapi module."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_WITH_WEBAPI

feature -- Webapi

	module_webapi: like webapi
			-- Associated web api module.
		do
			Result := internal_module_webapi
			if Result = Void then
				Result := webapi
				internal_module_webapi := Result
			end
		end

feature {NONE} -- Implementation

	internal_module_webapi: detachable like module_webapi
			-- Cached version of `module_webapi`.

feature {NONE} -- Web API

	webapi: CMS_MODULE_WEBAPI [CMS_MODULE]
			-- Web API module.
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
