note
	description: "An exception when an {INTEGER_X} doesn't have a modular inverse"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Whenever they burn books they will also, in the end, burn human beings. -  Heinrich Heine (1797-1856), Almansor: A Tragedy, 1823"

class
	INVERSE_EXCEPTION

inherit
	DEVELOPER_EXCEPTION
		redefine
			internal_meaning
		end

feature
	internal_meaning: STRING = "No modular inverse"
end
