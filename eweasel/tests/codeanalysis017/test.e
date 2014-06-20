note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			io.put_string ("Foo")
		end
	
	-- This rule should be insensitive to case and whitespace in the feature clause comments.
	-- The order of the exports should also not matter.
	
feature -- Public
	
	feature_1: INTEGER
	
	feature_2: INTEGER

feature --          public
	
	feature_3: INTEGER
	
feature --       PuBlIc   

feature -- Different section
	
feature {ARGUMENTS, TEST} -- Restricted
	
	feature_4: INTEGER

feature {TEST, ARGUMENTS} --     restricted

feature {TEST, ARGUMENTS} -- Different section

feature {  TEST,  ARGUMENTS } --Restricted
	
	feature_5: INTEGER
	
end
