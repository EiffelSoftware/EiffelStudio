note
	description: "Summary description for {APPLICATION_ECF}."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_ECF

inherit
	ECF
		redefine
			make,
			process
		end

create
	make

feature {NONE} -- Implementation

	make (a_name: STRING)
		do
			Precursor (a_name)
			concurrency := "none"
			root_class := "ROOT_CLASS"
			root_feature := "make"
		end

feature -- Access

	is_console_application: BOOLEAN

	concurrency: STRING

	root_cluster: detachable STRING

	root_class: STRING

	root_feature: STRING

	executable_name: detachable STRING

	root_info: TUPLE [cluster: like root_cluster; class_name: like root_class; feature_name: like root_feature]
		do
			Result := [root_cluster, root_class, root_feature]
		end

feature -- Element change

	set_concurrency (s: like concurrency)
		do
			concurrency := s
		end

	set_is_console_application (b: BOOLEAN)
		do
			is_console_application := b
		end

	set_root_info (a_cluster: detachable STRING; a_class, a_feature: STRING)
		do
			root_cluster := a_cluster
			root_class := a_class
			root_feature := a_feature
		end

	set_executable_name (s: like executable_name)
		do
			executable_name := s
		end

feature -- Visitor

	process (v: ECF_VISITOR)
		do
			v.process_application_ecf (Current)
		end

end
