note
	description: "Text fragment based on a buffer"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BUFFER_BASED_TEXT_FRAGMENT

inherit
	EB_TEXT_FRAGMENT

create
	make

feature{NONE} -- Initialization

	make (a_text: like text; a_new_text_function: like new_text_function; a_text_validity_function: like text_validity_function; a_buffer: like buffer)
			-- Initialize `text' with `a_text', `new_text_function' with `a_new_text_function',
			-- `text_validity_function' with `a_text_validity_function' and `buffer' with `a_buffer'.
		require
			a_text_attached: a_text /= Void
			a_new_text_function_attached: a_new_text_function /= Void
			a_text_valid: (text_validity_function /= Void implies text_validity_function.item ([a_text])) and (text_validity_function = Void implies is_text_valid (a_text))
			a_buffer_attached: a_buffer /= Void
		do
			set_text_validity_function (a_text_validity_function)
			set_text (a_text)
			set_buffer (a_buffer)
			set_new_text_function (a_new_text_function)
		end

feature -- Access

	new_text: like text
			-- New text which will replace `text'
		do
			if new_text_function /= Void then
				Result := new_text_function.item ([buffer.temp_file_name.name])
			else
				Result := buffer.temp_file_name.name
			end
		ensure then
			good_result:
				new_text_function /= Void implies Result.is_equal (new_text_function.item ([buffer.temp_file_name.name])) and then
				new_text_function = Void implies Result.is_equal (buffer.temp_file_name.name)
		end

	buffer: EB_BUFFER
			-- Buffer attached to Current fragment

	new_text_function: FUNCTION [TUPLE [a_text: READABLE_STRING_GENERAL], like new_text]
			-- Function to return result for `new_text'
			-- When called, `text' will be passed as argument.

feature -- Status report

	is_replacement_prepared: BOOLEAN
			-- Is replacement prepared?
		do
			Result := buffer.is_initialized
		ensure then
			good_result: Result = buffer.is_initialized
		end

feature -- Setting

	set_text (a_text: like text)
			-- Set `text' with `a_text'
		require
			a_text_attached: a_text /= Void
			a_text_valid: is_text_valid (a_text)
		do
			text := a_text.twin
			set_normalized_text_internal (Void)
		ensure
			text_est: text /= Void and then text.is_equal (a_text)
			normalized_text_internal_set: normalized_text_internal = Void
		end

	set_buffer (a_buffer: like buffer)
			-- Set `buffer' with `a_buffer'.
		require
			a_buffer_attached: a_buffer /= Void
		do
			buffer := a_buffer
		ensure
			buffer_set: buffer = a_buffer
		end

	set_new_text_function (a_func: like new_text_function)
			-- Set `new_text_function' with `a_func'.
		do
			new_text_function := a_func
		ensure
			new_text_function_set: new_text_function = a_func
		end

	prepare_before_replacement
			-- Prepare replacement.
		do
			buffer.initialize
		ensure then
			buffer_initialized: buffer.is_initialized
		end

	dispose_after_replacement
			-- Dispose after replacement
		do
			buffer.dispose
		ensure then
			buffer_disposed: not buffer.is_initialized
		end

invariant
	buffer_attached: buffer /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
