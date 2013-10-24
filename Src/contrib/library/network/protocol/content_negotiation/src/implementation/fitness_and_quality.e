note
	description: "FITNESS_AND_QUALITY. Object holding a fitness/quality values."
	date: "$Date$"
	revision: "$Revision$"

class
	FITNESS_AND_QUALITY

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make

feature -- Initialization

	make (a_fitness: INTEGER; a_quality: REAL_64)
			-- Create an object with `a_fitness' and `a_quality'
		do
			fitness := a_fitness
			quality := a_quality
			create {STRING_8} entity.make_empty
		ensure
			fitness_assigned : fitness = a_fitness
			quality_assigned : quality = a_quality
			entity_empty: entity.is_empty
		end

feature -- Access

	fitness: INTEGER

	quality: REAL_64

	entity: READABLE_STRING_8
			-- optionally used
			-- empty by default
			--| Could be a mime type, an encoding, ...

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (entity)
			Result.append (" (")
			Result.append ("quality=" + quality.out)
			Result.append (" ; fitness=" + fitness.out)
			Result.append (" )")
		end

feature -- Element Change

	set_entity (a_entity: READABLE_STRING_8)
			-- set `entity' with `a_entity'	
		do
			entity := a_entity
		ensure
			entity_assigned : entity.same_string (a_entity)
		end

feature -- Comparision

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if fitness = other.fitness then
				Result := quality < other.quality
			else
			   Result := fitness < other.fitness
			end
		end
note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

