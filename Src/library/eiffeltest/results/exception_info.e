indexing
	description:
		"Records that store information about thrown exceptions"

	status:	"See note at end of class"
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

end -- class EXCEPTION_INFO

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
