;# $Id: tsort.pl 78389 2004-11-30 00:17:17Z manus $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log$
;# Revision 1.1  2004/11/30 00:17:18  manus
;# Initial revision
;#
;# Revision 3.0  1993/08/18  12:10:28  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# The topological sort is performed using the following algorithm:
;#
;# We have a list of successors for each item; makefile dependencies of
;# the form 'a b: c d' means successors(a) = successors(b) = { c, d }.
;# From that input, we derive a number of precursors for each item.
;# In our simple example above, c and d both have two precursors and
;# a and b have none. Items with no precursors are called outsiders
;# and are left in a pool. The sort is then initiated and will continue
;# until all the items have been sorted or a cycle is found...
;#
;# Outsiders are ready to be sorted; since the topological sort is a partial
;# order, an external criterion is needed to choose one item among the ones
;# in the pool. That item is assigned a number, and the number of precursors
;# for the remaining items is updated (by following the successors of the
;# sorted item and decrementing the value for each successor). Among those,
;# if any item reaches a precursor count of zero, it becomes an outsider.
;#
;# The algorithm ends when the outsider pool is empty. If it becomes empty and
;# some items remain unsorted, then there is one or more cycles among them.
;# One way to outline that cycle first extract all those items whose precursor
;# count is minimal then visit their dependency graph to find the cycle,
;# extract only those items belonging to the cycle into the outsiders set and
;# resume the main processing stream.
;#
#
# Topological sort of Makefile dependencies with cycle enhancing.
#

package tsort;

# Perform the topological sort of the items and outline cycles.
sub main'tsort {
	local(*Succ, *Prec) = @_;	# Tables of succesors and predecessors
	local(@Out);				# The outsider set
	local(@keys);				# Current active precursors
	local($item);				# Item to sort

	for (@keys = keys %Prec; @keys || @Out; @keys = keys %Prec) {
		&resync;			# Resynchronize outsiders
		if (@Out == 0) {	# Cycle detected
			&extract_cycle(*Prec, *Succ);
			next;
		}
		$item = shift(@Out);	# Sort current item (don't care which one)
		&sort($item);		# Update internal structures
	}
}

# Resynchronize the outsiders stack (those items that have no more precursors).
# If the outsiders stack becomes empty, then there is a cycle.
sub resync {
	foreach $target (keys %Prec) {
		if ($Prec{$target} == 0) {
			delete $Prec{$target};		# We're done with this item
			push(@Out, $target);		# Ready to be sorted
		}
	}
}

# Sort item
sub sort {
	local($item) = @_;
	print "(ok) $item\n" if $main'opt_d && !$Cycle;
	print "(fx) $item\n" if $main'opt_d && $Cycle;
	foreach $succ (split(' ', $Succ{$item})) {
		# The test for definedness is necessary, since when a cycle is found,
		# one item is forced out of %Prec. If we had the guarantee of no
		# cycle, the the test would not be necessary and no decrementation
		# could go past 0.
		$Prec{$succ}-- if defined $Prec{$succ};
	}
}

# Extract cycle... We look through the %Prec array and find all those items
# with the same lowest value. Those are a cycle, so we dump them, and make
# them new outsiders by resetting their count to 0.
sub extract_cycle {
	local(*Prec, *Succ) = @_;
	local($item) = (&sort_by_value(*Prec))[0];
	local($min) = $Prec{$item};			# Minimum value
	local($key, $value);
	local(%candidate);	# Superset of the cycle we found
	warn "    Cycle found for:\n";
	$Cycle++;
	while (($key, $value) = each %Prec) {
		$candidate{$key}++ if $value == $min;
	}
	local(%state);		# State of visited nodes (1 = cycle, -1 = dead)
	local($CYCLE) = 1;	# Possible member of a cycle
	local($DEAD) = -1;	# Dead end, no cycling possible
	foreach $key (keys %candidate) {
		last if $CYCLE == &visit($key, $Succ{$key});
	}
	while (($key, $value) = each %candidate) {
		next unless $state{$key} == $CYCLE;
		$Prec{$key} = 0;			# Members of cycle are new outsiders
		warn "\t(#$Cycle) $key\n";
	}
	local(%involved);	 # Items involved in the cycle...
	while (($key, $value) = each %state) {
		$involved{$key}++ if $state{$key} == $CYCLE;
	}
	&outline_cycle(*Succ, *involved);
}

sub outline_cycle {
	local(*Succ, *member) = @_;
	local($key, $value);
	local($depends);
	local($unit);
	warn "    Cycle involves:\n";
	while (($key, $value) = each %Succ) {
		next unless $member{$key};
		$depends = '';
		foreach $item (split(' ', $value)) {
			$depends .= "$item " if $member{$item};
		}
		$unit = $main'shmaster{"\$$key"};
		$unit =~ s/\s+$//;
		$unit = '?' if $unit eq '';
		warn "\t($unit) $key: $depends\n";
	}
}

# Visit a tree node, following all its successors, until we find a cycle.
# Return $CYCLE if the exploration of the node leaded to a cycle, $DEAD
# otherwise.
sub visit {
	local($node, $children) = @_;	# A node and its children
	# If we have already visited the node, return the status value attached
	# to it.
	return $state{$node} if $state{$node};
	$state{$node} = $CYCLE;			# Assume member of cycle
	local($all_dead) = 1;			# Set to 0 if at least one cycle found
	foreach $child (split(' ', $children)) {
		$all_dead = 0 if $CYCLE == &visit($child, $Succ{$child});
	}
	$state{$node} = $DEAD if $all_dead;
	$state{$node};
}

# Sort associative array by value
sub sort_by_value {
	local(*x) = @_;
	sub _by_value { $x{$a} <=> $x{$b}; }
	sort _by_value keys %x;
}

package main;

1;
