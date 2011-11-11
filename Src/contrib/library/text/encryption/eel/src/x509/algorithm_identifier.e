note
	description: "x509v3 AlgorithmIdentifier sequence"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "When you subsidize poverty and failure, you get more of both. - James Dale Davidson, National Taxpayers Union"

class
	ALGORITHM_IDENTIFIER

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature
	make (algorithm_a: OBJECT_IDENTIFIER parameters_a: ALGORITHM_PARAMETERS)
		do
			algorithm := algorithm_a
			parameters := parameters_a
		end

	is_equal (other: like Current): BOOLEAN
		do
			result := algorithm ~ other.algorithm and parameters ~ other.parameters
		ensure then
			algorithm ~ other.algorithm
			parameters ~ other.parameters
		end

feature
	algorithm: OBJECT_IDENTIFIER
	parameters: ALGORITHM_PARAMETERS
end
