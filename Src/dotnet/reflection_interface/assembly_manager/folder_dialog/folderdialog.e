indexing
	Generator: "Eiffel Emitter 2.2b"
	external_name: "FolderDialog"

external class
	FOLDERDIALOG

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use FolderDialog"
		end

feature -- Access

	frozen last_folder: STRING is
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

end -- class FOLDERDIALOG
