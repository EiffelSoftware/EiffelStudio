note
	description: "Summary description for {ECF}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECF

feature {NONE} -- Initialization

	make (a_name: STRING)
		do
			name := a_name
			create {ARRAYED_LIST [STRING]} clusters.make (5)
			clusters.compare_objects

			create {ARRAYED_LIST [STRING]} tests_clusters.make (5)
			tests_clusters.compare_objects

			create {ARRAYED_LIST [STRING]} libraries.make (5)
			libraries.compare_objects
			syntax := "standard"
			uuid := "0000-0000-0000-0000"
		end

feature -- Access

	uuid: STRING

	name: STRING

	clusters: LIST [STRING]

	tests_clusters: LIST [STRING]

	libraries: LIST [STRING]

	syntax: STRING

	is_voidsafe: BOOLEAN

feature -- Element change

	set_uuid (s: like uuid)
		do
			uuid := s
		end

	set_syntax (s: like syntax)
		do
			syntax := s
		end

	set_is_voidsafe (b: like is_voidsafe)
		do
			is_voidsafe := b
		end

feature -- Visitor

	process (v: ECF_VISITOR)
		do
			v.process_ecf (Current)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
