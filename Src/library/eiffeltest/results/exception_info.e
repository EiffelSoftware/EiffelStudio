indexing
	description:
		"Records that store information about thrown exceptions"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	EXCEPTION_INFO

feature -- Access

	type: STRING
			-- Type of exception
			
	origin_class: STRING
			-- Class where exception was thrown

	origin_feature: STRING
			-- Feature where exception was thrown

	tag_name: STRING
			-- Tag name of violated assertion

feature -- Status report

	complete: BOOLEAN is
			-- Is exception information complete?
		do
			Result := (type /= Void and then not type.is_empty) and
				(origin_class /= Void and then not origin_class.is_empty) and
				(origin_feature /= Void and then 
				not origin_feature.is_empty) and
				(tag_name /= Void and then not tag_name.is_empty)
		end

feature -- Status setting

	set_type (s: STRING) is
			-- Set exception type to `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			type := s
		ensure
			type_set: type = s
		end

	set_origin_class (s: STRING) is
			-- Set class where exception was thrown to `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			origin_class := s
		ensure
			origin_class_set: origin_class = s
		end

	set_origin_feature (s: STRING) is
			-- Set feature where exception was thrown to `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			origin_feature := s
		ensure
			origin_feature_set: origin_feature = s
		end

	set_tag_name (s: STRING) is
			-- Set tag name of violated assertion to `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
		do
			tag_name := s
		ensure
			tag_name_set: tag_name = s
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EXCEPTION_INFO

