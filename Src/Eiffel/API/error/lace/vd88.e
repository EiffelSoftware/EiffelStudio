note
	description: "Error when a class depends on the other one with lower void-safety requirements."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VD88

inherit
	EIFFEL_ERROR
		redefine
			build_explain,
			error_string,
			print_single_line_error_message,
			trace
		end

	WARNING
		undefine
			has_associated_file
		redefine
			error_string
		end

	CONF_INTERFACE_CONSTANTS

create
	make_error,
	make_warning

feature {NONE} -- Creation

	make_error (c: CLASS_I; location: LOCATION_AS; context: CLASS_C)
			-- Create an error object for less void-safe class `c' at `location' in class `context'.
		require
			c_attached: attached c
			location_attached: attached location
			context_attached: attached context
		do
			class_c := context
			set_location (location)
			provider := c
		ensure
			is_error: not is_warning
		end

	make_warning (c: CLASS_I; location: LOCATION_AS; context: CLASS_C)
			-- Create a warning object for less void-safe class `c' at `location' in class `context'.
		require
			c_attached: attached c
			location_attached: attached location
			context_attached: attached context
		do
			make_error (c, location, context)
			is_warning := True
		ensure
			is_warning: is_warning
		end

feature -- Properties

	code: STRING = "VD88"
			-- Error code

	provider: CLASS_I
			-- Class on which `class_c' relies

	is_warning: BOOLEAN
			-- Is it a warning?

	error_string: STRING
			-- <Precursor>
		do
			if is_warning then
				Result := Precursor {WARNING}
			else
				Result := Precursor {EIFFEL_ERROR}
			end
		end

feature -- Output

	trace (f: TEXT_FORMATTER)
			-- <Precursor>
		do
			Precursor (f)
			if line > 0 then
				print_context_of_error (class_c, f)
			end
		end

	build_explain (f: TEXT_FORMATTER)
			-- Build specific explanation explain for current error in `f'.
		do
			f.add (conf_interface_names.option_void_safety_name)
			f.add (": ")
			f.add (conf_interface_names.option_void_safety_value [class_c.lace_class.options.void_safety.index])
			f.add_new_line
			f.add ("Configuration: ")
			f.add (class_c.lace_class.group.target.system.file_name)
			f.add_new_line
			f.add ("Provider class: ")
			provider.append_name (f)
			f.add_new_line
			f.add ("Provider option: ")
			f.add (conf_interface_names.option_void_safety_name)
			f.add (": ")
			f.add (conf_interface_names.option_void_safety_value [provider.options.void_safety.index])
			f.add_new_line
			f.add ("Provider configuration: ")
			f.add (provider.group.target.system.file_name)
			f.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (f: TEXT_FORMATTER)
			-- Displays single line help in `f'.
		do
			Precursor (f)
			f.add_space
			f.add ("Provider class: ")
			provider.append_name (f)
			f.add (".")
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
