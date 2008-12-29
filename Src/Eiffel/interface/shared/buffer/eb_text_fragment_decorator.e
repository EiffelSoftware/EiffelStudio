note
	description: "Decorator of text fragment"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_FRAGMENT_DECORATOR

inherit
	EB_TEXT_FRAGMENT
		redefine
			normalized_text,
			is_text_valid
		end

create
	make

feature{NONE} -- Initialization

	make (a_text: like text; a_text_fragment: like text_fragment)
			-- Initialized `text' with `a_text' and `text_fragment' with `a_text_fragment'.
		require
			a_text_attached: a_text /= Void
			a_text_fragment_attached: a_text_fragment /= Void
		do
			set_text (a_text)
			set_text_fragment (a_text_fragment)
		end

feature -- Access

	normalized_text: like text
			-- Normalized representation of `text'.
			-- For example, all letters are in lower case, heading and trailing space removed.
		do
			if normalized_text_internal /= Void then
				if text_fragment.normalized_text_function /= Void then
					set_normalized_text_internal (text_fragment.normalized_text_function.item ([text]))
				else
					set_normalized_text_internal (text)
				end
			end
			Result := normalized_text_internal
		end

	new_text: like text
			-- New text which will replace `text'
		do
			Result := text_fragment.new_text
		ensure then
			good_result: Result = text_fragment.new_text
		end

	text_fragment: EB_TEXT_FRAGMENT
			-- Text fragment to be decorated

feature -- Status report

	is_text_valid (a_text: like text): BOOLEAN
			-- Is `a_text' valid to be put into current replacer?
			-- Always return True because we assume that the text fragement `text_fragment' being decorated is valid.
		do
			Result := True
		end

	is_replacement_prepared: BOOLEAN
			-- Is replacement prepared?
		do
			Result := text_fragment.is_replacement_prepared
		ensure then
			good_result: Result = text_fragment.is_replacement_prepared
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

	set_text_fragment (a_text_fragment: like text_fragment)
			-- Set `text_fragment' with `a_text_fragment'.
		require
			a_text_fragment_attached: a_text_fragment /= Void
		do
			text_fragment := a_text_fragment
		ensure
			text_fragment_set: text_fragment = a_text_fragment
		end

	prepare_before_replacement
			-- Prepare replacement.
		do
			text_fragment.prepare_before_replacement
		end

	dispose_after_replacement
			-- Dispose after replacement
		do
			text_fragment.dispose_after_replacement
		end

invariant
	text_fragment_attached: text_fragment /= Void

end
