note
	description: "[
				Options used by WSF_SERVICE_LAUNCHER
	
				For instance options supported by Nino as default connector::
					port: numeric such as 8099 (or equivalent string as "8099")
					base: base_url (very specific to standalone server)
					force_single_threaded: use only one thread, useful for Nino
					verbose: to display verbose output, useful for Nino
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SERVICE_LAUNCHER_OPTIONS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make,
	make_from_array

convert
	make_from_array ({ARRAY [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]]})

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create options.make (0)
		end

	make
		do
			default_create
		end

	make_from_array (a_options: ARRAY [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]])
		do
			make
			across
				a_options as opt
			loop
				if attached opt.item as o then
					set_option (o.name, o.value)
				end
			end
		end

feature -- Access

	option (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := options.item (a_name)
		end

feature -- Element change

	set_option (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
		do
			options.force (a_value, a_name)
		end

	set_verbose (b: BOOLEAN)
			-- Set option "verbose" to `b'
		do
			set_option ("verbose", b)
		end

feature {NONE} -- Implementation

	options: HASH_TABLE [detachable ANY, READABLE_STRING_GENERAL]
			-- Custom options which might be support (or not) by the default service

invariant
	options_attached: options /= Void
note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
