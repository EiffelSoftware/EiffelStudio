note
	description: "[
				Options used by WSF_SERVICE_LAUNCHER
	
				For instance options supported by Standalone as default connector::
					port: numeric such as 8099 (or equivalent string as "8099")
					base: base_url (very specific to standalone server)
					verbose: to display verbose output, useful for Standalone
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SERVICE_LAUNCHER_OPTIONS

inherit
	TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]
		redefine
			default_create
		end

create
	default_create,
	make,
	make_from_array,
	make_from_iterable

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
			append_array_of_options (a_options)
		end

	make_from_iterable (a_options: TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL])
		do
			make
			append_options (a_options)
		end

feature -- Merging

	append_array_of_options (a_options: ARRAY [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]])
		do
			across
				a_options as opt
			loop
				if attached opt.item as o then
					set_option (o.name, o.value)
				end
			end
		end

	append_options (a_options: TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL])
		do
			across
				a_options as o
			loop
				set_option (o.key, o.item)
			end
		end

	import_ini_file_options (a_filename: READABLE_STRING_GENERAL)
			-- Import options from ini file `a_filename'.
		do
			append_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file (a_filename))
		end

feature -- Access

	option (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := options.item (a_name)
		end

feature -- Helpers

	has_option (a_opt_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is there any value associated to option name `a_opt_name'?
		do
			Result := attached option (a_opt_name)
		end

	has_integer_option (a_opt_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is there any INTEGER value associated to option name `a_opt_name'?
		local
			s: READABLE_STRING_GENERAL
		do
			if attached option (a_opt_name) as opt then
				if attached {INTEGER} opt as i then
					Result := True
				else
					s := opt.out
					Result := s.is_integer
				end
			end			
		end

	has_string_32_option (a_opt_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is there any string 32 value associated to option name `a_opt_name'?
		do
			if attached option (a_opt_name) as opt then
				Result := attached {READABLE_STRING_GENERAL} opt
			end			
		end

	option_string_32_value (a_opt_name: READABLE_STRING_GENERAL; a_default: detachable READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_32
			-- Unicode String value associated to option name `a_opt_name', other return `a_default'.
		do
			if attached option (a_opt_name) as opt then
				if attached {READABLE_STRING_32} opt as s32 then
					create Result.make_from_string (s32)
				elseif attached {READABLE_STRING_GENERAL} opt as s then
					create Result.make_from_string_general (s)
				end
			end			
			if Result = Void and a_default /= Void then
				create Result.make_from_string_general (a_default)
			end
		end
	
	option_integer_value (a_opt_name: READABLE_STRING_GENERAL; a_default: INTEGER): INTEGER
			-- INTEGER value associated to option name `a_opt_name', other return `a_default'.
		local
			s: READABLE_STRING_GENERAL
		do
			Result := a_default
			if attached option (a_opt_name) as opt then
				if attached {INTEGER} opt as i then
					Result := i
				else
					s := opt.out
					if s.is_integer then
						Result := s.to_integer
					end
				end
			end			
		end

	option_boolean_value (a_opt_name: READABLE_STRING_GENERAL; a_default: BOOLEAN): BOOLEAN
			-- BOOLEAN value associated to option name `a_opt_name', other return `a_default'.
		local
			s: READABLE_STRING_GENERAL
		do
			Result := a_default
			if attached option (a_opt_name) as opt then
				if attached {BOOLEAN} opt as b then
					Result := b
				else
					s := opt.out
					Result := s.is_case_insensitive_equal ("true") or s.is_case_insensitive_equal ("yes")
				end
			end			
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [detachable ANY, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := options.new_cursor
		end

feature -- Element change

	set_option (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
		do
			options.force (a_value, a_name)
		end

	unset_option (a_name: READABLE_STRING_GENERAL)
		do
			options.remove (a_name)
		end

	set_string_option (a_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL)
		do
			if a_value = Void then
				unset_option (a_name)
			else
				set_option (a_name, a_value)
			end
		end

	set_numeric_option (a_name: READABLE_STRING_GENERAL; a_value: NUMERIC)
		do
			set_option (a_name, a_value)
		end

	set_boolean_option (a_name: READABLE_STRING_GENERAL; a_value: BOOLEAN)
		do
			if a_value then
				set_option (a_name, "true")
			else
				set_option (a_name, "false")
			end
		end

	set_verbose (b: BOOLEAN)
			-- Set option "verbose" to `b'
		do
			set_option ("verbose", b)
		end

feature {NONE} -- Implementation

	options: STRING_TABLE [detachable ANY]
			-- Custom options which might be support (or not) by the default service

invariant
	options_attached: options /= Void
note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
