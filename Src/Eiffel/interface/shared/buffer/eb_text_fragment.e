indexing
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

	text_count: INTEGER is
			-- Length of `text'
		do
			Result := text.count
		ensure
			good_result: Result = text.count
		end

	location: INTEGER
			-- The start position of `text' in original text

	new_text: like text is
			-- New text which will replace `text'
		require
			prepared: is_replacement_prepared
		deferred
		ensure
			good_result: Result /= Void
		end

	normalized_text: like text is
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

	is_text_valid (a_text: like text): BOOLEAN is
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

	is_replacement_prepared: BOOLEAN is
			-- Is replacement prepared?
		deferred
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := location < other.location
		end

feature -- Setting

	set_location (a_location: INTEGER) is
			-- Set `location' with `a_location'.
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_normalized_text_function (a_func: like normalized_text_function) is
			-- Set `normalized_text_function' with `a_func'.
		do
			normalized_text_function := a_func
		ensure
			normalized_text_function_set: normalized_text_function = a_func
		end

	set_text_validity_function (a_func: like text_validity_function) is
			-- Set `text_validity_function' with `a_func'.
		do
			text_validity_function := a_func
		ensure
			text_validity_function_set: text_validity_function = a_func
		end

	prepare_before_replacement is
			-- Prepare replacement.
		require
			not_prepared: not is_replacement_prepared
		deferred
		ensure
			prepared: is_replacement_prepared
		end

	safe_prepare_before_replacement is
			-- If not `is_replacement_prepared', invoke `prepare_before_replacement',
			-- otherwise, do nothing.
		do
			if not is_replacement_prepared then
				prepare_before_replacement
			end
		ensure
			prepared: is_replacement_prepared
		end

	dispose_after_replacement is
			-- Dispose after replacement
		require
			prepared: is_replacement_prepared
		deferred
		ensure
			not_prepared: not is_replacement_prepared
		end

	safe_dispose_after_replacement is
			-- If `is_replacement_prepared', invoke `dispose_after_replacement',
			-- otherwise, do nothing.
		do
			if is_replacement_prepared then
				dispose_after_replacement
			end
		ensure
			not_prepared: not is_replacement_prepared
		end

	set_data (a_data: like data) is
			-- Set `data' with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature{NONE} -- Implementation

	normalized_text_internal: like normalized_text
			-- Implementation of `normalized_text'

	set_normalized_text_internal (a_text: like normalized_text_internal) is
			-- Set `normalized_text_internal' with `a_text'.
		do
			normalized_text_internal := a_text
		ensure
			normalized_text_internal_set: normalized_text_internal = a_text
		end

invariant
	text_attached: text /= Void
	text_valid: is_text_valid (text)

end
