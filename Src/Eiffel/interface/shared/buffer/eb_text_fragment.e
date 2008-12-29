note
	description: "Text fragment. A text fragment can be replaced by another string"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TEXT_FRAGMENT

inherit
	COMPARABLE

feature -- Access

	text: STRING
			-- Text to be replaced

	text_count: INTEGER
			-- Length of `text'
		do
			Result := text.count
		ensure
			good_result: Result = text.count
		end

	location: INTEGER
			-- The start position of `text' in original text

	new_text: like text
			-- New text which will replace `text'
		require
			prepared: is_replacement_prepared
		deferred
		ensure
			good_result: Result /= Void
		end

	normalized_text: like text
			-- Normalized representation of `text'.
			-- For example, all letters are in lower case, heading and trailing space removed.
		do
			if normalized_text_internal = Void then
				if normalized_text_function /= Void then
					set_normalized_text_internal (normalized_text_function.item ([text]))
				else
					set_normalized_text_internal (text)
				end
			end
			Result := normalized_text_internal
		ensure
			result_attached: Result /= Void
		end

	normalized_text_function: FUNCTION [ANY, TUPLE [a_text: like text], like normalized_text]
			-- Function to return normalized representation of `a_text'

	text_validity_function: FUNCTION [ANY, TUPLE [a_text: like text], BOOLEAN]
			-- Function to test if `a_text' is valid for current replacer
			-- If set, `is_text_valid' will return the return valid of this function,
			-- otherwise, the original result from `is_text_valid' is used.

	data: ANY
			-- Some user-defined data

feature -- Status report

	is_text_valid (a_text: like text): BOOLEAN
			-- Is `a_text' valid to be put into current replacer?
		require
			a_text_attached: a_text /= Void
		do
			if text_validity_function /= Void then
				Result := text_validity_function.item ([a_text])
			else
				Result := True
			end
		ensure then
			good_result:
				(text_validity_function /= Void implies Result = text_validity_function.item ([a_text])) and
				(text_validity_function = Void implies Result)
		end

	is_replacement_prepared: BOOLEAN
			-- Is replacement prepared?
		deferred
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := location < other.location
		end

feature -- Setting

	set_location (a_location: INTEGER)
			-- Set `location' with `a_location'.
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_normalized_text_function (a_func: like normalized_text_function)
			-- Set `normalized_text_function' with `a_func'.
		do
			normalized_text_function := a_func
		ensure
			normalized_text_function_set: normalized_text_function = a_func
		end

	set_text_validity_function (a_func: like text_validity_function)
			-- Set `text_validity_function' with `a_func'.
		do
			text_validity_function := a_func
		ensure
			text_validity_function_set: text_validity_function = a_func
		end

	prepare_before_replacement
			-- Prepare replacement.
		require
			not_prepared: not is_replacement_prepared
		deferred
		ensure
			prepared: is_replacement_prepared
		end

	safe_prepare_before_replacement
			-- If not `is_replacement_prepared', invoke `prepare_before_replacement',
			-- otherwise, do nothing.
		do
			if not is_replacement_prepared then
				prepare_before_replacement
			end
		ensure
			prepared: is_replacement_prepared
		end

	dispose_after_replacement
			-- Dispose after replacement
		require
			prepared: is_replacement_prepared
		deferred
		ensure
			not_prepared: not is_replacement_prepared
		end

	safe_dispose_after_replacement
			-- If `is_replacement_prepared', invoke `dispose_after_replacement',
			-- otherwise, do nothing.
		do
			if is_replacement_prepared then
				dispose_after_replacement
			end
		ensure
			not_prepared: not is_replacement_prepared
		end

	set_data (a_data: like data)
			-- Set `data' with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature{NONE} -- Implementation

	normalized_text_internal: like normalized_text
			-- Implementation of `normalized_text'

	set_normalized_text_internal (a_text: like normalized_text_internal)
			-- Set `normalized_text_internal' with `a_text'.
		do
			normalized_text_internal := a_text
		ensure
			normalized_text_internal_set: normalized_text_internal = a_text
		end

invariant
	text_attached: text /= Void
	text_valid: is_text_valid (text)

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
