indexing
	description: "Class responsible for loading a model ..."
	date: "$Date$"
	revision: "$Revision$"

class
	MODEL_HTML

inherit 

	CONSTANTS

	ONCES

feature -- loading a model

load_model(name_model : STRING ) is
	require
		name_model_not_void : name_model/= Void
	local
		file_name : FILE_NAME
		file : PLAIN_TEXT_FILE	
		st : STRING
		error_fi : BOOLEAN
	do
--		if not error_fi then	
--		!! file_name.make
--		file_name.extend(Environment.html_resources)
--		file_name.extend(name_model)
--		!! file.make (file_name)
--		if file.exists then
--			file.open_read
--			!! model.make
--			from
--			until
--				file.end_of_file
--			loop
--				file.read_line
--				st := clone (file.last_string)
--				model.extend(st)
--			end
--		end
--		file.close
--		else
--			Windows.error(Windows.main_graph_window, "E41", "" )
--		end
--		rescue
--			Windows.add_message ("The model for html_cluster_chart is not available",
--						1)
--			if file.is_open_read then file.close end
--			if not error_fi then
--				error_fi := TRUE
--				retry
--			end	
	end

	model : LINKED_LIST [ STRING ]




end -- class MODEL_HTML
