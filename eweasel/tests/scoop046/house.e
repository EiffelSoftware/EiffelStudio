note
	description: "Mock object for a house."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	HOUSE

feature -- Status report

	has_foundation: BOOLEAN
	has_walls: BOOLEAN
	has_roof: BOOLEAN

	is_finished: BOOLEAN
		do
			Result := has_foundation and has_walls and has_roof
		end

feature -- Basic operations

	build_foundation
		do
			has_foundation := True
		end

	build_walls
		require
			has_foundation
		do
			has_walls := False
			(create {DEVELOPER_EXCEPTION}).raise
		end

	build_roof
		require
			has_walls
		do
			has_roof := True
		end

end
