note
	description: "Object that represents a result after parsing Language Headers."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_ACCEPT_LANGUAGE

inherit
	HTTP_HEADER_UTILITIES

	REFACTORING_HELPER

	DEBUG_OUTPUT

create
	make_from_string,
	make,
	make_with_language,
	make_default

feature {NONE} -- Initialization

	make_from_string (a_accept_language_item: READABLE_STRING_8)
			-- Instantiate Current from part of accept-language header, i.e language tag and parameters.
			--
			-- Languages-ranges are languages with specialization and a 'q' quality parameter.
			-- For example, the language l_range ('en-* ;q=0.5') would get parsed into:
			-- ('en', '*', {'q', '0.5'})
			-- In addition this also guarantees that there is a value for 'q'
			-- in the params dictionary, filling it in with a proper default if
			-- necessary.
		local
			i: INTEGER
			s: STRING
		do
			fixme (generator + ".make_from_string: improve code!!!")
			i := a_accept_language_item.index_of (';', 1)
			if i > 0 then
				create s.make_from_string (a_accept_language_item.substring (1, i - 1))
			else
				create s.make_from_string (a_accept_language_item)
			end
			s.left_adjust
			s.right_adjust
			make_with_language (s)
			if i > 0 then
				create parameters.make_from_substring (a_accept_language_item, i + 1, a_accept_language_item.count)
				check attached parameters as l_params and then not l_params.has_error end
			end

			check quality_initialized_to_1: quality = 1.0 end

				-- Get quality from parameter if any, and format the value as expected.
			if attached parameter ("q") as q then
				if q.same_string ("1") then
						--| Use 1.0 formatting
					put_parameter ("1.0", "q")
				elseif q.is_double and then attached q.to_real_64 as r then
					if r <= 0.0 then
						quality := 0.0 --| Should it be 1.0 ?
						put_parameter ("0.0", "q")
					elseif r >= 1.0 then
						quality := 1.0
						put_parameter ("1.0", "q")
					else
						quality := r
					end
				else
					put_parameter ("1.0", "q")
					quality := 1.0
				end
			else
				put_parameter ("1.0", "q")
			end
		end

	make_with_language (a_lang_tag: READABLE_STRING_8)
			-- Instantiate Current from language tag `a_lang_tag'.
		do
			initialize
			set_language_range (a_lang_tag)
		ensure
			language_range_set: language_range.same_string (a_lang_tag) and a_lang_tag /= language_range
		end

	make (a_root_lang: READABLE_STRING_8; a_specialization: detachable READABLE_STRING_8)
			-- Instantiate Current with `a_root_lang' and `a_specialization'.
		do
			initialize
			create language_range.make_empty
			language := a_root_lang
			specialization := a_specialization
			update_language_range (a_root_lang, a_specialization)
		end

	make_default
			-- Instantiate Current with default "*" language.
		do
			make ("*", Void)
		end

	initialize
			-- Initialize Current
		do
			create parameters.make (1)
			quality := 1.0
		end

feature -- Access

	language_range: STRING_8
			-- language-range  = ( ( 1*8ALPHA *( "-" 1*8ALPHA ) ) | "*" )

	language: READABLE_STRING_8
			-- First part of the language range, i.e the root language

	specialization: detachable READABLE_STRING_8
			-- Optional second part of the language range, i.e the dialect, or specialized language type

	quality: REAL_64
			-- Associated quality, by default 1.0

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (language_range)
			Result.append_character (';')
			Result.append ("q=")
			Result.append_double (quality)
		end

feature -- Element change

	set_language_range (a_lang_range: READABLE_STRING_8)
		local
			i: INTEGER
		do
			create language_range.make_from_string (a_lang_range)
			i := a_lang_range.index_of ('-', 1)
			if i > 0 then
				language := a_lang_range.substring (1, i - 1)
				specialization := a_lang_range.substring (i + 1, a_lang_range.count)
			else
				language := a_lang_range
			end
		ensure
			language_range_set: language_range.same_string (a_lang_range) and a_lang_range /= language_range
		end

	set_language (a_root_lang: READABLE_STRING_8)
			-- Set `'anguage' with `a_root_lang'
		require
			a_root_lang_attached: a_root_lang /= Void
		do
			language := a_root_lang
			update_language_range (a_root_lang, specialization)
		ensure
			type_assigned: language ~ a_root_lang
		end

	set_specialization (a_specialization: detachable READABLE_STRING_8)
			-- Set `specialization' with `a_specialization'
		do
			specialization := a_specialization
			update_language_range (language, a_specialization)
		ensure
			specialization_assigned: specialization ~ a_specialization
		end

feature -- Parameters: Access

	parameter (a_key: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Parameter associated with `a_key', if present
			-- otherwise default value of type `STRING'
		do
			if attached parameters as l_params then
				Result := l_params.item (a_key)
			end
		end

	parameters: detachable HTTP_PARAMETER_TABLE
			-- Table of all parameters for the media range

feature -- Parameters: Status report

	has_parameter (a_key: READABLE_STRING_8): BOOLEAN
			-- Is there an parameter in the parameters table with key `a_key'?
		do
			if attached parameters as l_params then
				Result := l_params.has_key (a_key)
			end
		end

feature -- Parameters: Change

	put_parameter (a_value: READABLE_STRING_8; a_key: READABLE_STRING_8)
			-- Insert `a_value' with `a_key' if there is no other item
			-- associated with the same key. If present, replace
			-- the old value with `a_value'
		local
			l_parameters: like parameters
		do
			l_parameters := parameters
			if l_parameters = Void then
				create l_parameters.make (1)
				parameters := l_parameters
			end
			l_parameters.force (a_value, a_key)
		ensure
			is_set: attached parameters as l_params and then (l_params.has_key (a_key) and l_params.has_item (a_value))
		end

feature {NONE} -- Implementation		

	update_language_range (a_lang: like language; a_specialization: like specialization)
			-- Update `language_range' with `a_lang' and `a_specialization'
		local
			l_language_range: like language_range
		do
			l_language_range := language_range -- Reuse same object, be careful not to keep reference on existing string at first.
			l_language_range.wipe_out
			l_language_range.append (a_lang)

			if a_specialization /= Void then
				l_language_range.append_character ('-')
				l_language_range.append (a_specialization)
			end
		end

invariant
	valid_quality: 0.0 <= quality and quality <= 1.0

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
