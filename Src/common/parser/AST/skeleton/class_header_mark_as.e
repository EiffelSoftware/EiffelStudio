indexing
	description: "Objects that presents Eiffel class header marker."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_HEADER_MARK_AS

inherit
	AST_EIFFEL

create
	make

feature{NONE} -- Initialization

	make (f_as, e_as, d_as, s_as, ex_as: KEYWORD_AS) is
			-- Use `f_as'(fronzen), `e_as'(expanded), `d_as'(deferred),
			-- `s_as'(separate), `ex_as'(external)
			-- to create a CLASS_HEADER_MARKER_AS object.
		do
			frozen_keyword := f_as
			expanded_keyword := e_as
			deferred_keyword := d_as
			separate_keyword := s_as
			external_keyword := ex_as
		ensure
			frozen_keyword_set: frozen_keyword = f_as
			expanded_keyword_set: expanded_keyword = e_as
			deferred_keyword_set: deferred_keyword = d_as
			separate_keyword_set: separate_keyword = s_as
			external_keyword_set: external_keyword = ex_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
		do
			v.process_class_header_mark_as (Current)
		end

feature -- Attribute

	frozen_keyword,
	expanded_keyword,
	deferred_keyword,
	separate_keyword,
	external_keyword: KEYWORD_AS
		-- Possible keywords that can appear in a class header marker

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
		do
			Result := is_equal (other)
		end

feature -- Location

	start_location: LOCATION_AS is
		do
		end

	end_location: LOCATION_AS is
		do
		end

end
