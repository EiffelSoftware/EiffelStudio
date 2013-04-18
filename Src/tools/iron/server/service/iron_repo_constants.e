note
	description: "Summary description for {IRON_REPO_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_CONSTANTS

feature -- Access

	major: INTEGER = 0
	minor: INTEGER = 1
	built: STRING = "0005"

	version: STRING
		do
			Result := major.out + "." + minor.out + "." + built
		end

feature -- Access

	iron_repo_variable_name: STRING = "IRON_REPO"

end
