indexing
	description: "Component to let the user create queries."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_QUERY_EDITOR

inherit
	EB_FEATURE_EDITOR
		redefine
			adapt
		end

feature -- Access

	type: STRING is
			-- Full type as string.
		do
			Result := type_selector.code
		end

feature -- Element change

	set_type (a_type: STRING) is
			-- Set content of `type_field' to `a_type'.
		do
			if a_type.is_empty then
				type_selector.selector.remove_text
			else
				type_selector.selector.set_text (a_type)
			end
		end

feature -- Status report

	expanded_needed: BOOLEAN
			-- Does return type have to be expanded?

feature {EB_QUERY_COMPOSITION_WIZARD} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True'.
		do
			expanded_needed := True
			type_selector.enable_expanded_needed
		ensure
			expanded_needed_set: expanded_needed
		end

feature -- Adaptation

	adapt (other: EB_FEATURE_EDITOR) is
			-- Set with `other'.
		local
			qe: EB_QUERY_EDITOR
		do
			Precursor (other)
			qe ?= other
			if qe /= Void then
				type_selector.set_from_other (qe.type_selector)
				if type_selector.expanded_needed then
					enable_expanded_needed
				end
			end
		end

feature {EB_FEATURE_EDITOR} -- Implementation

	type_selector: EB_TYPE_SELECTOR

end -- class EB_QUERY_EDITOR
