indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class CREATION_DATA

	inherit

		ONCES

		DATA


	creation
		make

	feature
		--creation

		make	( s : STRING	; c	: CLASS_DATA )	is
		do
			name	:= deep_clone	( s	)
			class_data	:= c
		end

	feature
		--inherited from DATA (implementation)

		focus	: STRING	is
		do
			Result	:= name
		end

		stone_type	: INTEGER	is
		do
			Result	:= stone_types.creation_type
		end


	feature
		--properties

		name	: STRING
	
		class_data	: CLASS_DATA

                header_comment: STRING

                clients: LINKED_LIST [STRING]

	feature
		--set

		set_name	( s : STRING )	is
		do

		--	if	class_data.new_creation_feature	( s	)
		--	then
		--		name	:= s
		--	end
		end

                add_creation (s: STRING) is
                        do
                                if name = Void then
                                        !! name.make (20)
				else
					name.append ("' ")
                                end

                                name.append (s)
                        end

                add_client (s: STRING) is
                        do
                                if clients = Void then
                                        !! clients.make
                                end

                                clients.extend (s)
                        end

                set_comment (s: STRING) is
                        do
                                header_comment := s
                        end

	feature
		--destroy

		destroy	is
		do
		
		end

	feature
		-- control

		has_name	( s : STRING )	: BOOLEAN	is
		do
			Result	:= name.is_equal	( s	)
	
		end

end -- class CREATION_DATA
