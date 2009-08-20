note
	description: "[
		Calendar with javascript.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_CALENDAR_TAG

inherit
	XTAG_F_WRAPPABLE_CONTROL_TAG
		redefine
			make,
			internal_put_attribute
		end

create
	make

feature -- Initialization

	make
		do
			Precursor
			create {XTaG_TAG_VALUE_ARGUMENT} date.make_default
		end

feature {NONE} -- Access

	date: XTAG_TAG_ARGUMENT
			-- The date represented by the calendar
	
	label: detachable XTAG_TAG_ARGUMENT
			-- An optional label

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			Precursor (a_id, a_attribute)
			if a_id.is_equal ("date") then
				date := a_attribute
			end
			if a_id.is_equal ("label") then
				label := a_attribute
			end
		end

	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- <Precursor>
		local
			l_cal_name: STRING
		do
			if attached label as l_label then
				a_servlet_class.render_html_page.append_expression (response_variable_append +
				"(%"<label for=%%%"" + a_name + "%%%">" +  l_label.value (current_controller_id) + "</label>%")")
			end
			l_cal_name := a_servlet_class.render_html_page.new_uid
			a_servlet_class.render_html_page.append_expression (response_variable_append +
			"(%"<script language=%%%"javascript1.2%%%" type=%%%"text/javascript%%%" >%")"
			)
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"<!--%%N%")")
			a_servlet_class.render_html_page.append_expression (response_variable_append +
				"(%"var " + l_cal_name + " = new CodeThatCalendar(caldef1);%")")
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"%%N//-->%")")

			a_servlet_class.render_html_page.append_expression (response_variable_append +
			"(%"</script>%")"
			)

			a_servlet_class.render_html_page.append_expression (response_variable_append +
				"(%"<input type=%%%"text%%%" name=%%%"" + a_name + "%%%" value=%%%"" + date.value (current_controller_id) + "%%%"/>%")")
			a_servlet_class.render_html_page.append_expression (response_variable_append +
			"(%"<input type=%%%"button%%%"" +
			" onclick=%%%"" + l_cal_name + ".popup('" + a_name + "');%%%"" +
			" value=%%%"select%%%" />%")"
			)
		end

	transform_to_correct_type (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_name, a_argument_name: STRING): STRING
			-- <Precursor>
		local
			l_date_time: STRING
		do
			l_date_time := a_servlet_class.fill_bean.new_local ("DATE")
			Result := "create " + l_date_time + ".make_now%N"
			Result := Result +  "if " + l_date_time + ".date_valid (" + a_argument_name + ", %"[0]mm/[0]dd/yyyy%") then%N"
			Result := Result + "create " + l_date_time + ".make_from_string (" + a_argument_name + ", %"[0]mm/[0]dd/yyyy%")%N%T"
			Result := Result + a_variable_name + " := " + l_date_time + "%N"
			Result := Result + "end"
		end

end
