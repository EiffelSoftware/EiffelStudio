indexing
	description:
		"Constructs whose specimens are specimens of constructs %
		%chosen among a specified list."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RB_CHOICE

inherit
	CHOICE
		redefine
			raise_syntax_error
		end

	ERROR_HANDLING
		
	WEL_MESSAGE_BOX

	WEL_MB_CONSTANTS	

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

				error_message_box (s2, Mb_ok + Mb_iconstop )
			end
		end

end -- class CHOICE
