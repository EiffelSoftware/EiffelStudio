note
	description: "[
		Automated debug information added, otherwise same functionality as {XEL_FEATURE_ELEMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_DEBUG_FEATURE_ELEMENT

inherit
	XEL_FEATURE_ELEMENT
		redefine
			append_local,
			append_expression,
			append_expression_to_start,
			append_expression_to_end,
			append_require,
			append_ensure,
			append_expression_object,
			make
		end

create
	make

feature -- Initialization

	make (a_signature: STRING)
			-- <Precursor>
		do
			Precursor (a_signature)
			current_debug_information := "no debug information"
		end
		

feature {NONE} -- Access

	current_debug_information: STRING
			-- The current debug information of the expressions added.

feature -- Access

	set_debug_information (a_debug_info: STRING)
			-- Sets the debug information.
		require
			a_debug_info_attached: attached a_debug_info
		do
			current_debug_information := a_debug_info
		ensure
			debug_info_set: current_debug_information.is_equal (a_debug_info)
		end
	
	append_local (name, type: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (name, type)
		end
		
	append_expression (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end
		
	append_expression_to_start (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end
		
	append_expression_to_end (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end
		
	append_require (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end
		
	append_expression_object (a_expression: XEL_EXPRESSION)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end	
	
	append_ensure (a_expression: STRING)
			-- <Precursor>
		do
			append_comment (current_debug_information)
			Precursor (a_expression)
		end

end
