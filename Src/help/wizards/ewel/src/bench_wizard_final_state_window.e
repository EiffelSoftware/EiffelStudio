indexing
	description	: "Template for the last state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			cancel
		end

feature -- Basic operations

	cancel is
			-- User	has pressed the cancel button
		do
			write_bench_notification_cancel
		end

	add_common_parameters (map_list: LINKED_LIST [TUPLE [STRING, STRING]]) is
			-- Add the common parameters to the replacement pattern.
		local
			current_time: WEL_SYSTEM_TIME
			tuple: TUPLE [STRING, STRING]
			project_name: STRING
			project_name_lowercase: STRING
			project_name_uppercase: STRING
		do
				-- Add the project name.
			project_name := wizard_information.project_name
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME>", 1)
			tuple.put (project_name, 2)
			map_list.extend (tuple)

				-- Add the project name (in uppercase)
			project_name_uppercase := clone (project_name)
			project_name_uppercase.to_upper
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME_UPPERCASE>", 1)
			tuple.put (project_name_uppercase, 2)
			map_list.extend (tuple)

				-- Add the project name (in lowercase)
			project_name_lowercase := clone (project_name)
			project_name_lowercase.to_lower
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME_LOWERCASE>", 1)
			tuple.put (project_name_lowercase, 2)
			map_list.extend (tuple)

				-- Add the project location
			create tuple.make
			tuple.put ("<FL_LOCATION>", 1)
			tuple.put (wizard_information.location, 2)
			map_list.extend (tuple)

				-- Add the date for indexing clause.
			create current_time.make_by_current_time
			create tuple.make
			tuple.put ("<FL_DATE>", 1)
			tuple.put (
				"$Date: "+current_time.year.out+"/"+current_time.month.out+"/"+current_time.day.out+" "+
				current_time.hour.out+":"+current_time.minute.out+":"+current_time.second.out+" $", 2)
			map_list.extend (tuple)
		end

end -- class BENCH_WIZARD_FINAL_STATE_WINDOW

