indexing
	description: "Property for msil key files, that allow to choose an existing file or if an non existing file is choosen it will be created."
	date: "$Date$"
	revision: "$Revision$"

class
	KEY_FILE_PROPERTY

inherit
	FILE_PROPERTY
		redefine
			dialog_ok
		end

create
	make

feature -- Access

	il_version: STRING
			-- Il version to use if we create a new key file.

feature -- Update

	set_il_version (a_version: like il_version) is
			-- Set `il_version' to `a_version'.
		require
			a_version_ok: a_version /= Void and then not a_version.is_empty
		do
			il_version := a_version
		ensure
			il_version_set: il_version = a_version
		end


feature {NONE} -- Actions

	dialog_ok (a_dial: EV_FILE_OPEN_DIALOG) is
			-- If dialog is closed with ok.
		local
			l_file: RAW_FILE
			l_key_generator: IL_KEY_GENERATOR
		do
			check
				il_version_set: il_version /= Void and then not il_version.is_empty
			end
			Precursor {FILE_PROPERTY}(a_dial)
			create l_file.make (value.to_string_8)
			if not l_file.exists and l_file.is_creatable then
				create l_key_generator
				l_key_generator.generate_key (value.to_string_8, il_version)
			end
		end

end
