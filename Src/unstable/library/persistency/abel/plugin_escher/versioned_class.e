note
	description: "Models a version of a class. Every class interested in versioning support is supposed to inherit from this class."
	author: "Teseo Schneider, Marco Piccioni"
	date: "07.04.2009"

deferred class
	VERSIONED_CLASS

feature

	version: INTEGER
			-- The class version.
		deferred
		ensure
			version_is_positive: Result > 0
		end

end
