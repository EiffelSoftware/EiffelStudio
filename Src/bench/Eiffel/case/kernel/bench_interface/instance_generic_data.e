indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class INSTANCE_GENERIC_DATA

	inherit
		ONCES

		DATA


	creation
		make


	feature
		--creation

		make	( g : GENERIC_DATA ; i : RELATION_DATA )	is
		do
			generic_data	:= g
			relation_data	:= i				
		end

	feature
		--from DATA

		focus	: STRING	is
		do
			Result	:= generic_data.name
		end

		stone_type	:INTEGER	is
		do
			Result	:= Stone_types.string_type
		end


	feature
		--properties

		generic_data	: GENERIC_DATA	
		relation_data	: RELATION_DATA

end -- class INSTANCE_GENERIC_DATA
