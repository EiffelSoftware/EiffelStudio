indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class STRING_DATA

	inherit
		ONCES

		DATA


	creation
		make


	feature
		--creation

		make	( s : STRING )	is
		do
			string	:= s				
		end

	feature
		--from DATA

		focus	: STRING	is
		do
			Result	:= string
		end

		stone_type	:INTEGER	is
		do
			Result	:= Stone_types.string_type
		end


	feature
		--properties

		string	: STRING	

	feature
		--settings

		set_string	( s : STRING )	is
		do

			if	s	/= void	and then
				not s.empty
			then
				string.wipe_out
				string.append	( s	)
			end
		end	
	

end -- class STRING_DATA
