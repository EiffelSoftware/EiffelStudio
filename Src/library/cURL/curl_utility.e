note
	description: "[
					Utilities for Eiffel cURL wrapper library.
																		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_UTILITY

feature -- Query

--	api_loader: DYNAMIC_MODULE
--			-- API dynamic loader
--		local
--			l_platform: PLATFORM
--		once
--			create l_platform
--			if l_platform.is_unix or l_platform.is_mac then
--				create Result.make_with_version (module_name, "4")
--				if not Result.is_interface_usable then
--					Result.unload
--					create Result.make_with_version (module_name, "3")
--				end
--			else
--				check is_window: l_platform.is_windows end
--				create Result.make (module_name)
--			end
--		ensure
--			not_void: Result /= Void
--		end

	 api_loader: MODULE_LOADER
            -- API dynamic loader
        local
            l_platform: PLATFORM
        once
            if is_static then
            	create {STATIC_MODULE} Result
            else
                create l_platform
                if l_platform.is_unix or l_platform.is_mac then
                    create {DYNAMIC_MODULE} Result.make_with_version (module_name, "4")
                    if not Result.is_interface_usable then
                        Result.unload
                        create {DYNAMIC_MODULE} Result.make_with_version (module_name, "3")
                    end
                else
                    check is_window: l_platform.is_windows end
                    create {DYNAMIC_MODULE} Result.make (module_name)
                end
            end
        ensure
            not_void: Result /= Void
        end

	module_name: STRING
			-- Module name.
		once
				Result := "libcurl"
		ensure
			not_void: Result /= Void
		end

	is_static: BOOLEAN
			-- Is CURL_STATICLIB defined?
		do
			Result := 1 = c_is_static
		end

feature {NONE} -- C externals

	c_is_static: INTEGER
			-- Return 1 if CURL_STATICLIB is defined, 0 in other case.
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return 1;
				#else
					return 0;
				#endif
			]"
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
