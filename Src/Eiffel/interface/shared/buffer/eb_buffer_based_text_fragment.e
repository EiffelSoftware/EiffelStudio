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
				Result := new_text_function.item ([buffer.temp_file_name])
			else
				Result := buffer.temp_file_name.twin
			end
		ensure then
			good_result:
				new_text_function /= Void implies Result.is_equal (new_text_function.item ([buffer.temp_file_name])) and then
				new_text_function = Void implies Result.is_equal (buffer.temp_file_name)
		end

	buffer: EB_BUFFER
			-- Buffer attached to Current fragment

	new_text_function: FUNCTION [ANY, TUPLE [a_text: like text], like new_text]
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

end
