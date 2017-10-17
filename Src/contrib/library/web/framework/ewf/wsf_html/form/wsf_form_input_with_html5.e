note
	description: "Represent the improvement HTML5 brings to web forms"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=HTML5 forms", "src=https://html.spec.whatwg.org/multipage/forms.html#forms"

deferred class
	WSF_FORM_INPUT_WITH_HTML5

inherit

	SHARED_HTML_ENCODER

feature -- Access

	placeholder: detachable READABLE_STRING_32
			-- short hint intended to aid the user with data entry when the control has no value.
			--	EIS:"name=placeholder", "src=https://html.spec.whatwg.org/multipage/forms.html#attr-input-placeholder

	autofocus: BOOLEAN
			-- moves the input focus to a particular input field.

	autocomplete: BOOLEAN
			-- helps users complete forms based on earlier input.
			-- The default state is set to on.
			-- call set_autocomplete to turn it off.

	required: BOOLEAN
			-- The browser requires the user to enter data into that field before submitting the form.

	pattern: detachable READABLE_STRING_32
			-- specifies a JavaScript regular expression for the field’s value to be checked against.
			-- pattern makes it easy for us to implement specific validation for product codes, invoice numbers, and so on.
			--! This pattern is not validated, at the moment.

feature -- Change element

	set_placeholder (a_placeholder: detachable READABLE_STRING_GENERAL)
			-- Set `placeholder' with `a_placeholder'.
		do
			if a_placeholder = Void then
				placeholder := Void
			else
				placeholder := a_placeholder.as_string_32
			end
		ensure
			placeholder_set: (a_placeholder = Void implies placeholder = Void)
				or (a_placeholder /= Void implies (attached placeholder as l_placeholder and then a_placeholder.same_string (l_placeholder)))
		end

	enable_autofocus
			-- Set autofocus in True.
		do
			autofocus := True
		ensure
			autofocus_true: autofocus
		end

	disable_autofocus
			-- Set autofocus in False
		do
			autofocus := False
		ensure
			autofocus_false: not autofocus
		end

	disable_autocomplete
			-- Turn off the autocomplete. The default behavior is on.
		do
			autocomplete := True
		ensure
			autocomplete_true: autocomplete
		end

	enable_autocomplete
			-- Set autocomplete in False, Set default behavior.
		do
			autocomplete := False
		ensure
			autocomplete_false: not autocomplete
		end

	enable_required
			-- Set required to True.
		do
			required := True
		ensure
			required_true: required
		end

	disable_required
			-- Set rquired to False.
		do
			required := False
		ensure
			required_flase: not required
		end

	set_pattern (a_pattern: READABLE_STRING_GENERAL)
			-- Set `pattern' with `a_pattern'.
			-- Example:[0-9][A-Z]{3}
			-- Check HTML5 patterns site.
		note
			EIS: "name=HTML5 Patterns", "src=http://html5pattern.com/"
		do
			if a_pattern = Void then
				pattern := Void
			else
				pattern := a_pattern.as_string_32
			end
		ensure
			pattern_set: (a_pattern = Void implies pattern = Void) or
				a_pattern /= Void implies attached pattern as l_pattern and then a_pattern.same_string (l_pattern)
		end


		-- The attribues `form',`list', and `multiple' are not supported yet.
		-- For example the list attribute need datalist support.

		-- list: detachable READABLE_STRING_32
		-- The list attribute enables the user to associate a list of options with a particular field.
		-- The value of the list attribute must be the same as the ID of a datalist element that resides in the same document.
		-- The datalist element is new in HTML5 and represents a predefined list of options for form controls.
		--
		-- Example
		--
		-- <label>Your favorite fruit:
		-- <datalist id="fruits">
		--  <option value="Blackberry">Blackberry</option>
		--  <option value="Blackcurrant">Blackcurrant</option>
		--  <option value="Blueberry">Blueberry</option>
		--  <!-- … -->
		-- </datalist>
		-- If other, please specify:
		--  <input type="text" name="fruit" list="fruits">
		-- </label>

		--	multiple: BOOLEAN
		--We can take our lists and datalists one step further by applying the Boolean attribute multiple to allow more than one value to be entered from the datalist.
		-- Here is an example.
		--<label>Your favorite fruit:
		--<datalist id="fruits">
		--  <select name="fruits">
		--    <option value="Blackberry">Blackberry</option>
		--    <option value="Blackcurrant">Blackcurrant</option>
		--    <option value="Blueberry">Blueberry</option>
		--    <!-- … -->
		--  </select>
		--If other, please specify:
		--</datalist>
		--  <input type="text" name="fruit" list="fruits" multiple>
		--</label>

feature -- Conversion

	append_html5_input_attributes_to (a_theme: WSF_THEME; a_target: STRING)
			-- Append html5 attributes to target `a_target'.
			--!Note: Several new HTML5 form attributes are Boolean attributes.
			--This just means they’re set if they’re present and not set if they’re absent. They can be written several ways in HTML5.
			--autofocus
			--autofocus=""
			--autofocus="autofocus"
			--However, if you are writing XHTML5, you have to use the autofocus="autofocus" style.
		do
			if attached placeholder as l_placeholder then
				a_target.append (" placeholder=%"")
				a_target.append (html_encoder.encoded_string (l_placeholder))
				a_target.append_character ('%"')
			end
				--TODO check how we can add xhtml5 support
				-- if a_theme.has_xhtml5_support then
				--  ....
			if autofocus then
				a_target.append (" autofocus")
			end
			if autocomplete then
				a_target.append (" autocomplete=%"")
				a_target.append ("off")
				a_target.append_character ('%"')
			end
			if required then
				a_target.append (" required")
			end
			if attached pattern as l_pattern then
				a_target.append (" pattern=%"")
				a_target.append ( html_encoder.encoded_string (l_pattern))
				a_target.append_character ('%"')
			end
		end

end
