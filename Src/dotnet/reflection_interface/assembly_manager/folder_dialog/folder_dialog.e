indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "FolderDialog"
	assembly: "FolderDialog", "5.0.0.1", "neutral", "e9f5a09cba5bb9f5"

external class
	FOLDER_DIALOG

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use FolderDialog"
		end

feature -- Access

	frozen last_folder: SYSTEM_STRING is
		external
			"IL field signature :System.String use FolderDialog"
		alias
			"LastFolder"
		end

feature -- Basic Operations

	frozen ask_for_folder is
		external
			"IL signature (): System.Void use FolderDialog"
		alias
			"AskForFolder"
		end

	frozen set_starting_folder (a_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use FolderDialog"
		alias
			"SetStartingFolder"
		end

end -- class FOLDER_DIALOG
