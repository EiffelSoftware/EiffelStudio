indexing
	description:
		"Constructs whose specimens are obtained %
		%by concatenating specimens of constructs %
		%of zero or more specified constructs"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RB_AGGREGATE

inherit
	AGGREGATE
		redefine
			raise_syntax_error
		end

	ERROR_HANDLING
		undefine
			is_equal, copy
		end

	WEL_MESSAGE_BOX
		undefine
			is_equal, copy
		end

	WEL_MB_CONSTANTS	
		undefine
			is_equal, copy
		end

feature {NONE} -- Implementation

	raise_syntax_error (s: STRING) is
			-- Print error message s.
		local
			s2 : STRING
		do  
			if not has_error then
				set_has_error (true)

				!! s2.make (50)
				s2.append (" (line ")
				s2.append_integer (document.token.line_number)
				s2.append ("): ")

				s2.append (s)
				s2.append (" in ")
				s2.append (construct_name)
				if parent /= Void then
					s2.append (" in ") 
					s2.append (parent.construct_name)
				end

				error_message_box (s2, Mb_ok + Mb_iconstop)
			end
		end

end -- class RB_AGGREGATE
