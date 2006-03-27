indexing
	description: "Representation of an assembly."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_I

inherit
	CONF_ASSEMBLY
		redefine
			class_type
		end

feature -- Access

	full_name: STRING is
			-- Output name of Current
		do
			create Result.make (64)
			Result.append (name)
			if assembly_version /= Void then
				Result.append (", Version=")
				Result.append (assembly_version)
			end
			if assembly_culture /= Void then
				Result.append (", Culture=")
				Result.append (assembly_culture)
			else
				Result.append (", Culture=neutral")
			end
			if assembly_public_key_token /= Void then
				Result.append (", PublicKeyToken=")
				Result.append (assembly_public_key_token)
			end
		ensure
			full_name_not_void: Result /= Void
		end

feature -- Output

	format (a_text_formatter: TEXT_FORMATTER) is
			-- Output name of Current in `a_text_formatter'.
		require
			st_not_void: a_text_formatter /= Void
		do
			a_text_formatter.add_string (assembly_name)
			if assembly_version /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (assembly_version)
			end
			if assembly_culture /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (assembly_culture)
			end
			if assembly_public_key_token /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (assembly_public_key_token)
			end
		end

feature {NONE} -- Class type anchor

	class_type: EXTERNAL_CLASS_I
end
