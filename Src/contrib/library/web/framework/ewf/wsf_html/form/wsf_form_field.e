note
	description: "Summary description for {WSF_FORM_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FORM_FIELD

inherit
	WSF_FORM_ITEM

	WSF_WITH_CSS_ID

	DEBUG_OUTPUT

feature -- Access

	name: READABLE_STRING_8

	label: detachable READABLE_STRING_8

	description: detachable READABLE_STRING_8

	is_required: BOOLEAN

	is_invalid: BOOLEAN

	is_readonly: BOOLEAN

	is_description_collapsible: BOOLEAN

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name + " {" + generator + "}"
		end

feature -- Validation		

	validation_action: detachable PROCEDURE [WSF_FORM_DATA]
			-- Function returning True if valid, otherwise False

	validate (fd: WSF_FORM_DATA)
		do
			if attached validation_action as act then
				act.call ([fd])
			end
		end

feature -- Element change

	update_name (a_name: like name)
		require
			name.is_empty
		do
			name := a_name
		end

	set_is_required (b: BOOLEAN)
		do
			is_required := b
		end

	set_is_readonly (b: BOOLEAN)
		do
			is_readonly := b
		end

	set_label (lab: like label)
		do
			label := lab
		end

	set_description (t: like description)
		do
			description := t
		end

	set_validation_action (act: like validation_action)
		do
			validation_action := act
		end

	set_is_invalid (b: BOOLEAN)
		do
			is_invalid := b
		end

	set_value (v: detachable WSF_VALUE)
			-- Set value `v' if applicable to Current
		deferred
		end

	set_description_collapsible (b: BOOLEAN)
			-- Set `is_description_collapsible' to `b'
		do
			is_description_collapsible := b
		end

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		local
			l_class_items: detachable ARRAYED_LIST [READABLE_STRING_8]
		do
			create l_class_items.make (2)
			if is_required then
				l_class_items.extend ("required")
			end
			if is_invalid then
				l_class_items.extend ("error")
			end
			if l_class_items.is_empty then
				l_class_items := Void
			end

			a_html.append ("<div")
			append_css_class_to (a_html, l_class_items)
			a_html.append_character ('>')
			if attached label as lab then
				a_html.append ("<strong><label for=%"" + name + "%">" + lab + "</label></strong>")
				if is_required then
					a_html.append (" (<em>required</em>)")
				end
				a_html.append ("<br/>%N")
			end
			append_item_to_html (a_theme, a_html)
			if attached description as desc then
				if is_description_collapsible then
					a_html.append ("<div class=%"description collapsible%"><div>Description ...</div><div>" + desc + "</div></div>")
				else
					a_html.append ("<div class=%"description%">" + desc + "</div>")
				end
			end
			a_html.append ("</div>")
		end

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		deferred
		end


end
