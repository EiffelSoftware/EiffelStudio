indexing
	description: "Spell checker wrapper."
	date: "$Date$"
	revision: "$Revision$"

class
	SPELL_CHECKER	


feature -- Basic Operations

	spell_check_documents (docs: ARRAYED_LIST [DOCUMENT]) is
			-- Spell check all `docs'
		do			
		end		

	spell_check (a_filename: STRING) is
			-- Spell check `a_text'
		require
			file_not_void: a_filename /= Void	
		do			
		end


end -- class SPELL_CHECKER
