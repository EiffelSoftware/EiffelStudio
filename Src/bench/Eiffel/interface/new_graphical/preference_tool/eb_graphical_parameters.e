indexing
	description: "DANGER: Experimental Class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_PARAMETERS
inherit
	EB_PARAMETERS
		redefine
			users, add_user,
			modified_resources, add_modified_resource,
			update
		end

creation
	make

feature -- Access

	users: LINKED_LIST [RESOURCE_USER] is

		do
			Result := Graphical_resources.users
		end	

	add_user (u: RESOURCE_USER) is

		do
			Graphical_resources.add_user (u)
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is

		do
			Result := Graphical_resources.modified_resources
		end

	add_modified_resource (mr: CELL2 [RESOURCE, RESOURCE]) is

		do
			Graphical_resources.add_modified_resource (mr)
		end

	update is
		do
			Graphical_resources.update
		end

feature -- Resources

	windows_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("text_on_windows",
				Graphical_resources.font, Graphical_resources.foreground_color)
		end

	normal_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("normal text",
				Graphical_resources.text_font, Graphical_resources.text_foreground_color)
		end

	default_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("default text",
				Graphical_resources.default_text_font, Graphical_resources.default_text_color)
		end

	comment_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("comments",
				Graphical_resources.comment_font, Graphical_resources.comment_color)
		end

	string_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("string text",
				Graphical_resources.string_text_font, Graphical_resources.string_text_color)
		end

	class_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("class id",
				Graphical_resources.class_font, Graphical_resources.class_color)
		end

	cluster_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("custer id",
				Graphical_resources.cluster_font, Graphical_resources.cluster_color)
		end

	feature_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds  ("feature id",
				Graphical_resources.feature_font, Graphical_resources.feature_color)
		end

	object_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("object id",
				Graphical_resources.object_font, Graphical_resources.object_color)
		end

	error_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("error text",
				Graphical_resources.error_font, Graphical_resources.error_color)
		end

	breakable_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("breakable text",
				Graphical_resources.breakable_font, Graphical_resources.breakable_color)
		end

	keyword_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("keyword id",
				Graphical_resources.keyword_font, Graphical_resources.keyword_color)
		end

	symbol_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("symbol id",
				Graphical_resources.symbol_font, Graphical_resources.symbol_color)
		end

	html_text: EB_FORMAT_RESOURCE is
		once
			Create Result.make_from_olds ("html text",
				Graphical_resources.html_font, Graphical_resources.html_color)
		end

	text_background_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.text_background_color)
		end

	bkground_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.background_color)
		end

	progress_bar_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.progress_bar_color)
		end

	highlight_line_background_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.highlight_line_background_color)
		end

	highlight_line_foreground_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.highlight_line_foreground_color)
		end

	stop_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.stop_color)
		end

	focus_label_color: EB_COLOR_RESOURCE is
		once
			Create Result.make_from_old (Graphical_resources.focus_label_color)
		end

end -- class EB_GRAPHICAL_PARAMETERS
