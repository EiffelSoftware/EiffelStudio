indexing
	description: "Retrieve information on specific feature (used to display tooltips in VS)"
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_RETRIEVER

inherit
	COMPLETION_ENGINE

create
	make

feature -- Access

	found_item: FEATURE_DESCRIPTOR
			-- Retrieved feature

feature -- Basic Operations

	find (target: STRING; use_overloading: BOOLEAN) is
			-- Find `target' in current context
		local
			l_targets: LIST [STRING]
			l_target_type: TYPE
			l_lookup_name: STRING
		do
			found := False
			found_item := Void
			l_targets := target.split ('.')
			qualified_call := False
			Inst_context.set_cluster (class_i.cluster)
			if feature_i /= void then
				if l_targets.count = 1 then
					feature_table.search (l_targets.first)
					if feature_table.found then
						create found_item.make_with_class_i_and_feature_i (class_i, feature_table.found_item)
						found := True
					else
						found_item := completion_feature (target)
						found := found_item /= Void
					end
				else
					if l_targets.last.is_empty then
						l_targets.finish
						l_targets.remove
					end
					l_targets.finish
					l_lookup_name := l_targets.item
					l_targets.remove
					l_target_type := target_type (l_targets.first)
					if l_target_type /= void and then not l_target_type.is_void then
						l_targets.start
						l_targets.remove
						feature_table := recursive_lookup (l_target_type, l_targets, feature_table)
						if feature_table /= void then
							feature_table.search (l_lookup_name)
							if feature_table.found then
								create found_item.make_with_class_i_and_feature_i (class_i, feature_table.found_item)
								found := True
							end
						end
					end
				end
			else
				if l_targets.count = 1 then
					found_item := completion_feature (l_targets.first)
					found := found_item /= Void
				end
			end
		ensure then
			locals_reset: locals.is_empty
			arguments_reset: arguments.is_empty			
		end

end -- class FEATURE_INFORMATION
