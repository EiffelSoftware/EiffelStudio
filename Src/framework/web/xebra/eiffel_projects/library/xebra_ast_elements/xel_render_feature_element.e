note
	description: "[
		{XEL_RENDER_FEATURE_ELEMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_RENDER_FEATURE_ELEMENT

inherit
	XEL_DEBUG_FEATURE_ELEMENT
		redefine
			serialize
		end

create
	make_with_const_class

feature -- Initialization

	make_with_const_class (a_name: STRING; a_class: XEL_CONSTANTS_CLASS_ELEMENT)
			-- `a_class': The class in which the the constants should be stored
		require
			a_class_attached: attached a_class
		do
			make (a_name)
			constants_class := a_class
		ensure
			class_set: constants_class = a_class
		end

feature -- Access

	constants_class: XEL_CONSTANTS_CLASS_ELEMENT
			-- The class in which the the constants should be stored

	append_output_text (a_text: STRING)
			-- Add `a_text' that should be outputed on the response (plain text/html)
		require
			a_text_valid: attached a_text and not a_text.is_empty
		do			
			append_expression_object (create {XEL_OUTPUT_TEXT_EXPRESSION}.make (a_text))
		ensure
			expression_added: content.count > old content.count
		end

	append_output_expression (a_expr: STRING)
			-- Add `a_expr' that returns a STRING to put on the response
		require
			a_expr_valid: attached a_expr and not a_expr.is_empty
		do
			append_expression_object (create {XEL_OUTPUT_EXPRESSION}.make (a_expr))
		ensure
			expression_added: content.count > old content.count
		end

	serialize (a_buf: XU_INDENDATION_FORMATTER)
			-- <Precursor>
		do
			externalize_strings
			Precursor (a_buf)
		end

feature -- Optimization

	externalize_strings
			-- Externalizes all magic strings to a constants class shared by all servlets
		local
			l_expr: STRING
		do
			from
				content.start
			until
				content.after
			loop
				if content.item.is_plain_string then
					l_expr := content.item.expr
					content.put (create {XEL_OUTPUT_EXPRESSION}.make
						("{" + {XEL_SERVLET_CLASS_ELEMENT}.Constants_class_name + "}." +
						constants_class.compute_var (l_expr)))
				end
				content.forth
			end
		end

end
